import 'package:banking/database/databaseservice.dart';
import 'package:banking/widget/customtile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../model/addcustomerform.dart';

class AllCustomer extends StatelessWidget {
  const AllCustomer({super.key, required this.userEmail});

  final String userEmail;

  static List<String> admin = [
    "18191203029@cse.bubt.edu.bd",
    "atiqur8061029@gmail.com"
  ];

  @override
  Widget build(BuildContext context) {
    void showBottomSheet() {
      showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(25.0))),
        builder: (context) => Container(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: SingleChildScrollView(
              child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: 200,
                height: 20,
                child: Card(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      side: const BorderSide(color: Colors.white, width: 1.0),
                      borderRadius: BorderRadius.circular(50)),
                  child: Divider(
                    indent: 1,
                    endIndent: 1,
                    thickness: 8,
                    color: Colors.grey[200],
                  ),
                ),
              ),
              const AddCustomerForm(),
            ],
          )),
        ),
        elevation: 5.0,
      );
    }

    return StreamProvider<QuerySnapshot?>.value(
      value: DatabaseService().customer,
      initialData: null,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: const CutomerTill(),
        floatingActionButton: admin.contains(userEmail)
            ? FloatingActionButton(
                onPressed: () => showBottomSheet(),
                backgroundColor: Colors.green,
                child: const Icon(Icons.add),
              )
            : null,
      ),
    );
  }
}
