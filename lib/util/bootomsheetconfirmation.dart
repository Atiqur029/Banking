import 'package:another_flushbar/flushbar.dart';
import 'package:banking/database/databaseservice.dart';
import 'package:banking/main.dart';
import 'package:banking/model/history.dart';

import 'package:flutter/material.dart';

import 'package:fluttertoast/fluttertoast.dart';

class BottomSheetConfirmation extends StatefulWidget {
  final String senderName;
  final String transferAmount;
  final String receiverName;
  final String currentUser;
  const BottomSheetConfirmation({
    Key? key,
    required this.senderName,
    required this.transferAmount,
    required this.receiverName,
    required this.currentUser,
  }) : super(key: key);

  @override
  State<BottomSheetConfirmation> createState() =>
      _BottomSheetConfirmationState();
}

class _BottomSheetConfirmationState extends State<BottomSheetConfirmation> {
  var senderBalance, receiverBalance;
  var senderDocId, receiverDocId, currentUser;

  @override
  void initState() {
    super.initState();
    currentUser = widget.currentUser;
    getAccBalance(widget.senderName).then((value) {
      setState(() {
        senderBalance = value["accBal"];
        senderDocId = value["docId"];
      });
    });
    getAccBalance(widget.receiverName).then((value) {
      setState(() {
        receiverBalance = value["accBal"];
        receiverDocId = value["docId"];
      });
    });
  }

  Future<Map<String, dynamic>> getAccBalance(String name) async {
    double accbal;
    String docid;
    var result = await collectionReference.where('name', isEqualTo: name).get();
    docid = result.docs.first.id;
    accbal = result.docs.first['balance'];
    return {"accbal": accbal, "docid": docid};
  }

  double transferTo(String? senderName, String? rechiverName, double? amount) {
    if (senderName != null || rechiverName != null || amount != null) {
      double transferResult = 0.0;
      if (senderName == rechiverName) {
      } else if (senderBalance >= amount) {
        senderBalance = senderBalance - amount;
        receiverBalance = senderBalance + amount;
        transferResult = 1;
        DatabaseService()
            .customerCollection
            .doc(senderDocId)
            .update({"balance": senderBalance}).then((value) {
          Fluttertoast.showToast(
              msg: "Amount Added Successfully",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
        });
        DatabaseService()
            .customerCollection
            .doc(receiverDocId)
            .update({"balance": receiverDocId}).then((value) {
          Fluttertoast.showToast(
              msg: "Amount Added Successfully",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
        });

        History(
                sender: senderName.toString(),
                receiver: rechiverName.toString(),
                amount: amount,
                dateTime: DateTime.now(),
                currentUser: currentUser)
            .save()
            .then((value) {
          Fluttertoast.showToast(
              msg: "Transaction History Saved!",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
        }).catchError((error) {
          print(error);
        });
        transferResult = 1;
      } else {
        transferResult = 2;
      }
      return transferResult;
    }
    return -1;
  }

  @override
  Widget build(BuildContext context) {
    String? senderbalance = senderBalance.replaceAllMapped(
        RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},');
    String recevierBalance = receiverBalance.toString().replaceAllMapped(
        RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},');
    String transfferAmount = widget.transferAmount.toString().replaceAllMapped(
        RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},');
    return senderbalance == null || receiverBalance == null
        ? const SizedBox(
            height: 200,
            width: 200,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          )
        : Container(
            color: Colors.transparent,
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Column(children: [
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
                    color: Colors.grey[300],
                  ),
                ),
              ),
              SingleChildScrollView(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 30),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                            shadowColor: const Color.fromARGB(80, 0, 0, 0),
                            elevation: 5.0,
                            shape: RoundedRectangleBorder(
                                side: const BorderSide(
                                    color: Color.fromARGB(130, 40, 33, 173),
                                    width: 1.5),
                                borderRadius: BorderRadius.circular(10)),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(15, 15, 5, 15),
                              child: Row(
                                children: [
                                  const Text("From Sender: "),
                                  Text(
                                    "${widget.senderName} ",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w800,
                                        fontSize: 15,
                                        color: Colors.grey[700]),
                                  ),
                                  Text("[\$$senderBalance]",
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w400,
                                          color: Colors.grey))
                                ],
                              ),
                            )),
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(15, 8, 8, 8),
                        child: Row(
                          children: [
                            const Text("Transfer Amount: "),
                            Card(
                              color: const Color.fromARGB(255, 239, 241, 245),
                              elevation: 0.0,
                              shape: RoundedRectangleBorder(
                                  side: const BorderSide(
                                      color: Colors.transparent, width: 1.5),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(8, 10, 8, 10),
                                child: Text(
                                  "\$$transfferAmount",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 17,
                                      color: Color.fromARGB(255, 40, 33, 173)),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                            shadowColor: const Color.fromARGB(80, 0, 0, 0),
                            elevation: 5.0,
                            shape: RoundedRectangleBorder(
                                side: const BorderSide(
                                    color: Color.fromARGB(130, 40, 33, 173),
                                    width: 1.5),
                                borderRadius: BorderRadius.circular(10)),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(15, 15, 5, 15),
                              child: Row(
                                children: [
                                  const Text("To Receiver: "),
                                  Text("${widget.receiverName} ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w800,
                                          fontSize: 15,
                                          color: Colors.grey[700])),
                                  Text("[\$$recevierBalance]",
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w400,
                                          color: Colors.grey))
                                ],
                              ),
                            )),
                      ),
                      const SizedBox(height: 30),
                      MaterialButton(
                          shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                  color: Colors.transparent, width: 1),
                              borderRadius: BorderRadius.circular(10)),
                          color: Colors.green[400],
                          child: const Padding(
                            padding: EdgeInsets.fromLTRB(8, 15, 8, 15),
                            child: Text(
                              "Confirm Transaction",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 14),
                            ),
                          ),
                          onPressed: () {
                            double isTranssferd = transferTo(
                                widget.senderName,
                                widget.receiverName,
                                double.parse(widget.transferAmount));
                            Navigator.pop(context);
                            if (isTranssferd == 1) {
                              // Transfer Successful
                              Flushbar(
                                margin:
                                    const EdgeInsets.fromLTRB(10, 0, 10, 20),
                                padding: const EdgeInsets.all(20),
                                borderRadius: BorderRadius.circular(10),
                                message: "Transfer Successful!",
                                duration: const Duration(seconds: 3),
                                icon: const Icon(Icons.check_circle,
                                    size: 28, color: Colors.greenAccent),
                                dismissDirection:
                                    FlushbarDismissDirection.HORIZONTAL,
                                // leftBarIndicatorColor: Colors.blue[300],
                              ).show(context);
                            } else if (isTranssferd == -1) {
                              // Transfer Error
                              Flushbar(
                                margin:
                                    const EdgeInsets.fromLTRB(10, 0, 10, 20),
                                padding: const EdgeInsets.all(20),
                                borderRadius: BorderRadius.circular(10),
                                message: "Transfer Unsuccessful!",
                                duration: const Duration(seconds: 3),
                                icon: const Icon(Icons.cancel,
                                    size: 28, color: Colors.redAccent),
                                dismissDirection:
                                    FlushbarDismissDirection.HORIZONTAL,
                                // leftBarIndicatorColor: Colors.blue[300],
                              ).show(context);
                            } else if (isTranssferd == 2) {
                              // Insufficient Balance
                              Flushbar(
                                margin:
                                    const EdgeInsets.fromLTRB(10, 0, 10, 20),
                                padding: const EdgeInsets.all(20),
                                borderRadius: BorderRadius.circular(10),
                                message: "Insufficient Balance!",
                                duration: const Duration(seconds: 3),
                                icon: const Icon(Icons.cancel,
                                    size: 28, color: Colors.redAccent),
                                dismissDirection:
                                    FlushbarDismissDirection.HORIZONTAL,
                                // leftBarIndicatorColor: Colors.blue[300],
                              ).show(context);
                            } else {
                              // Names are Same
                              Flushbar(
                                margin:
                                    const EdgeInsets.fromLTRB(10, 0, 10, 20),
                                padding: const EdgeInsets.all(20),
                                borderRadius: BorderRadius.circular(10),
                                message: "Sender & Receiver are Same!",
                                duration: const Duration(seconds: 3),
                                icon: const Icon(Icons.cancel,
                                    size: 28, color: Colors.redAccent),
                                dismissDirection:
                                    FlushbarDismissDirection.HORIZONTAL,
                                // leftBarIndicatorColor: Colors.blue[300],
                              ).show(context);
                            }
                          }),
                      const SizedBox(height: 30)
                    ]),
              )
            ]));
    ;
  }
}
