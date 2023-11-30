import 'package:flutter/material.dart';
import 'package:machine_test/home/view/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: Stack(
        children: [
          Positioned.fill(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: buildGridView(),
            ),
          ),
          Positioned(
            right: 12.0,
            bottom: MediaQuery.of(context).size.height / 2 - 90.0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                buildRoundButton(Icons.person),
                const SizedBox(height: 16.0),
                buildRoundButton(Icons.attach_money),
              ],
            ),
          ),
          buildAlphabetRow(),
        ],
      ),
    );
  }
}
