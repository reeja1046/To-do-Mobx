import 'package:flutter/material.dart';
import 'package:machine_test/home/view_model/home_viewmodel.dart';
import 'home/view/homescreen.dart';

final viewModel = HomeViewModel();
void main() {
  viewModel.fetchUsers();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "To Do App",
      home: HomeScreen(),
    );
  }
}
