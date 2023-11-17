// image_utils.dart

import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageUtils {
  static Future pickImage(
      BuildContext context, Function(File) onImageSelected) async {
    try {
      if (Platform.isIOS) {
        return showCupertinoModalPopup<ImageSource>(
          context: context,
          builder: (context) => CupertinoActionSheet(
            actions: [
              CupertinoActionSheetAction(
                onPressed: () async {
                  Navigator.of(context).pop();
                  final image =
                      await ImagePicker().pickImage(source: ImageSource.camera);
                  if (image == null) return;
                  final imageTemporary = File(image.path);

                  onImageSelected(imageTemporary);
                },
                child: Text('Camera'),
              ),
              CupertinoActionSheetAction(
                onPressed: () async {
                  Navigator.of(context).pop();

                  Navigator.of(context).pop();
                  final image = await ImagePicker()
                      .pickImage(source: ImageSource.gallery);
                  if (image == null) return;
                  final imageTemporary = File(image.path);

                  onImageSelected(imageTemporary);
                },
                child: Text('Gallery'),
              )
            ],
          ),
        );
      } else {
        return showModalBottomSheet(
          context: context,
          builder: (context) => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.camera_alt),
                title: Text('Camera'),
                onTap: () async {
                  Navigator.of(context).pop();
                  final image =
                      await ImagePicker().pickImage(source: ImageSource.camera);
                  if (image == null) return;
                  final imageTemporary = File(image.path);

                  onImageSelected(imageTemporary);
                },
              ),
              ListTile(
                leading: Icon(Icons.image),
                title: Text('Gallery'),
                onTap: () async {
                  Navigator.of(context).pop();
                  final image = await ImagePicker()
                      .pickImage(source: ImageSource.gallery);
                  if (image == null) return;
                  final imageTemporary = File(image.path);

                  onImageSelected(imageTemporary);
                },
              ),
            ],
          ),
        );
      }
    } on PlatformException catch (e) {
      print("failed to pick image: $e");
    }
  }
}
