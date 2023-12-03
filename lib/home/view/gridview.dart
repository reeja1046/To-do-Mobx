import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:machine_test/home/model/user.dart';
import 'package:machine_test/main.dart';

class AlphabetSearchGrid extends StatefulWidget {
  final List<User> usersWithSelectedAlphabet;
  const AlphabetSearchGrid({Key? key, required this.usersWithSelectedAlphabet})
      : super(key: key);

  @override
  State<AlphabetSearchGrid> createState() => _AlphabetSearchGridState();
}

class _AlphabetSearchGridState extends State<AlphabetSearchGrid> {
  TextEditingController paymentController = TextEditingController();
  bool isOn = false;

  @override
  void initState() {
    widget.usersWithSelectedAlphabet;
    paymentController.text = '2500';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        if (widget.usersWithSelectedAlphabet.isEmpty) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return GridView.builder(
            itemCount: widget.usersWithSelectedAlphabet.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 15.0,
              mainAxisSpacing: 15.0,
            ),
            itemBuilder: (BuildContext context, int index) {
              User user = widget.usersWithSelectedAlphabet[index];
              return GridTile(
                child: GestureDetector(
                  onTap: () {
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
                                  _buildDialogContentRow(
                                      user, user.profileImage, user.name),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text('UPI'),
                                      Switch(
                                        value: viewModel.users[index].isUpi,
                                        onChanged: (value) {
                                          setState(() {
                                            isOn = !isOn;
                                            viewModel.users[index].isUpi = isOn;
                                            viewModel.users[index].isCash =
                                                false;
                                            viewModel.users[index].isLater =
                                                false;
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text('Cash'),
                                      Switch(
                                        value: viewModel.users[index].isCash,
                                        onChanged: (value) {
                                          setState(() {
                                            isOn = !isOn;
                                            viewModel.users[index].isCash =
                                                isOn;
                                            viewModel.users[index].isUpi =
                                                false;
                                            viewModel.users[index].isLater =
                                                false;
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text('Later'),
                                      Switch(
                                        value: viewModel.users[index].isLater,
                                        onChanged: (value) {
                                          setState(() {
                                            isOn = !isOn;
                                            viewModel.users[index].isLater =
                                                isOn;
                                            viewModel.users[index].isUpi =
                                                false;
                                            viewModel.users[index].isCash =
                                                false;
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
                                    focusedBorder: OutlineInputBorder()),
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
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 3),
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
                              borderRadius: BorderRadius.circular(30),
                              color: Colors.grey,
                              border: Border.all(
                                width: 3,
                                color: (user.isCash == true ||
                                        user.isLater == true ||
                                        user.isUpi == true)
                                    ? const Color.fromARGB(255, 28, 231, 35)
                                    : Colors.transparent,
                              ),
                            ),
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
          );
        }
      },
    );
  }
}

Widget _buildDialogContentRow(User user, String userImage, String name) {
  return Column(
    children: [
      CircleAvatar(radius: 20, backgroundImage: NetworkImage(userImage)),
      Text(name),
    ],
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
