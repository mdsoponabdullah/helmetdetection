import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

import '../../global/common/toast.dart';

class ImageUploadControl {
   String? imageUrl;


   Future<String?> controlImage( File? file) async {


    if (file == null) return null;
    //Import dart:core
    String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();

    /*Step 2: Upload to Firebase storage*/
    //Install firebase_storage
    //Import the library

    //Get a reference to storage root
    Reference referenceRoot = FirebaseStorage.instance.ref();
    Reference referenceDirImages = referenceRoot.child('images');

    //Create a reference for the image to be stored
    Reference referenceImageToUpload =
        referenceDirImages.child("image$uniqueFileName.png");

    //Handle errors/success
    try {
      //Store the file
      await referenceImageToUpload.putFile(File(file!.path));
      //Success: get the download URL
       imageUrl = await referenceImageToUpload.getDownloadURL();
       print("sopon $imageUrl");
      //CommonMessage.showToast( message: imageUrl);

      return imageUrl;
    } catch (error) {
      if (kDebugMode) {
        print(error);
      }
      //Some error occurred
    }
    return null;
  }
}
