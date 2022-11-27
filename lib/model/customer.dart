// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';


class Customer {
  String name;
  String email;
  double balance;
  double number;
  Customer({
    required this.name,
    required this.email,
    required this.balance,
    required this.number,
  });

  final CollectionReference _customerCollection =
      FirebaseFirestore.instance.collection('customer');

  Future<void> save() async {
    try {
      await _customerCollection.add(toMap());
    } catch (error) {
      print(error.toString());
    }
  }

  Customer copyWith({
    String? name,
    String? email,
    double? balance,
    double? number,
  }) {
    return Customer(
      name: name ?? this.name,
      email: email ?? this.email,
      balance: balance ?? this.balance,
      number: number ?? this.number,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'email': email,
      'balance': balance,
      'number': number,
    };
  }

  factory Customer.fromMap(Map<String, dynamic> map) {
    return Customer(
      name: map['name'] as String,
      email: map['email'] as String,
      balance: map['balance'] as double,
      number: map['number'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory Customer.fromJson(String source) =>
      Customer.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Customer(name: $name, email: $email, balance: $balance, number: $number)';
  }

  @override
  bool operator ==(covariant Customer other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.email == email &&
        other.balance == balance &&
        other.number == number;
  }

  @override
  int get hashCode {
    return name.hashCode ^ email.hashCode ^ balance.hashCode ^ number.hashCode;
  }
}
