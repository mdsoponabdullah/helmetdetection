
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:helmetdetection/features/widgets/comments_maker_widget.dart';
import 'package:intl/intl.dart';

import '../../global/common/toast.dart';
import 'cachedNetworkImage.dart';

class PostWidget extends StatefulWidget {
  final String postText;
  final String? postImageUrl;
  final int like;
  final String date;
  final String userImage;
  final String username;
  final String postId;
  final String userId;
  final List<dynamic> liker;

  const PostWidget({
    Key? key,
    required this.postText,
    this.postImageUrl,
    required this.date,
    required this.userImage,
    required this.username,
    required this.postId,
    required this.like,
    required this.userId,
    required this.liker,
  }) : super(key: key); // Add key parameter

  @override
  _PostWidgetState createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  FirebaseFirestore db = FirebaseFirestore.instance;
  TextEditingController commentController = TextEditingController();
  bool _showComments = false;
  bool isLike = false;

  @override
  void initState() {
    likeCheck();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
//CommonMessage.showToast(message: widget.postImageUrl??"no image");

    return Container(
      padding: const EdgeInsets.all(5),
      child: Card(
        elevation: 1,
        child: Container(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 30,
              ),
              _buildUserInfo(),
              const SizedBox(height: 10),
              Text(
                widget.postText,
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 10),
              widget.postImageUrl != null ? _buildPostImage() : Container(),
              const SizedBox(height: 10),
              _buildLikeAndCommentButton(),
              if (_showComments) ...[
                _buildCommentField(),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.only(left: 10),
                  child: CommentsMakerWidget(postId: widget.postId,),
                )
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUserInfo() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundColor: Colors.grey,
            radius: 20,
            // You can set user's profile image here
            backgroundImage: NetworkImage(widget.userImage),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.username,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                'Posted on: ' + widget.date,
                style: const TextStyle(color: Colors.grey),
              ),
            ],
          ),
          Spacer(),
        ],
      ),
    );
  }

  Widget _buildPostImage() {
    // You can customize this widget to display post images
    return Container(
      height: 200,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(10),
      ),
      child: widget.postImageUrl != null
          ? GetCachedNetworkImage(imageUrl: widget.postImageUrl!,) //Image.network(widget.postImageUrl!, fit: BoxFit.cover)
          : Container(),
    );
  }

  Widget _buildLikeAndCommentButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextButton.icon(
          onPressed: onLike,
          icon: Icon(
            Icons.thumb_up,
            color: isLike ? Colors.blue : Colors.black,
          ),
          label: Text(
            widget.liker.length.toString(),
            style: TextStyle(color: isLike ? Colors.blue : Colors.black),
          ),
        ),
        TextButton.icon(
          onPressed: () {
            setState(() {
              _showComments = !_showComments;
            });
          },
          icon: Icon(Icons.comment),
          label: Text('Comment'),
        ),
      ],
    );
  }

  Widget _buildCommentField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: TextField(
        controller: commentController,
        decoration: InputDecoration(
          hintText: 'Write a comment...',

          suffixIcon: IconButton(
            icon: Icon(Icons.send),
            onPressed:summitComment,
          ),
        ),
      ),
    );
  }


  Future<void> summitComment() async {
    var data;
    if(commentController.text=="")
    {
      CommonMessage.showToast(message: "Comments field is empty");
      return;
    }
    final docRef = db.collection("users").doc(widget.userId);
    docRef.get().then(
          (DocumentSnapshot doc) async {
        data = doc.data() as Map<String, dynamic>;
        CommonMessage.showToast(message: "succesfull");

        final commentData = {
          "commentText": commentController.text,
          "userId": widget.userId,
          "date": DateFormat('MMMM d, y').format(DateTime.now()),
          "commentingDate": DateTime.now(),
          "username": data['username'],
          "userImage": data['image'],
          "postId":widget.postId

        };

        try {
          DocumentReference documentRef =
          await db.collection("comment").add(commentData);
        //  postId = documentRef.id;
          print("post submission is successfull");
          commentController.text = "";

          setState(() {});
        } catch (e) {
          print("error : $e");
        }
      },
      onError: (e) => print("Error getting document: $e"),
    );
  }

  Future<void> likeCheck() async {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection('post').doc(widget.postId);

    await documentReference.get().then(
      (DocumentSnapshot doc) {
        final data = doc.data() as Map<String, dynamic>;

        // Update the array field
        if (data['liker'].contains(widget.userId)) {
          setState(() {
            isLike = true;
          });
        } else {
          setState(() {
            isLike = false;
          });
        }
        // ...
      },
      onError: (e) => print("Error getting document: $e"),
    );
  }

  Future<void> onLike() async {
    // Get reference to the document you want to update
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection('post').doc(widget.postId);

    DocumentSnapshot documentSnapshot =
        await documentReference.get(); //as Map<String, dynamic>;
    var data = documentSnapshot.data() as Map<String, dynamic>;
    print(data['liker']);

    // Update the array field
    if (data['liker'].contains(widget.userId) == false) {
      await documentReference.update({
        'liker': FieldValue.arrayUnion([widget.userId]),
      }).then((value) {
        print('Array updated successfully');

        setState(() {
          isLike = true;
        });
      }).catchError((error) {
        print('Failed to update array: $error');
      });
    } else {
      await documentReference.update({
        'liker': FieldValue.arrayRemove([widget.userId]),
      }).then((value) {
        print('Array updated successfully');
        setState(() {
          isLike = false;
        });
      }).catchError((error) {
        print('Failed to update array: $error');
      });
    }
  }
}
