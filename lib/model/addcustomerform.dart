import 'package:another_flushbar/flushbar.dart';
import 'package:banking/model/customer.dart';
import 'package:flutter/material.dart';

class AddCustomerForm extends StatefulWidget {
  const AddCustomerForm({super.key});

  @override
  State<AddCustomerForm> createState() => _AddCustomerFormState();
}

class _AddCustomerFormState extends State<AddCustomerForm> {
  final _formkey = GlobalKey<FormState>();

  String customerName = "";
  String customerBalance = "";
  String customerNumber = "";
  String customerEmail = "";

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formkey,
        child: Column(
          children: <Widget>[
            const SizedBox(
              height: 20.0,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 0, 20, 0),
              child: TextFormField(
                keyboardType: TextInputType.name,
                decoration: const InputDecoration(
                  icon: Icon(Icons.person),
                  hintText: 'Enter full name',
                  labelText: 'Name *',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter full name';
                  }
                  return null;
                },
                onChanged: (String value) {
                  setState(() {
                    customerName = value;
                  });
                },
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 0, 20, 0),
              child: TextFormField(
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  icon: Icon(Icons.phone),
                  hintText: 'Enter Phone Number',
                  labelText: 'Number *',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter phone number';
                  }
                  return null;
                },
                onChanged: (String value) {
                  setState(() {
                    customerNumber = value;
                  });
                },
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 0, 20, 0),
              child: TextFormField(
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  icon: Icon(Icons.email),
                  hintText: 'Enter Email Address',
                  labelText: 'Email *',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter email';
                  } else if (RegExp(
                              r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
                          .hasMatch(value) ==
                      false) {
                    return 'Enter Valid Email';
                  }
                  return null;
                },
                onChanged: (String value) {
                  setState(() {
                    customerEmail = value;
                  });
                },
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 0, 20, 0),
              child: TextFormField(
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  icon: Icon(Icons.phone_android),
                  hintText: 'Enter Account Balance',
                  labelText: 'Balance *',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter balance';
                  }
                  return null;
                },
                onChanged: (String value) {
                  setState(() {
                    customerBalance = value;
                  });
                },
              ),
            ),
            const SizedBox(
              height: 50.0,
            ),
            MaterialButton(
              color: Colors.green[400],
              child: const Text(
                "Add Customer",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () async {
                if (_formkey.currentState!.validate()) {
                  Customer newCustomer = Customer(
                      name: customerName,
                      balance: double.parse(customerBalance),
                      number: double.parse(customerNumber),
                      email: customerEmail);
                  await newCustomer.save();
                  Navigator.pop(context);
                  // ignore: use_build_context_synchronously
                  Flushbar(
                    margin: const EdgeInsets.fromLTRB(10, 0, 10, 20),
                    padding: const EdgeInsets.all(20),
                    borderRadius: BorderRadius.circular(10),
                    message: "Customer Added !",
                    duration: const Duration(seconds: 3),
                    icon: const Icon(Icons.person_add,
                        size: 28, color: Colors.greenAccent),
                    dismissDirection: FlushbarDismissDirection.HORIZONTAL,
                    // leftBarIndicatorColor: Colors.blue[300],
                  ).show(context);
                }
              },
            ),
            const SizedBox(
              height: 50.0,
            )
          ],
        ));
    ;
  }
}
