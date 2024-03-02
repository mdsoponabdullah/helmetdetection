import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:date_time_picker/date_time_picker.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:helmetdetection/features/pages/email_verification_page.dart';

import 'package:helmetdetection/features/pages/home_page.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';

import '../../../../global/common/toast.dart';
import '../../../color/parse_color.dart';
import '../../../image_upload_handle/image_upload_control.dart';
import '../../../json_data/all_dision_and_district.dart';
import '../../../pages/demo.dart';
import '../../../widgets/custom_text_field_widget.dart';
import '../../firebase_auth_implementation/firebase_auth_services.dart';

import 'login_page.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPage();
}

class _SignUpPage extends State<SignUpPage> {

  String userId="";
  String dateOfBirth="";
  var authcrd;
  String username = '';
  bool isUsernameUnique = true;
  File? _image;
  final imgPicker = ImagePicker();

  File? file;
  String? imageUrl;
  bool isImageUploading = false;
  bool _isSignUp = false;
  final FirebaseAuthServices _auth = FirebaseAuthServices();
  String? selectedDivision;
  String? selectedDistrict;
  String? selectedUpozela;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _dateOfBirthController = TextEditingController();

  void placeInBdHandle( String selectedDivision,
  String selectedDistrict,
  String selectedUpozela){

    this.selectedDivision=selectedDivision;
    this.selectedDistrict=selectedDistrict;
    this.selectedUpozela=selectedUpozela;


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


          FirebaseFirestore.instance.collection("users").doc(_emailController.text).set({
          "image": imageUrl,
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

  Future<void> checkUsernameUniqueness(String username) async {
    //print(username);
    final snapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('username', isEqualTo: username)
        .get();

    setState(() {
      isUsernameUnique = snapshot.docs.isEmpty;
    });
  }



  @override
  Widget build(BuildContext context) {

    void _signUp() async {
      final SharedPreferences prefs = await SharedPreferences.getInstance();

        setState(() {
          _isSignUp = true;
        });

        // String username = _usernameController.text;
        String email = _emailController.text;
        String password = _passwordController.text;
        User? user = await _auth.signUpWithEmailAndPassword(email, password);

        setState(() {
          _isSignUp = false;
        });
        if (user != null) {
          var authCredential = user;
          print(authCredential!.uid);
          final FirebaseFirestore _firestore = FirebaseFirestore.instance;

          userId = user.uid;

          await _firestore.collection('users').doc(_emailController.text).set({
            'username': username,
            'email': _emailController.text,
            'image': imageUrl??"",
            'selectedDivision': selectedDivision,
            'selectedDistrict': selectedDistrict,
            'selectedUpozela': selectedUpozela,
           'dateOfBirth':dateOfBirth,
            'verified':false,

          });
          authcrd = authCredential.uid;

          if (authCredential.uid.isNotEmpty) {
            await prefs.setString('email', _emailController.text);

            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HomePage(userId: _emailController.text,),
                ));
          } else {
            Fluttertoast.showToast(msg: "Something is wrong");
          }
          CommonMessage.showToast(message: "User is Created succefully");


        } else {
          CommonMessage.showToast(message: "Some error is occured");
        }

    }

    return Container(
      /*decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/register.png'), fit: BoxFit.cover),
      ),*/
      child: Scaffold(
        appBar: AppBar(
          //backgroundColor: Colors.transparent,
          backgroundColor: Colors.blue,
          title: const Text(
            "Sign Up",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          elevation: 0,
        ),
        backgroundColor: Colors.white10,
        body: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            padding: EdgeInsets.only(
                right: 35,
                left: 35,
                top: MediaQuery.of(context).size.height * 0.12),
            child: Container(
              alignment: Alignment.center,
              child: Center(
                child: Column(children: [
                  Image(image: AssetImage('assets/helmet1.png')),
                  CustomTextField(
                    controller: _userNameController,
                    hintText: "User Name",
                    iconData: Icons.person,
                    onChanged: (value) {
                      print("sopon");
                      setState(() {
                        username = value;
                        print(value);
                      });
                      checkUsernameUniqueness(value);
                    },
                  ),
                  const SizedBox(height: 16.0),
                  if (username == "")
                    const Text(
                      'enter an unique user name',
                      style: TextStyle(color: Colors.white),
                    )
                  else if (isUsernameUnique)
                    const Text(
                      'Username is unique!',
                      style: TextStyle(color: Colors.green),
                    )
                  else
                    const Text(
                      'Username is already taken!',
                      style: TextStyle(color: Colors.red),
                    ),
                  Container(
                    //width: MediaQuery.of(context).size.width * 0.8
                    padding: EdgeInsets.only(left: 5),

                    decoration: BoxDecoration(
                      color: ParseColor.parseColor("#E7DFEC"),
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: DateTimePicker(
                      style: const TextStyle(color: Colors.black, fontSize: 15),
                      initialValue: '',
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                      icon: const Icon(
                        Icons.event,
                        size: 40,
                        color: Colors.black45,
                      ),
                      dateLabelText: 'BirthDate',


                      onChanged: (val) => {
                        dateOfBirth=val,
                        print(val)
                      },
                      validator: (val) {

                      },
                      onSaved: (val) => {},
                    ),
                  ),


                  const SizedBox(
                    height: 30,
                  ),
                   BangladeshPlaces(callback:placeInBdHandle),
                  const SizedBox(
                    height: 30,
                  ),



                  CustomTextField(
                      controller: _emailController,
                      hintText: "Email",
                      iconData: Icons.email),
                  const SizedBox(
                    height: 30,
                  ),
                  CustomTextField(
                    hintText: "password",
                    iconData: Icons.password,
                    isPasswordField: true,
                    controller: _passwordController,
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _image != null ? Image.file(_image!) : Container(),
                      Text(imageUrl ?? ''),
                      ElevatedButton(
                        onPressed: selectFile,
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.blue),
                          padding: MaterialStateProperty.all<EdgeInsets>(
                              const EdgeInsets.all(12.0)),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.upload,
                              color: Colors.white,
                            ),
                            const SizedBox(width: 8.0),
                            _image != null
                                ? const Text('Uploaded',
                                    style: TextStyle(
                                        fontSize: 16.0, color: Colors.white))
                                : const Text('Upload Profile Picture',
                                    style: TextStyle(
                                        fontSize: 16.0, color: Colors.white)),
                          ],
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  GestureDetector(
                    onTap: () {
                      _signUp();
                    },
                    child: Container(
                      width: double.infinity,
                      height: 45,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: _isSignUp
                          ? const CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : const Center(
                              child: Text(
                              "Sign Up",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            )),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Already have an account?"),
                      const SizedBox(
                        width: 5,
                      ),
                      GestureDetector(
                          onTap: () {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const LoginPage()),
                                (route) => false);
                          },
                          child: const Text(
                            "Login",
                            style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold),
                          ))
                    ],
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                ]),
              ),
            ),
          ),
        ),
      ),
    );
  }


}
