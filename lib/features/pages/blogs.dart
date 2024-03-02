import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../widgets/post_widget.dart';
import '../widgets/posting_widget.dart';

class BlogsPage extends StatefulWidget {
  final String userId;
  const BlogsPage({Key? key, required this.userId}) : super(key: key);
  @override
  State<BlogsPage> createState() => _BlogsPage();
}

class _BlogsPage extends State<BlogsPage> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue ,
          title: Text('Blogs',style: TextStyle(color: Colors.white),),
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: getPostsStream(),
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
                  PostingWidget(userId: widget.userId),
                  ListView(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children:
                        snapshot.data!.docs.map((DocumentSnapshot document) {
                      Map<String, dynamic> data =
                          document.data()! as Map<String, dynamic>;
                      return PostWidget(
                        postText: data['postText'],
                        like: data['like'],
                        date: data['date'],
                        postImageUrl: data['postImageUrl'],
                        userImage: data['userImage'],
                        username: data['username'],
                        postId: document.id,
                        liker: data['liker'],
                        userId: widget.userId,
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

  Stream<QuerySnapshot> getPostsStream() {
    return FirebaseFirestore.instance
        .collection('post')
        .orderBy('postingDate',
            descending: true)// Change 'name' to the key you want to order by
        .snapshots();
  }
}
