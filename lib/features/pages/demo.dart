import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:helmetdetection/features/pages/blogs.dart';
import 'package:helmetdetection/features/pages/rating_page.dart';
import 'package:helmetdetection/features/pages/video_page.dart';

import '../../global/common/toast.dart';
import '../user_auth/firebase_auth_implementation/firebase_auth_services.dart';
import '../widgets/circular_image_box.dart';
import '../widgets/icon_card_widget.dart';
import '../widgets/loading_widget.dart';
import 'latitute_longitute.dart';
import 'map_page.dart';


class Demo extends StatefulWidget {
  final String userId;

  const Demo({super.key, required this.userId});

  @override
  State<Demo> createState() => _Demo();
}

class _Demo extends State<Demo> {

  bool loadingIncomplete = true;

  @override
  void initState() {



    super.initState();
    // Delay execution of build method
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        loadingIncomplete = false;
      });
    });
  }

  void mySnacbarMessage(comment, context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(comment)),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          elevation: 10,
          title: const Text(
            "Demo  Page",
            style: TextStyle(color: Colors.white),
          ),
        ),
        body:StreamBuilder<DocumentSnapshot>(
            stream:FirebaseFirestore.instance
                .collection('users')
                .doc(widget.userId)
                .snapshots(),

            builder: (context,snapshot)
            {

              if (!snapshot.hasData) {
                return const CircularProgressIndicator(); // Loading indicator while fetching data
              }
              var userData = snapshot.data!.data() as Map<String, dynamic>;
              return loadingIncomplete
            ? const Loading()
            : SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 30,
                ),
                CircularImageBox(
                  imageUrl:userData['image'] ?? "https://",
                  size: 200,
                ),
                const SizedBox(
                  height: 20,
                ),
                Center(
                    child: Text(
                      "Username : "+ userData['username'],
                      style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue),
                    )),
                Center(
                    child: Text(
                      "Email : "+ userData['email'],
                      style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue),
                    )),
                const SizedBox(
                  height: 30,
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconTextCard(
                        title: 'Blogs',
                        iconData: Icons.post_add,
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      BlogsPage(userId: widget.userId??"")));
                        },
                      ),
                      IconTextCard(
                        title: 'Detection',
                        iconData: Icons.search,
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      BlogsPage(userId: widget.userId)));
                        },
                      ),
                    ]),
                const SizedBox(
                  height: 14,
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconTextCard(
                        title: 'Location',
                        iconData: Icons.map,
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const CurrentLocation()));
                        },
                      ),
                      IconTextCard(
                        title: 'Video',
                        iconData: Icons.video_call,
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => Video()));
                        },
                      ),
                    ]),
                const SizedBox(
                  height: 14,
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconTextCard(
                        title: 'Rate Our App',
                        iconData: Icons.star,
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      RatingPage(userId: widget.userId)));
                        },
                      ),
                      IconTextCard(
                        title: 'Crystal Report',
                        iconData: Icons.book,
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      RatingPage(userId: widget.userId)));
                        },
                      ),
                    ]),
                const SizedBox(
                  height: 14,
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconTextCard(
                        title: 'weather',
                        iconData: Icons.sunny,
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      RatingPage(userId: widget.userId)));
                        },
                      ),
                      IconTextCard(
                        title: 'Log Out',
                        iconData: Icons.logout,
                        onTap: () {
                          FirebaseAuth.instance.signOut();
                          Navigator.pushNamed(context, "/login");
                          CommonMessage.showToast(
                              message: "User is signed out successfully");
                        },
                      ),
                    ]),
                const SizedBox(
                  height: 50,
                ),
              ],
            )
        );
            } )

    );
  }


  // void getUser() {
  //   // [START listen_to_realtime_updates_listen_for_updates]
  //
  //   final docRef = FirebaseFirestore.instance.collection("users").doc(
  //       widget.userId);
  //   docRef.snapshots().listen(
  //
  //
  //         (event) {
  //
  //
  //
  //       userData = event.data();
  //      // print("current data: $userData");
  //
  //
  //           userName = event.data()?['username']??"";
  //           imageUrl = event.data()?['image']??"";
  //           email = event.data()?['email']??"";
  //           isEmailVerified= event.data()?['verified']??false;
  //           if(isEmailVerified==true) {
  //             setState(() {
  //
  //           });
  //           }
  //
  //
  //     },
  //
  //     onError: (error) => print("Listen failed: $error"),
  //   );
  // }
}