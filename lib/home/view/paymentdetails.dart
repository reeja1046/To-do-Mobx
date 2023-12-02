import 'package:flutter/material.dart';

class PaymentDetailsScreen extends StatefulWidget {
  const PaymentDetailsScreen({super.key});

  @override
  State<PaymentDetailsScreen> createState() => _PaymentDetailsScreenState();
}

class _PaymentDetailsScreenState extends State<PaymentDetailsScreen> {
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
      body: const Padding(
        padding: EdgeInsets.all(12.0),
        child: SafeArea(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Payments',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              Text('Attendance',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500))
            ],
          ),
        ),
      ),
    );
  }
}
