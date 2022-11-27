// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math';

import 'package:flutter/material.dart';

class CustomerCard extends StatelessWidget {
  final String customerName;
  final double balance;

  const CustomerCard({
    Key? key,
    required this.customerName,
    required this.balance,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color randomColor = Color.fromARGB((Random().nextInt(100) + 155) % 255, 0,
        Random().nextInt(80), Random().nextInt(200));
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Card(
        margin: const EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: ListTile(
            leading: Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: const BorderRadius.all(Radius.circular(20))),
              child: Icon(
                Icons.person_rounded,
                size: 30.0,
                color: randomColor,
              ),
            ),
            title: Text(
              customerName,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(
                      255, 0, randomColor.green, randomColor.blue)),
            ),
            subtitle: Row(children: [
              const Text('Balance: '),
              Text(
                '\$${getBalance(balance)}',
                style: const TextStyle(
                    color: Colors.green, fontWeight: FontWeight.bold),
              )
            ])),
      ),
    );
  }

  String getBalance(double balance) {
    String balanceWithComma = balance.toString();

    balanceWithComma = balanceWithComma.replaceAllMapped(
        RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},');
    return balanceWithComma;
  }
}
