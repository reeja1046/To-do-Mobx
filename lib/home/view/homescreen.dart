import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:machine_test/home/view/widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> names = [];
  List<String> userimage = [];

  @override
  void initState() {
    fetchNames();
    super.initState();
  }

  Future<void> fetchNames() async {
    try {
      var response = await http
          .get(Uri.parse('https://randomuser.me/api/?results=100&gender=male'));

      if (response.statusCode == 200) {
        Map<String, dynamic> data = json.decode(response.body);
        List<dynamic> results = data['results'];

        List<String> fetchedNames = [];
        List<String> fetchedProfilePic = [];

        for (var user in results) {
          String firstName = user['name']['first'];
          String lastName = user['name']['last'];
          fetchedNames.add('$firstName $lastName');
          String userPic = user['picture']['thumbnail'];
          fetchedProfilePic.add(userPic);
        }

        setState(() {
          names = fetchedNames;
          userimage = fetchedProfilePic;
          print(fetchedNames.length);
        });
      } else {
        print('Failed to fetch data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 209, 233, 255),
      appBar: buildAppBar(),
      body: Stack(
        children: [
          Positioned.fill(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: buildGridView(names, userimage),
            ),
          ),
          Positioned(
            right: 12.0,
            bottom: MediaQuery.of(context).size.height / 2 - 90.0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                buildRoundButton(Icons.person, context),
                const SizedBox(height: 16.0),
                buildRoundButton(Icons.attach_money, context),
              ],
            ),
          ),
          buildAlphabetRow(),
        ],
      ),
    );
  }
}
