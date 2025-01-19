import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:birthday_reminder/model/Friend.dart'; // Make sure this exists

class FriendForm extends StatefulWidget {
  bool isFormVisible;
  final VoidCallback onClose; // Callback when the form is closed
  FriendForm({super.key, required this.isFormVisible, required this.onClose});


  @override
  _FriendFormState createState() => _FriendFormState();
}

class _FriendFormState extends State<FriendForm> {
  final _formKey = GlobalKey<FormState>();
  File? _image;
  final _nameController = TextEditingController();
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      Friend friend = Friend(name: _nameController.text);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Friend created: ${friend.name}"), duration: Duration(seconds: 3),),
      );
      Navigator.of(context).pop();  // Close the dialog after submission
    }
  }

  void _closeForm() {
    widget.onClose();
  }

  @override
  Widget build(BuildContext context) {
    return !widget.isFormVisible ?  Container() : Dialog(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,  // Make dialog size adjust based on content
            children: [
                Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  icon: Icon(Icons.close),
                  onPressed: _closeForm, // Close the form when the cross icon is clicked
                ),
              ),
                TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _pickImage,
                child: Text('Pick Image'),
              ),
              SizedBox(height: 20),
              if (_image != null)
                Image.file(
                  _image!,
                  height: 150,
                  width: 150,
                  fit: BoxFit.cover,
                ),
              SizedBox(height: 20),

              ElevatedButton(
                onPressed: _submitForm,
                child: Text('Submit'),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
