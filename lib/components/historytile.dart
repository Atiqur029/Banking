import 'package:banking/widget/customercard.dart';
import 'package:banking/widget/historyCard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HistoryTile extends StatefulWidget {
  const HistoryTile({super.key});

  @override
  State<HistoryTile> createState() => _HistoryTileState();
}

class _HistoryTileState extends State<HistoryTile> {
  @override
  Widget build(BuildContext context) {
    if (Provider.of<QuerySnapshot?>(context) == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    List<DocumentSnapshot> transectionhistory =
        Provider.of<QuerySnapshot>(context).docs.reversed.toList();

    return ListView.builder(
      itemCount: transectionhistory.length,
      itemBuilder: (context, index) {
        dynamic history = transectionhistory[index].data();
        return HistoryCard(
            sender: history['sender'],
            receiver: history['receiver'],
            dateTime: history["date_time"],
            amount: history["amount"],
            doneBy: history["done_by"] ?? "anonymous");
      },
    );
  }
}
