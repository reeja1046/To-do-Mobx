import 'package:flutter/material.dart';
import 'package:machine_test/home/model/user.dart';
import 'package:machine_test/home/view/gridview.dart';

//Builds the two round button on the homescreen
ElevatedButton buildRoundButton(
    IconData icon, BuildContext context, VoidCallback onPressed) {
  return ElevatedButton(
    onPressed: onPressed,
    style: ElevatedButton.styleFrom(
      shape: const CircleBorder(),
      padding: const EdgeInsets.all(16.0),
    ),
    child: Icon(icon),
  );
}

//Builds the alphabet button at the bottom of the home screen
Widget buildAlphabetRow(List<User> allUsers, BuildContext context) {
  final List<String> alphabets = List.generate(
    26,
    (index) => String.fromCharCode('A'.codeUnitAt(0) + index),
  );

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
                onPressed: () {
                  List<User> usersWithSelectedAlphabet = allUsers
                      .where(
                          (user) => user.name.startsWith(letter.toUpperCase()))
                      .toList();
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlphabetSearchGrid(
                          usersWithSelectedAlphabet: usersWithSelectedAlphabet);
                    },
                  );
                },
                child: Text(letter),
              ),
            ),
          );
        }).toList(),
      ),
    ),
  );
}
