import 'package:camera/camera.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
//import 'package:tflite/tflite.dart';
import 'package:tflite_v2/tflite_v2.dart';
import 'dart:io';
import 'package:path/path.dart';

class HelmetDetectionPage extends StatefulWidget {
  const HelmetDetectionPage({super.key});

  //final List<CameraDescription>? cameras;

  @override
  _HelmetDetectionPage createState() => _HelmetDetectionPage();
}

class _HelmetDetectionPage extends State<HelmetDetectionPage> {
  List? _outputs;
  File? _image;
  bool _loading = false;
  final imgPicker = ImagePicker();

  UploadTask? task;
  File? file;
  File? _photo;
  final ImagePicker _picker = ImagePicker();
  File? _pickedImage;
  dynamic imgDownload;
  dynamic label;
  //var late urlDownload;

  static UploadTask? uploadBytes(String destination, Uint8List data) {
    try {
      final ref = FirebaseStorage.instance.ref(destination);

      return ref.putData(data);
    } on FirebaseException catch (e) {
      return null;
    }
  }

  static UploadTask? uploadingFile(String destination, File file) {
    try {
      final ref = FirebaseStorage.instance.ref(destination);

      return ref.putFile(file);
    } on FirebaseException catch (e) {
      return null;
    }
  }

  Future selectFile() async {
    try {
      final picker = ImagePicker();
      final pickedImage = await picker.pickImage(source: ImageSource.gallery);
      final pickedImageFile = File(pickedImage!.path);
      setState(() {
        _image = pickedImageFile;
        file = pickedImageFile;
      });
      print("complete select image ");
      print(file);
      classifyImage(_image);
    } catch (err) {
      print("exception");
      print(err);
    }
  }

  Future uploadFile() async {
    if (_image == null) return;

    final fileName = basename(_image!.path);
    final destination = 'files//$fileName';
    print("file = " + fileName);
    //file = fileName as File?;

    task = uploadingFile(destination, file!);
    setState(() {});

    if (task == null) return;

    final snapshot = await task!.whenComplete(() {});
    imgDownload = await snapshot.ref.getDownloadURL();
    //imgDownload = urlDownload;

    print('Download-Link: $imgDownload');
    sendData();
  }

  sendData() async {
    int like = 0;
    var date = DateTime.now();
    print(imgDownload);
    final FirebaseAuth _auth = FirebaseAuth.instance;
    var currentUser = _auth.currentUser;
    CollectionReference _collectionRef =
    FirebaseFirestore.instance.collection("detection");
    var email = currentUser?.email;
    print(currentUser?.email);
    print(_collectionRef);
    return _collectionRef
        .doc()
        .set({
      "email": email,
      "img": imgDownload,
      "like": like,
      "date": date,
      "label": label,
      "likeBy": []
    })
        .whenComplete(() => print("complete"))
        .catchError((error) => print("somethimg is wrong. $error"));
  }

  @override
  void initState() {
    super.initState();
    _loading = true;

    loadModel().then((value) {
      setState(() {
        _loading = false;
      });
    });
  }

  loadModel() async {
    await Tflite.loadModel(
      labels: "assets/labels.txt",
      model: "assets/model_unquant.tflite",
      numThreads: 2,
    );
  }

  classifyImage(File? image) async {
    var output = await Tflite.runModelOnImage(
        path: image!.path,
        imageMean: 0.0,
        imageStd: 255.0,
        numResults: 5,
        threshold: 0.2,
        asynch: true);
    setState(() {
      _loading = false;
      _outputs = output;
      print("output\n");
      //print(_outputs![0]['label']);
      label = _outputs![0]['label'];
      print(_outputs);
    });
  }

  @override
  void dispose() {
    Tflite.close();
    super.dispose();
  }

  void pickimage() async {
    var imgGallery = await imgPicker.pickImage(source: ImageSource.camera);
    setState(() {
      _image = File(imgGallery!.path);
    });
    classifyImage(_image);
  }

  void pickImageGallery() async {
    var imgGallery = await imgPicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = File(imgGallery!.path);
    });
    classifyImage(_image);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      pickimage();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                    ),
                    icon: const Icon(
                      // <-- Icon
                      Icons.photo_camera,
                      size: 30,
                    ),
                    label: const Text('Camera'), // <-- Text
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      selectFile();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                    ),
                    icon: const Icon(
                      // <-- Icon
                      Icons.photo,
                      size: 30,
                    ),
                    label: const Text('Gallery'), // <-- Text
                  ),
                ],
              ),
              _loading
                  ? SizedBox(
                height: MediaQuery.of(context).size.height * .9,
                child: const Center(
                  child: Text(
                    'Select an image...',
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              )
                  : Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * .8,
                  height: MediaQuery.of(context).size.height * 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      _image == null
                          ? Container()
                          : Card(
                        color: Colors.black,
                        elevation: 45,
                        child: Image.file(_image!,
                            fit: BoxFit.cover,
                            height:
                            MediaQuery.of(context).size.height *
                                .6),
                      ),
                      const SizedBox(height: 10),
                      _image == null
                          ? Container(
                        color: Colors.black,
                        child: const Text(
                          'No image selected',
                          style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      )
                          : _outputs != null
                          ? Card(
                        color: Colors.black54,
                        margin: const EdgeInsets.all(8),
                        elevation: 10,
                        child: Column(
                          children: [
                            Container(
                              width: MediaQuery.of(context)
                                  .size
                                  .width *
                                  .9,
                              child: Column(
                                children: [
                                  Text(
                                    _outputs![0]["label"]
                                        .substring(1) +
                                        "\n" +
                                        _outputs![0]
                                        ["confidence"]
                                            .toString()
                                            .substring(0, 5),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 30,
                                      fontWeight:
                                      FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                            ElevatedButton.icon(
                              onPressed: () {
                                uploadFile();
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.black,
                              ),
                              icon: const Icon(
                                // <-- Icon
                                Icons.upload_sharp,
                                size: 40,
                              ),
                              label: const Text(
                                  'Upload'), // <-- Text
                            ),
                          ],
                        ),
                      )
                          : Container()
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}