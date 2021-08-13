import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:lamshow_admin/models/lams.dart';
import 'package:lamshow_admin/screens/add_image/upload_image.dart';
import 'package:lamshow_admin/screens/detail_page/detail_page.dart';

import 'package:provider/provider.dart';

import '../../db.dart';
import '../authentication_service.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = "/home_screen";
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  File? _image;

  final picker = ImagePicker();

  Future getImage() async {
    final pickerImage = await picker.pickImage(source: ImageSource.camera);

    setState(
      () {
        if (pickerImage != null) {
          _image = File(pickerImage.path);
        } else {
          print('No Image Selected');
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var db = DatabaseService();
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, UploadImage.routeName);
              },
              icon: Icon(Icons.add)),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.search),
          ),
        ],
      ),
      drawer: Drawer(
          child: SafeArea(
        child: ListView(
          children: [
            ListTile(
              title: Text("log Out"),
              onTap: () {
                context.read<AuthenticationService>().signOut(context);
              },
            )
          ],
        ),
      )),
      body: Center(
        child: _image == null
            ? StreamBuilder<List<Lams>>(
                stream: db.getLams(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                      ),
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, DetailPage.routeName,
                                arguments: {
                                  "index": index,
                                  "list": snapshot.data,
                                });
                          },
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            elevation: 2,
                            child: Container(
                              padding: EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Expanded(
                                    child: Hero(
                                      tag: snapshot.data![index].title!,
                                      child: Image.network(
                                        snapshot.data![index].image!,
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Text(
                                        snapshot.data![index].title!,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                      itemCount: snapshot.data!.length,
                    );
                  }
                  return SizedBox();
                })
            : Image.file(_image!),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          getImage();
        },
        child: Icon(Icons.camera),
      ),
    );
  }
}
