import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:machine_test/home/model/model.dart';
import 'package:machine_test/home/view/paymentdetails.dart';
import 'package:machine_test/home/view/widgets/buttons.dart';
import 'package:machine_test/home/view/widgets/widgets.dart';
import 'package:machine_test/main.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController paymentController = TextEditingController();
  bool isOn = false;

  @override
  void initState() {
    viewModel.fetchUsers();
    paymentController.text = '2500';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 209, 233, 255),
      appBar: buildAppBar(),
      body: Observer(
        builder: (_) {
          if (viewModel.users.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Stack(
              children: [
                Positioned.fill(
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: GridView.builder(
                      itemCount: viewModel.users.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 15.0,
                        mainAxisSpacing: 15.0,
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        User user = viewModel.users[index];
                        return GridTile(
                          child: GestureDetector(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    content: SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.7,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.28,
                                      child: SingleChildScrollView(
                                        child: Column(
                                          children: [
                                            _buildDialogContentRow(user,
                                                user.profileImage, user.name),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                const Text('UPI'),
                                                Switch(
                                                  value: viewModel
                                                      .users[index].isUpi,
                                                  onChanged: (value) {
                                                    log(value.toString());
                                                    log(user.isUpi.toString());
                                                    setState(() {
                                                      isOn = !isOn;
                                                      viewModel.users[index]
                                                          .isUpi = isOn;
                                                      viewModel.users[index]
                                                          .isCash = false;
                                                      viewModel.users[index]
                                                          .isLater = false;
                                                    });
                                                  },
                                                ),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                const Text('Cash'),
                                                Switch(
                                                  value: viewModel
                                                      .users[index].isCash,
                                                  onChanged: (value) {
                                                    log(value.toString());
                                                    log(user.isCash.toString());
                                                    setState(() {
                                                      isOn = !isOn;
                                                      viewModel.users[index]
                                                          .isCash = isOn;
                                                      viewModel.users[index]
                                                          .isUpi = false;
                                                      viewModel.users[index]
                                                          .isLater = false;
                                                    });
                                                  },
                                                ),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                const Text('Later'),
                                                Switch(
                                                  value: viewModel
                                                      .users[index].isLater,
                                                  onChanged: (value) {
                                                    log(value.toString());
                                                    log(user.isUpi.toString());
                                                    setState(() {
                                                      isOn = !isOn;
                                                      viewModel.users[index]
                                                          .isLater = isOn;
                                                      viewModel.users[index]
                                                          .isUpi = false;
                                                      viewModel.users[index]
                                                          .isCash = false;
                                                    });
                                                  },
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    actions: <Widget>[
                                      Expanded(
                                        child: TextField(
                                          controller: paymentController,
                                          decoration: const InputDecoration(
                                              border: UnderlineInputBorder(),
                                              focusedBorder:
                                                  OutlineInputBorder()),
                                        ),
                                      ),
                                      _buildActionButtons(context),
                                    ],
                                  );
                                },
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(10.0)),
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
                                    Container(
                                      height: 60,
                                      width: 60,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          color: Colors.grey,
                                          border: Border.all(
                                            width: 3,
                                            color: (user.isCash == true ||
                                                    user.isLater == true ||
                                                    user.isUpi == true)
                                                ? const Color.fromARGB(
                                                    255, 28, 231, 35)
                                                : Colors.transparent,
                                          )),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(30),
                                        child: Image.network(
                                          user.profileImage,
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 20),
                                    Text(
                                      user.name,
                                      textAlign: TextAlign.center,
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
                      },
                    ),
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
                buildAlphabetRow(viewModel.users, context),
              ],
            );
          }
        },
      ),
    );
  }

  Widget _buildDialogContentRow(User user, String userImage, String name) {
    return Column(
      children: [
        CircleAvatar(radius: 20, backgroundImage: NetworkImage(userImage)),
        Text(name),
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
}
