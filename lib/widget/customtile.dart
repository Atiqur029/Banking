import 'package:banking/screen/loggin/allcustoerlist.dart';
import 'package:banking/widget/customercard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CutomerTill extends StatefulWidget {
  const CutomerTill({super.key});

  @override
  State<CutomerTill> createState() => _CutomerTillState();
}

class _CutomerTillState extends State<CutomerTill> {
  @override
  Widget build(BuildContext context) {
    if (Provider.of<QuerySnapshot?>(context) == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    final allcustomer = Provider.of<QuerySnapshot>(context).docs;

    return ListView.builder(
        itemCount: allcustomer.length,
        itemBuilder: ((context, index) {
          dynamic customer = allcustomer[index].data();
          return CustomerCard(
              customerName: customer["name"], balance: customer['balance']);
        }));
  }
}
