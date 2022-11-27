import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final Query historyCollection = FirebaseFirestore.instance
      .collection("transaction_history")
      .orderBy("date_time");

  Stream<QuerySnapshot> get history {
    return historyCollection.snapshots();
  }

  final CollectionReference customerCollection =
      FirebaseFirestore.instance.collection("customer");

  Stream<QuerySnapshot> get customer {
    return customerCollection.snapshots();
  }

  Future<QuerySnapshot?> getCustomerList() async {
    try {
      return customerCollection.get();
    } catch (error) {
      print(error);
      return null;
    }
  }
}
