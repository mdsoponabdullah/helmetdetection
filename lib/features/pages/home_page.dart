import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:helmetdetection/features/pages/blogs.dart';
import 'package:helmetdetection/features/pages/rating_page.dart';
import 'package:helmetdetection/features/pages/video_page.dart';
import 'package:helmetdetection/features/pages/weather_page.dart';
import 'package:helmetdetection/features/pages/weather_page1.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../global/common/toast.dart';
import '../json_data/all_dision_and_district.dart';
import '../user_auth/firebase_auth_implementation/firebase_auth_services.dart';
import '../widgets/circular_image_box.dart';
import '../widgets/icon_card_widget.dart';
import '../widgets/loading_widget.dart';
import 'blogs2.dart';
import 'crystal_report.dart';
import 'demo.dart';
import 'demo1.dart';
import 'graph_ql.dart';
import 'helmet_detect_page.dart';
import 'latitute_longitute.dart';
import 'map_page.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class HomePage extends StatefulWidget {
  final String userId;

  const HomePage({super.key, required this.userId});

  @override
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  bool loadingIncomplete = true;
  bool reFresh = false;
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
            "Home",
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: StreamBuilder<DocumentSnapshot>(
            stream: FirebaseFirestore.instance
                .collection('users')
                .doc(widget.userId)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const CircularProgressIndicator(); // Loading indicator while fetching data
              }
              var userData = snapshot.data!.data() as Map<String, dynamic>;
              return loadingIncomplete
                  ? const Loading()
                  : userData?['verified'] == false
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                              const Center(
                                child: Text("Verify Your Email"),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              GestureDetector(
                                  onTap: () async {
                                    reFresh = true;
                                    FirebaseAuthServices obj =
                                        FirebaseAuthServices();

                                    await obj
                                        .checkEmailVerification(widget.userId);
                                    // isEmailVerified = FirebaseAuthServices.emailVerified;

                                    Future.delayed(Duration(seconds: 1)).then(
                                        (value) =>
                                            {reFresh = false, setState(() {})});
                                    setState(() {});
                                  },
                                  child: Container(
                                    height: 45,
                                    width: 100,
                                    decoration: BoxDecoration(
                                      color: Colors.blue,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Center(
                                      child: Center(
                                        child: reFresh == true
                                            ? const CircularProgressIndicator(
                                                color: Colors.white,
                                              )
                                            : const Text(
                                                "Refresh",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                      ),
                                    ),
                                  ))
                            ])
                      : SingleChildScrollView(
                          child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(
                              height: 30,
                            ),
                            CircularImageBox(
                              imageUrl: userData['image'] ?? "https://",
                              size: 200,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            AnimatedTextKit(
                              animatedTexts: [
                                TypewriterAnimatedText(
                                  "Username : " + userData['username'],
                                  textStyle:  TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromRGBO(
                                          Random().nextInt(256),
                                          Random().nextInt(256),
                                          Random().nextInt(256),
                                          1)),
                                ),
                                TypewriterAnimatedText(
                                  "Division: " + userData['selectedDivision'] ??
                                      "",
                                  textStyle:  TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromRGBO(
                                          Random().nextInt(256),
                                          Random().nextInt(256),
                                          Random().nextInt(256),
                                          1)),
                                ),
                                TypewriterAnimatedText(
                                  "District : " +
                                          userData['selectedDistrict'] ??
                                      "",
                                  textStyle:  TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromRGBO(
                                          Random().nextInt(256),
                                          Random().nextInt(256),
                                          Random().nextInt(256),
                                          1)),
                                ),
                                TypewriterAnimatedText(
                                  "Upozela: " + userData['selectedDistrict']??""
                                      ,
                                  textStyle:  TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromRGBO(
                                          Random().nextInt(256),
                                          Random().nextInt(256),
                                          Random().nextInt(256),
                                          1)),
                                ),
                                TypewriterAnimatedText(
                                  "Date Of Birth : " +
                                          userData['dateOfBirth'] ??
                                      "",
                                  textStyle:  TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromRGBO(
                                          Random().nextInt(256),
                                          Random().nextInt(256),
                                          Random().nextInt(256),
                                          1)),
                                ),
                                TypewriterAnimatedText(
                                  "Email : " + userData['email'],
                                  textStyle:  TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromRGBO(
                                          Random().nextInt(256),
                                          Random().nextInt(256),
                                          Random().nextInt(256),
                                          1)),
                                ),
                                TypewriterAnimatedText(
                                  "Date Of Birth : " +
                                          userData['dateOfBirth'] ??
                                      "",
                                  textStyle:  TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromRGBO(
                                          Random().nextInt(256),
                                          Random().nextInt(256),
                                          Random().nextInt(256),
                                          1)),
                                ),
                              ],
                              onTap: () {
                                print("Tap Event");
                              },
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  IconTextCard(
                                    title: 'Blogs',
                                    iconData: Icons.post_add,
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => BlogsPage(
                                                  userId: widget.userId)));
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
                                                  const HelmetDetectionPage()));
                                    },
                                  ),
                                ]),
                            const SizedBox(
                              height: 14,
                            ),
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  IconTextCard(
                                    title: 'Location',
                                    iconData: Icons.location_pin,
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
                                    iconData: Icons.video_collection,
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => Video()));
                                    },
                                  ),
                                ]),
                            const SizedBox(
                              height: 14,
                            ),
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  IconTextCard(
                                    title: 'Rate Our App',
                                    iconData: Icons.star,
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => RatingPage(
                                                  userId: widget.userId)));
                                    },
                                  ),
                                  IconTextCard(
                                    title: 'Crystal Report',
                                    iconData: Icons.book,
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => const CrystalReport(
                                                  )));
                                    },
                                  ),
                                ]),
                            const SizedBox(
                              height: 14,
                            ),
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  IconTextCard(
                                    title: 'weather',
                                    iconData: Icons.sunny,
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => WeatherPage1()));
                                    },
                                  ),
                                  IconTextCard(
                                    title: 'Log Out',
                                    iconData: Icons.logout,
                                    onTap: () async {
                                       SharedPreferences prefs = await SharedPreferences.getInstance();

                                      await prefs.remove('email');

                                      FirebaseAuth.instance.signOut();
                                      Navigator.pushNamed(context, "/login");
                                      CommonMessage.showToast(
                                          message:
                                              "User is signed out successfully");
                                    },
                                  ),
                                ]),
                            const SizedBox(
                              height: 20,
                            ),   Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.center,
                                children: [
                                  IconTextCard(
                                    title: 'Lat&Long',
                                    iconData: Icons.location_city,
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => const LatituteLogitute()));
                                    },
                                  ),

                               IconTextCard(
                                    title: 'GraphQL',
                                    iconData: Icons.auto_graph,
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>  CountryListPage()));
                                    },
                                  ),

                                ]),
                            const SizedBox(
                              height: 50,
                            ),  Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.center,
                                children: [
                                  IconTextCard(
                                    title: 'Lat&Long',
                                    iconData: Icons.location_city,
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => const LatituteLogitute()));
                                    },
                                  ),

                               IconTextCard(
                                    title: 'GraphQL',
                                    iconData: Icons.auto_graph,
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>  BlogsPage2(userId: widget.userId)));
                                    },
                                  ),

                                ]),
                            const SizedBox(
                              height: 50,
                            ),
                          ],
                        ));
            }));
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
