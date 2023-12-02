import 'package:flutter/material.dart';
import 'package:machine_test/home/model/model.dart';

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

ElevatedButton buildRoundButton(
    IconData icon, BuildContext context, VoidCallback onPressed) {
  return ElevatedButton(
    onPressed: onPressed, // Call the provided onPressed function here
    style: ElevatedButton.styleFrom(
      shape: const CircleBorder(),
      padding: const EdgeInsets.all(16.0),
    ),
    child: Icon(icon),
  );
}

void showAlertDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Color.fromARGB(255, 224, 240, 252),
        title: const Center(child: Text('Enter visitor details')),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTextBoxWithIcon(
                hintText: 'Visitor name', prefixIcon: Icons.person),
            SizedBox(height: 20),
            _buildTextBoxWithIcon(
                hintText: 'Sponsor name', prefixIcon: Icons.person),
          ],
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Save'),
          ),
        ],
      );
    },
  );
}

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
        _showProfileDialog(
            context, name, userImage); // Show alert dialog on tap
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
  bool isSwitched = false;
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        content: Container(
          width: MediaQuery.of(context).size.width * 0.7,
          height: MediaQuery.of(context).size.height * 0.28,
          child: SingleChildScrollView(
            child: Column(
              children: [
                CircleAvatar(
                    radius: 20, backgroundImage: NetworkImage(userImage)),
                Text(name),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('UPI'),
                    SizedBox(
                        width:
                            10), // Add some space between the text and the switch
                    Switch(
                      value: isSwitched,
                      onChanged: (value) {
                        // Update the state when the switch is toggled
                        // setState(() {
                        //   isSwitched = value;
                        // });
                      },
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Cash'),
                    SizedBox(width: 10),
                    Switch(
                      value: isSwitched,
                      onChanged: (value) {},
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Later'),
                    SizedBox(width: 10),
                    Switch(
                      value: isSwitched,
                      onChanged: (value) {},
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        actions: <Widget>[
          Container(
            height: 40,
            width: 240,
            decoration: BoxDecoration(
              color: Colors.lightBlue[100],
              borderRadius: BorderRadius.circular(8),
            ),
            child: TextField(
              decoration: InputDecoration(
                border: InputBorder.none,
              ),
            ),
          ),
          Row(
            children: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Save'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Cancel'),
              ),
            ],
          ),
        ],
      );
    },
  );
}

Widget buildAlphabetRow() {
  final List<String> alphabets = List.generate(
      26, (index) => String.fromCharCode('A'.codeUnitAt(0) + index));

  return Container(
    padding: const EdgeInsets.all(8.0),
    alignment: Alignment.bottomCenter,
    child: SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: alphabets.map((letter) {
          return Padding(
            padding: const EdgeInsets.all(5.0),
            child: Container(
              decoration: const BoxDecoration(color: Colors.white),
              height: 35,
              width: 35,
              child: ElevatedButton(
                onPressed: () {},
                child: Text(letter),
              ),
            ),
          );
        }).toList(),
      ),
    ),
  );
}

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
