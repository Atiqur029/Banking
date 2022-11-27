import 'package:banking/widget/rechiverdropdown.dart';
import 'package:banking/widget/senderdropdown.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../util/bootomsheetconfirmation.dart';

class MakeTransaction extends StatefulWidget {
  final String currentuser;
  const MakeTransaction({super.key, required this.currentuser});

  @override
  State<MakeTransaction> createState() => _MakeTransactionState();
}

class _MakeTransactionState extends State<MakeTransaction> {
  void _transferMoney() {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
    if (_senderName != null &&
        _receiverName != null &&
        _transferAmount != null) {
      showModalBottomSheet(
        context: context,
        isScrollControlled: false,
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
            side: BorderSide(color: Colors.white),
            borderRadius: BorderRadius.vertical(top: Radius.circular(25.0))),
        builder: (context) {
          return BottomSheetConfirmation(
            senderName: _senderName.toString(),
            transferAmount: _transferAmount.toString(),
            receiverName: _receiverName.toString(),
            currentUser: widget.currentuser,
          );
        },
        elevation: 5.0,
      );
    }
  }

  List<String> customerNamesList = [];
  String? _senderName;
  String? _receiverName;
  String? _transferAmount;
  bool isBalSet = false;
  @override
  void initState() {
    super.initState();
    getCustomerName();
  }

  void getCustomerName() async {
    List<String> customerName = [];
    await FirebaseFirestore.instance
        .collection('customers')
        .get()
        .then((QuerySnapshot querySnapshot) {
      if (querySnapshot.docs.isEmpty) {
        for (var doc in querySnapshot.docs) {
          String name = doc["name"];
          customerName.add(name);
          print(doc["name"]);
        }
        setState(() {
          customerNamesList = customerName;
        });
      } else {
        setState(() {
          customerNamesList = ["No Customer"];
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: SizedBox(
            height: 400,
            width: 500,
            child: Card(
              elevation: 5.0,
              shadowColor: const Color.fromARGB(55, 0, 0, 0),
              shape: RoundedRectangleBorder(
                  side: const BorderSide(color: Colors.transparent, width: 1),
                  borderRadius: BorderRadius.circular(20)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Senderdropdown(
                          customerlist: customerNamesList,
                          sender: (val) => setState(() => _senderName = val)),
                      const SizedBox(
                        width: 10,
                      ),
                      RecheiverDropdown(
                        customerlist: customerNamesList,
                        aceptrecheiver: (val) =>
                            setState(() => _receiverName = val),
                      )
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(4, 0, 0, 0),
                        child: Text("Amount *",
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey[600])),
                      ),
                      SizedBox(
                        width: 200,
                        height: 50,
                        child: Card(
                          shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                  color: Color.fromARGB(130, 40, 33, 173),
                                  width: 1),
                              borderRadius: BorderRadius.circular(10)),
                          elevation: 0,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(10, 0, 0, 4),
                            child: TextField(
                                style: const TextStyle(
                                  fontWeight: FontWeight.w800,
                                  letterSpacing: 0.5,
                                ),
                                //fontFamily: "Roboto"),
                                autofocus: false,
                                decoration: const InputDecoration(
                                    icon: Icon(
                                      Icons.monetization_on_rounded,
                                      size: 22,
                                    ),
                                    border: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    errorBorder: InputBorder.none,
                                    disabledBorder: InputBorder.none,
                                    hintText: 'Enter Amount',
                                    hintStyle: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        letterSpacing: 0)),
                                keyboardType: TextInputType.number,
                                onChanged: (String value) {
                                  setState(() {
                                    _transferAmount = value;
                                  });
                                }),
                          ),
                        ),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      MaterialButton(
                        shape: RoundedRectangleBorder(
                            side: const BorderSide(
                                color: Color.fromARGB(130, 40, 33, 173),
                                width: 1),
                            borderRadius: BorderRadius.circular(10)),
                        color: const Color.fromARGB(200, 40, 33, 173),
                        onPressed: () {
                          _transferMoney();
                        },
                        child: const Padding(
                          padding: EdgeInsets.fromLTRB(8, 15, 8, 15),
                          child: Text("Transfer",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w800)),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
