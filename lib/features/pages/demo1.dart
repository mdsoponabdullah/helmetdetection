import 'dart:io';
import 'package:flutter/material.dart';
import 'package:tflite_v2/tflite_v2.dart';


class Detection extends StatefulWidget {
  @override
  _Detection createState() => _Detection();
}

class _Detection extends State<Detection> {
  late List _output;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    loadModel().then((value) {
      setState(() {
        _loading = false;
      });
    });
  }

  @override
  void dispose() {
    Tflite.close();
    super.dispose();
  }

  loadModel() async {
    await Tflite.loadModel(
      model: 'assets/model.tflite',
      labels: 'assets/labels.txt',
    );
  }

  classifyImage(File? image) async {
    var output = await Tflite.runModelOnImage(
      path: image!.path,
      numResults: 2,
      threshold: 0.5,
      imageMean: 127.5,
      imageStd: 127.5,
    );
    setState(() {
      _loading = false;
      _output = output!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cat or Dog Classifier'),
      ),
      body: _loading
          ? Container(
        alignment: Alignment.center,
        child: CircularProgressIndicator(),
      )
          : Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _output != null
                ? Text(
              '${_output[0]['label']}',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20.0,
              ),
            )
                : Container(),
            SizedBox(height: 20.0),
            _output != null
                ? Text(
              'Confidence: ${(_output[0]['confidence'] * 100).toStringAsFixed(2)}%',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20.0,
              ),
            )
                : Container(),
          ],
        ),
      ),
    );
  }
}
