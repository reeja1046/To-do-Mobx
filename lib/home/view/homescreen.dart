import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:machine_test/home/view/paymentdetails.dart';
import 'package:machine_test/home/view/widgets/buttons.dart';
import 'package:machine_test/home/view/widgets/gridview.dart';
import 'package:machine_test/home/view/widgets/widgets.dart';
import 'package:machine_test/home/view_model/home_viewmodel.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _viewModel = HomeViewModel();

  @override
  void initState() {
    _viewModel.fetchUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 209, 233, 255),
      appBar: buildAppBar(),
      body: Observer(
        builder: (_) {
          if (_viewModel.users.isEmpty) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Stack(
              children: [
                Positioned.fill(
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: buildGridView(_viewModel.users),
                  ),
                ),
                Positioned(
                  right: 12.0,
                  bottom: MediaQuery.of(context).size.height / 2 - 90.0,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      buildRoundButton(Icons.person, context, () {
                        showAlertDialog(context);
                      }),
                      const SizedBox(height: 16.0),
                      buildRoundButton(
                        Icons.attach_money,
                        context,
                        () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const PaymentDetailsScreen()),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                buildAlphabetRow(_viewModel.users, context),
              ],
            );
          }
        },
      ),
    );
  }
}
