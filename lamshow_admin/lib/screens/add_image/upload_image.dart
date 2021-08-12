import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class UploadImage extends StatefulWidget {
  static String routeName = "upload";
  @override
  _UploadState createState() => _UploadState();
}

class _UploadState extends State<UploadImage> {
  var loading = false;
  var uuid = Uuid();
  final ImagePicker _imagePicker = ImagePicker();
  File? _image;
  TextEditingController textEditingController = TextEditingController();
  Future<void> _pickImage(ImageSource source) async {
    PickedFile? selected = await _imagePicker.getImage(source: source);
    setState(() {
      if (selected != null) {
        _image = File(selected.path);
      }
    });
  }

  uploadImage(String text, var image) async {
    if (image != null) {
      final ref = FirebaseStorage.instance.ref().child(uuid.v4());
      await ref.putFile(image);
      final url = await ref.getDownloadURL();
      await FirebaseFirestore.instance.collection("lams").add({
        "image": url,
        "title": text,
      });
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: _image == null
          ? FloatingActionButton(
              onPressed: () {
                _pickImage(ImageSource.gallery);
              },
              child: Icon(Icons.add),
            )
          : null,
      body: !loading
          ? Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _image == null
                        ? Text("No image Selected.")
                        : Image.file(
                            _image!,
                            height: 400,
                          ),
                    if (_image != null)
                      TextFormField(
                        controller: textEditingController,
                      ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          loading = true;
                        });
                        uploadImage(
                          textEditingController.text,
                          _image,
                        );
                      },

                      // onPressed: () {},
                      child: Text("Upload"),
                    ),
                  ],
                ),
              ),
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(child: CircularProgressIndicator()),
              ],
            ),
    );
  }
}
