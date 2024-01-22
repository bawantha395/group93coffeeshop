import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileScreen extends StatefulWidget {
  final Map<String, dynamic> userData;

  EditProfileScreen({required this.userData});

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController _displayNameController = TextEditingController();
  final TextEditingController _shippingAddressController = TextEditingController();
  String? _profilePictureUrl;

  @override
  void initState() {
    super.initState();
    _displayNameController.text = widget.userData['displayName'] ?? '';
    _shippingAddressController.text = widget.userData['shippingAddress'] ?? '';
    _profilePictureUrl = widget.userData['profilePictureUrl'];
  }

  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? pickedImage = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      // Upload the image to Firebase Storage in the "profile_picture" folder
      Reference storageReference = FirebaseStorage.instance.ref().child('profile_picture/${DateTime.now().millisecondsSinceEpoch}');
      UploadTask uploadTask = storageReference.putFile(File(pickedImage.path));

      await uploadTask.whenComplete(() async {
        // Get the download URL
        String downloadURL = await storageReference.getDownloadURL();

        // Update the state with the new profile picture URL
        setState(() {
          _profilePictureUrl = downloadURL;
        });
      });
    }
  }

  Future<void> _updateProfile() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await FirebaseFirestore.instance.collection('users').doc(user.uid).update({
        'displayName': _displayNameController.text,
        'shippingAddress': _shippingAddressController.text,
        'profilePictureUrl': _profilePictureUrl,
      });

      // Trigger a rebuild of the widget tree to reflect the changes in the UI
      setState(() {});

      Navigator.pop(context); // Go back to the profile screen after updating
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _updateProfile,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            GestureDetector(
              onTap: _pickImage,
              child: CircleAvatar(
                radius: 80,
                backgroundImage: _profilePictureUrl != null
                    ? NetworkImage(_profilePictureUrl!) as ImageProvider<Object>?
                    : AssetImage('images/profile_image.png') as ImageProvider<Object>?,
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _displayNameController,
              decoration: InputDecoration(labelText: 'Display Name'),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _shippingAddressController,
              decoration: InputDecoration(labelText: 'Shipping Address'),
            ),
          ],
        ),
      ),
    );
  }
}
