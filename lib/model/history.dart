// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class History {
  String sender;
  String receiver;
  double? amount;
  DateTime dateTime;
  String currentUser;
  History({
    required this.sender,
    required this.receiver,
    required this.amount,
    required this.dateTime,
    required this.currentUser,
  });

  final CollectionReference historyCollection =
      FirebaseFirestore.instance.collection("transaction-history");

  Future<void> save() async {
    try {
      await historyCollection.add(toMap());
    } catch (error) {
      rethrow;
    }
  }

  History copyWith({
    String? sender,
    String? receiver,
    double? amount,
    DateTime? dateTime,
    String? currentUser,
  }) {
    return History(
      sender: sender ?? this.sender,
      receiver: receiver ?? this.receiver,
      amount: amount ?? this.amount,
      dateTime: dateTime ?? this.dateTime,
      currentUser: currentUser ?? this.currentUser,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'sender': sender,
      'receiver': receiver,
      'amount': amount,
      'dateTime': dateTime.millisecondsSinceEpoch,
      'currentUser': currentUser,
    };
  }

  factory History.fromMap(Map<String, dynamic> map) {
    return History(
      sender: map['sender'] as String,
      receiver: map['receiver'] as String,
      amount: map['amount'] as double,
      dateTime: DateTime.fromMillisecondsSinceEpoch(map['dateTime'] as int),
      currentUser: map['currentUser'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory History.fromJson(String source) =>
      History.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'History(sender: $sender, receiver: $receiver, amount: $amount, dateTime: $dateTime, currentUser: $currentUser)';
  }

  @override
  bool operator ==(covariant History other) {
    if (identical(this, other)) return true;

    return other.sender == sender &&
        other.receiver == receiver &&
        other.amount == amount &&
        other.dateTime == dateTime &&
        other.currentUser == currentUser;
  }

  @override
  int get hashCode {
    return sender.hashCode ^
        receiver.hashCode ^
        amount.hashCode ^
        dateTime.hashCode ^
        currentUser.hashCode;
  }
}
