import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../widgets/posting_widget.dart';
import 'comment_widget.dart';

class CommentsMakerWidget extends StatefulWidget {
  final String postId;
  const CommentsMakerWidget({Key? key, required this.postId}) : super(key: key);
  @override
  State<CommentsMakerWidget> createState() => _CommentsMakerWidget();
}

class _CommentsMakerWidget extends State<CommentsMakerWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(

      child: StreamBuilder<QuerySnapshot>(

          stream: getCommentsStream(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text('Something went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            }

            return SingleChildScrollView(
              child: Column(
                children: [

                  ListView(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children:
                    snapshot.data!.docs.map((DocumentSnapshot document) {
                      Map<String, dynamic> data =
                      document.data()! as Map<String, dynamic>;
                      return CommentWidget(
                        commentText: data['commentText'],

                        date: data['date'],

                        userImage: data['userImage'],
                        username: data['username'],

                        userId: widget.postId,
                      );
                    }).toList(),
                  ),
                ],
              ),
            );
          },
        ),

    );
  }

  Stream<QuerySnapshot> getCommentsStream() {
    return FirebaseFirestore.instance
        .collection('comment').where("postId", isEqualTo: widget.postId)
        // Change 'name' to the key you want to order by
        .snapshots();
  }
}
