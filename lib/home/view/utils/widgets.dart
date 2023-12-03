import 'package:flutter/material.dart';

// Builds the app bar with a title and styling
AppBar buildAppBar() {
  return AppBar(
    title: const Text(
      'TODO',
      style: TextStyle(color: Colors.black),
    ),
    centerTitle: true,
    backgroundColor: Colors.white,
  );
}

// Displays an alert dialog to enter visitor details
void showAlertDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor:const Color.fromARGB(255, 224, 240, 252),
        title: const Center(child: Text('Enter visitor details')),
        content: Column( 
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTextBoxWithIcon(
                hintText: 'Visitor name', prefixIcon: Icons.person),
           const SizedBox(height: 20),
            _buildTextBoxWithIcon(
                hintText: 'Sponsor name', prefixIcon: Icons.person),
          ],
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Save'),
          ),
        ],
      );
    },
  );
}

// Builds a text form field with an icon for inputting text
Widget _buildTextBoxWithIcon(
    {required String hintText, required IconData prefixIcon}) {
  return Container(
    height: 40,
    width: 240,
    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
    ),
    child: TextFormField(
      decoration: InputDecoration(
        border: InputBorder.none,
        prefixIcon: Icon(prefixIcon),
        hintText: hintText,
      ),
    ),
  );
}
