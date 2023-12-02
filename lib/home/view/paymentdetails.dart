import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:machine_test/home/model/model.dart';
import 'package:machine_test/home/view_model/home_viewmodel.dart';
import 'package:machine_test/main.dart';

class PaymentDetailsScreen extends StatefulWidget {
  const PaymentDetailsScreen({super.key});

  @override
  State<PaymentDetailsScreen> createState() => _PaymentDetailsScreenState();
}

class _PaymentDetailsScreenState extends State<PaymentDetailsScreen> {
  late List<User> payedUser;
  @override
  void initState() {
    payedUser = viewModel.users
        .where((element) =>
            element.isCash == true ||
            element.isUpi == true ||
            element.isLater == true)
        .toList();
    log('jkkkkkkkkkkkkkkkkkkkkkk');
    log(payedUser.length.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'TODO',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: const [
          Row(
            children: [
              Text(
                'Clear',
                style: TextStyle(color: Colors.blue),
              ),
              SizedBox(width: 16),
            ],
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(12.0),
        child: SafeArea(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Payments',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                  Text('Attendance',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w500))
                ],
              ),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: payedUser.length,
                  itemBuilder: (context, index) {
                    log('<<<<<<<<<<<<<message>>>>>>>>>>>>>');
                    log(payedUser.length.toString());
                    return ListTile(
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(payedUser[index].name),
                          Text(payedUser[index].name),
                        ],
                      ),
                      subtitle: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(payedUser[index].isUpi
                              ? 'UPI'
                              : (payedUser[index].isCash)
                                  ? 'Cash'
                                  : 'Later'),
                          Text('10.00'),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
