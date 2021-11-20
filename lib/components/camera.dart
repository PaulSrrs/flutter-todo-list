import 'dart:io';
import 'package:doing/services/shared_preferences.service.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:doing/constants/shared_preferences.dart';
import 'package:doing/constants/colors.dart';

class TakePictureScreen extends StatefulWidget {
  const TakePictureScreen({Key? key}) : super(key: key);

  @override
  TakePictureScreenState createState() => TakePictureScreenState();
}

/// StatefulWidget that will search in our gallery or use the camera
/// to pick a picture and display it in a circleAvatar and save it in the
/// shared_preferences
class TakePictureScreenState extends State<TakePictureScreen> {
  File? _image;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  /// Methods that preloads the image if she is already existent
  void loadData() async {
    String? imagePath = await SharedPreferencesService().getString(AppSharedPreferences.profileImage);

    if (imagePath != null) {
      setState(() {
        _image = File(imagePath);
      });
    }
  }

  /// Methods that pick the picture from both gallery or camera
  /// dependant on the [source] argument
  getImgFromSource({required ImageSource source}) async {
    final Directory dir = await getApplicationDocumentsDirectory();
    final String path = dir.path;
    XFile? image = await ImagePicker().pickImage(source: source);
    if (image != null) {
      await File(image.path).copy('$path/image1.png');
      SharedPreferencesService().setString(
          AppSharedPreferences.profileImage, '$path/image1.png');
      setState(() {
        _image = File(image.path);
      });
      if (imageCache != null) {
        imageCache!.clearLiveImages();
        imageCache!.clear();
      }
    }
  }

  /// Widget that make choose the user between the gallery or the camera
  void showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Wrap(
              children: <Widget>[
                ListTile(
                    leading: const Icon(Icons.photo_library),
                    title: const Text('Photo Library'),
                    onTap: () {
                      getImgFromSource(source: ImageSource.gallery);
                      Navigator.of(context).pop();
                    }),
                ListTile(
                  leading: const Icon(Icons.photo_camera),
                  title: const Text('Camera'),
                  onTap: () {
                    getImgFromSource(source: ImageSource.camera);
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          );
        });
  }

  /// builder
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Center(
            child: GestureDetector(
              onTap: () {
                showPicker(context);
              },
              child: CircleAvatar(
                radius: 55,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: _image != null
                      ? Image.file(_image!, width: 100, height: 100, fit: BoxFit.cover)
                      : Container(
                          width: 100,
                          height: 100,
                          color: AppColors.primary,
                          child: const Icon(
                            Icons.camera_alt,
                            color: AppColors.primaryLight,
                          )
                        ),
                ),
              ),
            )
        ),
      ],
    );
  }
}
