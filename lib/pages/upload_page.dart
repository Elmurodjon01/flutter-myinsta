import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UploadPage extends StatefulWidget {
  const UploadPage({super.key});

  @override
  State<UploadPage> createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  bool isLoading = false;
  var _captionController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  File? _image;

  _imgFromGallery() async {
    XFile? image =
        await _picker.pickImage(source: ImageSource.gallery, imageQuality: 50);
    setState(() {
      _image = File(image!.path);
    });
  }

  _imgFromCamera() async {
    XFile? cameraImage =
        await _picker.pickImage(source: ImageSource.camera, imageQuality: 50);
    setState(() {
      _image = File(cameraImage!.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    var _responsiveHeight = MediaQuery.of(context).size.height;
    var _responsiveWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Upload',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.drive_folder_upload,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Container(
              height: _responsiveHeight,
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: _responsiveWidth,
                    color: Colors.grey.withOpacity(0.4),
                    child: _image == null
                        ? Center(
                            child: IconButton(
                              onPressed: () {
                                //TODO bottomsheet
                                Scaffold.of(context).showBottomSheet(
                                  (context) {
                                    return Container(
                                      height: 130,
                                      width: double.infinity,
                                      child: Column(
                                        children: [
                                          ListTile(
                                            leading:
                                                const Icon(Icons.image_sharp),
                                            title: const Text('Pick a photo'),
                                            onTap: () {
                                              _imgFromGallery();
                                            },
                                          ),
                                          ListTile(
                                            leading: const Icon(Icons.camera),
                                            title: const Text('Take a photo'),
                                            onTap: () {
                                              _imgFromCamera();
                                            },
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                );
                              },
                              icon: const Icon(Icons.add_a_photo),
                              iconSize: 50,
                              color: Colors.grey,
                            ),
                          )
                        : Stack(
                            children: [
                              Image.file(
                                _image!,
                                width: double.infinity,
                                height: double.infinity,
                                fit: BoxFit.cover,
                              ),
                              Container(
                                width: double.infinity,
                                color: Colors.black12,
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        setState(() {
                                          _image = null;
                                        });
                                      },
                                      icon: const Icon(
                                        Icons.highlight_remove,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 10, right: 10, top: 10),
                    child: TextField(
                      controller: _captionController,
                      keyboardType: TextInputType.multiline,
                      minLines: 1,
                      maxLines: 5,
                      decoration: const InputDecoration(
                        hintText: 'Caption',
                        hintStyle: TextStyle(
                          fontSize: 17,
                          color: Colors.black38,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }
}
