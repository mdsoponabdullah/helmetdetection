import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:helmetdetection/features/widgets/comments_maker_widget.dart';

class CommentWidget extends StatefulWidget {
  final String commentText;
  final String date;
  final String userImage;
  final String username;

  final String userId;

  const CommentWidget({
    Key? key,
    required this.date,
    required this.userImage,
    required this.username,
    required this.userId,
    required this.commentText,
  }) : super(key: key); // Add key parameter

  @override
  _CommentWidget createState() => _CommentWidget();
}

class _CommentWidget extends State<CommentWidget> {
  @override
  Widget build(BuildContext context) {
//CommonMessage.showToast(message: widget.postImageUrl??"no image");

    return Card(
      //padding: const EdgeInsets.all(10),
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 30,
            ),
            _buildUserInfo(),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                widget.commentText,
                style: TextStyle(fontSize: 13,color: Colors.black,decorationThickness:0,),
              ),
            ),
            const SizedBox(height: 10),
          ],
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
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15,decorationThickness: 0,color: Colors.black),
              ),
              Text(
                'Posted on: ' + widget.date,
                style: const TextStyle(color: Colors.grey, fontSize: 10,decorationThickness: 0,),
              ),
            ],
          ),
          Spacer(),
        ],
      ),
    );
  }
}
