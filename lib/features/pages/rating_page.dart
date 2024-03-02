import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../global/common/toast.dart';
import '../widgets/loading_widget.dart';

class RatingPage extends StatefulWidget {
  final String userId;
  const RatingPage({super.key, required this.userId});

  @override
  State<RatingPage> createState() => _RatingPageState();
}

class _RatingPageState extends State<RatingPage> {
  var appRating;
  late String initialRating = '0';
  bool loadingIncomplete = true;



  @override
  void initState() {
    // TODO: implement initState
    getPreviousRating();
    Future.delayed(Duration(milliseconds: 600), () {
      setState(() {
        loadingIncomplete = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
        appBar: AppBar(
          //backgroundColor: Colors.transparent,
          backgroundColor: Colors.blue,
          title: const Text(
            "Rate Our App ",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          elevation: 0,
        ),
        body:loadingIncomplete ? Loading(): Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 300.0),
              Row(mainAxisAlignment: MainAxisAlignment.center,
                children: [const Center(
                  child: Text(
                    "Rating : ",
                    style: TextStyle(
                        fontSize: 23,

                        fontWeight: FontWeight.bold,
                        color: Colors.blue),
                  )),Center(
                  child: Text(
                    initialRating,
                    style: const TextStyle(
                        fontSize: 23,

                        fontWeight: FontWeight.bold,
                        color: Colors.amber),
                  ))],),
              SizedBox(height: 30,)
              ,
              RatingBar.builder(
                initialRating: double.parse(initialRating) > 0
                    ? double.parse(initialRating)
                    : 0,
                minRating: 0,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) => const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating) {
                  appRating = rating;
                  initialRating= rating.toString();
                  print(appRating);
                  setState(() {

                  });
                },
              ),
              const SizedBox(
                height: 40,
              ),
              GestureDetector(
                onTap: rateTheApp,
                child: Container(
                    width: 120,
                    height: 45,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.blue),
                    child: const Center(
                      child: 1 == 32
                          ? CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : Text(
                              "submit",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                    )),
              ),
            ],
          ),
        ));
  }


  void rateTheApp() {
    FirebaseFirestore db = FirebaseFirestore.instance;

    final ratingData = <String, String>{
      "rating": appRating.toString(),
    };

    try {
      db.collection("appRating").doc(widget.userId).set(ratingData);
      CommonMessage.showToast(
          message: "Thanks! Successfully, You have rated our App");
    } catch (e) {
      print("Error writing document: $e");
    }
  }

  Future<void> getAverageRating() async {

    FirebaseFirestore.instance.collection("appRating").count().get().then(
          (res) => print(res.count),
      onError: (e) => print("Error completing: $e"),
    );
  }


  Future<void> getPreviousRating() async {
    try {
      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
          .collection('appRating')
          .doc(widget.userId)
          .get();

      // Access the data in the document using documentSnapshot.data() method
      if (documentSnapshot.exists) {
        // Document exists
        Map<String, dynamic> data =
        documentSnapshot.data() as Map<String, dynamic>;

        setState(() {
          //documentData = 'Document data: $data';
          initialRating = data['rating'];
        });
      } else {
        // Document does not exist
        setState(() {
          initialRating = '0';
        });
      }
    } catch (e) {
      setState(() {
        CommonMessage.showToast(message: 'Error reading document: $e');
        print(e);
      });
    }
  }
}
