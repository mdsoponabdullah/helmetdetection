import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../global/common/toast.dart';
import '../image_upload_handle/image_upload_control.dart';
import 'cachedNetworkImage.dart';
import 'circular_image_box.dart';

class PostingWidget extends StatefulWidget {
  final String userId;

  const PostingWidget({super.key, required this.userId});
  @override
  _PostingWidgetState createState() => _PostingWidgetState();
}

class _PostingWidgetState extends State<PostingWidget> {
  String userImageUrl =
      "https://media.istockphoto.com/id/1300845620/vector/user-icon-flat-isolated-on-white-background-user-symbol-vector-illustration.jpg?s=612x612&w=0&k=20&c=yBeyba0hUkh14_jgv1OKqIH0CCSWU_4ckRkAoy2p73o=";
  FirebaseFirestore db = FirebaseFirestore.instance;
  late String postId;

  TextEditingController postTextController = TextEditingController();
  File? _image;
  final imgPicker = ImagePicker();

  File? file;
  String? imageUrl;
  bool isImageUploading = false;

  @override
  void initState() {
    // TODO: implement initState
    getUser();
    super.initState();
  }

  Future selectFile() async {
    isImageUploading = true;
    try {
      final picker = ImagePicker();
      final pickedImage = await picker.pickImage(source: ImageSource.gallery);
      //.getImage(source: ImageSource.gallery);
      if (pickedImage != null) {
        final pickedImageFile = File(pickedImage.path);
        setState(() {
          _image = pickedImageFile;
          file = pickedImageFile;
        });
        if (kDebugMode) {
          print("Image selected successfully");
        }
        if (kDebugMode) {
          print(file);
        }
        ImageUploadControl obj = ImageUploadControl();
        imageUrl = await obj.controlImage(file);

        print(" $imageUrl");
        isImageUploading = false;
        CommonMessage.showToast(message: "Image is Uploaded successfully");
        db.collection("post").doc(postId).set({
          "postImageUrl": imageUrl,
        }, SetOptions(merge: true));

        // uploadFile();
      } else {
        if (kDebugMode) {
          print("User canceled image selection or encountered an issue.");
        }
      }
    } catch (err) {
      if (kDebugMode) {
        print("Exception occurred:");
      }
      if (kDebugMode) {
        print(err);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(2, 10, 2, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
              elevation: 5,
              child: SizedBox(
                width: double.infinity,

                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,

                  children: [
                    const SizedBox(
                      height: 20,
                    ),

                    CircularImageBox(
                      imageUrl: userImageUrl??"https://",
                      size: 200,
                    ),


                    const SizedBox(
                      height: 30,
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.grey[300], // Change this color to your desired background color
                            borderRadius: BorderRadius.circular(10.0), // Set the border radius
                          ),
                          child: TextFormField(


                            controller: postTextController,
                            decoration: const InputDecoration(

                              hintText: 'What\'s on your mind?',
                              border: InputBorder.none,
                            ),
                            maxLines: null,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            onPressed: selectFile,
                            icon: const Icon(
                              Icons.image,

                              color: Colors.blue,
                              size: 40,
                            ),
                          ),
                          TextButton(
                              onPressed: summitPost,
                              child: Container(
                                width: 80,
                                height: 30,
                                decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(
                                      20.0), // Set border radius here
                                ),
                                child: const Center(
                                  child: Text(
                                    "Post",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                              ))
                        ],
                      ),
                    )
                  ],
                ),
              )),
          _image != null
              ? Center(
                  child: SizedBox(
                    width: double.infinity, // Define the width
                    height: 300, // Define the height
                    child: Image.file(_image!, fit: BoxFit.cover),
                  ),
                )
              : Container(),
          const SizedBox(
            height: 40,
          ),
        ],
      ),
    );
  }

  Future<void> summitPost() async {
    if (postTextController.text == "" && file == null) {
      CommonMessage.showToast(message: "Your does not provide any data");
      return;
    }
    var data;

    final docRef = db.collection("users").doc(widget.userId);
    docRef.get().then(
      (DocumentSnapshot doc) async {
        data = doc.data() as Map<String, dynamic>;
        CommonMessage.showToast(message: "succesfull");

        final postData = {
          "postText": postTextController.text,
          "userId": widget.userId,
          "postImageUrl": imageUrl,
          "date": DateFormat('MMMM d, y').format(DateTime.now()),
          "postingDate": DateTime.now(),
          "like": 0,
          "username": data['username'],
          "userImage": data['image'],
          "liker": []
        };

        try {
          DocumentReference documentRef =
              await db.collection("post").add(postData);
          postId = documentRef.id;
          print("post submission is successfull");
          postTextController.text = "";
          _image = null;
          setState(() {});
        } catch (e) {
          print("error : $e");
        }
      },
      onError: (e) => print("Error getting document: $e"),
    );
  }

  Future<void> getUser() async {
    var data;
    final docRef = db.collection("users").doc(widget.userId);
    docRef.get().then(
      (DocumentSnapshot doc) async {
        data = doc.data() as Map<String, dynamic>;
        //  CommonMessage.showToast(message: "succesfull");
        setState(() {
          userImageUrl = data['image'];
        });
      },
      onError: (e) => print("Error getting document: $e"),
    );
  }
}
