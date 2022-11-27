import 'package:banking/components/historytile.dart';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

import '../database/databaseservice.dart';

class HistoryPerson extends StatelessWidget {
  const HistoryPerson({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamProvider<QuerySnapshot?>.value(
        value: DatabaseService().history,
        initialData: null,
        child: const Scaffold(
          body: HistoryTile(),
        ));
  }
}
