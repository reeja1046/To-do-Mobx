import 'package:flutter/material.dart';
import 'package:machine_test/home/model/model.dart';

GridView buildGridView(List<User> users) {
  return GridView.builder(
    itemCount: users.length,
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      crossAxisSpacing: 15.0,
      mainAxisSpacing: 15.0,
    ),
    itemBuilder: (BuildContext context, int index) {
      return buildGridTile(
        context,
        users[index].name,
        users[index].profileImage,
      );
    },
  );
}

GridTile buildGridTile(BuildContext context, String name, String userImage) {
  return GridTile(
    child: GestureDetector(
      onTap: () {
        _showProfileDialog(context, name, userImage);
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(10.0)),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage(userImage),
              ),
              const SizedBox(height: 20),
              Text(
                name.toString(),
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 18.0,
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

void _showProfileDialog(BuildContext context, String name, String userImage) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        content: SizedBox(
          width: MediaQuery.of(context).size.width * 0.7,
          height: MediaQuery.of(context).size.height * 0.28,
          child: SingleChildScrollView(
            child: Column(
              children: [
                _buildDialogContentRow(userImage, name),
                _buildSwitchRow('UPI'),
                _buildSwitchRow('Cash'),
                _buildSwitchRow('Later'),
              ],
            ),
          ),
        ),
        actions: <Widget>[
          Center(child: _buildTextFieldContainer()),
          _buildActionButtons(context),
        ],
      );
    },
  );
}

Widget _buildDialogContentRow(String userImage, String name) {
  return Column(
    children: [
      CircleAvatar(radius: 20, backgroundImage: NetworkImage(userImage)),
      Text(name),
    ],
  );
}

Widget _buildSwitchRow(String text) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(text),
      Switch(
        value: false,
        onChanged: (value) {},
      ),
    ],
  );
}

Widget _buildTextFieldContainer() {
  return Container(
    height: 40,
    width: 240,
    decoration: BoxDecoration(
      color: Colors.lightBlue[100],
      borderRadius: BorderRadius.circular(8),
    ),
    child: const Center(
      child: Text(
        '2500',
        style: TextStyle(color: Colors.black),
      ),
    ),
  );
}

Widget _buildActionButtons(BuildContext context) {
  return Row(
    children: [
      TextButton(
        onPressed: () => Navigator.of(context).pop(),
        child: const Text('Save'),
      ),
      TextButton(
        onPressed: () => Navigator.of(context).pop(),
        child: const Text('Cancel'),
      ),
    ],
  );
}
