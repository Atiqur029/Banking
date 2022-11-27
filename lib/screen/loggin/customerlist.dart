import 'package:banking/autentication/signingoogle.dart';
import 'package:banking/screen/historyperon.dart';

import 'package:banking/screen/loggin/allcustoerlist.dart';
import 'package:banking/screen/loggin/home.dart';
import 'package:banking/screen/loggin/transaction.dart';

import 'package:flutter/material.dart';

class CustomersList extends StatefulWidget {
  const CustomersList({
    Key? key,
    required this.userDetails,
  }) : super(key: key);

  final Map<String, dynamic> userDetails;

  @override
  _CustomersListState createState() => _CustomersListState();
}

class _CustomersListState extends State<CustomersList> {
  var _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    var screens = <Map<String, dynamic>>[
      {
        "title": "All customers",
        "screen":
            AllCustomer(userEmail: widget.userDetails["userEmail"].toString()),
        "bgColor": Colors.transparent,
        "elevation": 0.0,
        "textColor": Colors.black,
      },
      {
        "title": "Transaction",
        "screen": MakeTransaction(currentuser: widget.userDetails["userName"]),
        "bgColor": Colors.blue[400]
      },
      {
        "title": "History",
        "screen": const HistoryPerson(),
        "bgColor": Colors.blueGrey
      },
    ];
    final Map<String, dynamic> userDetails = widget.userDetails;

    return Scaffold(
      appBar: AppBar(
        elevation: screens[_selectedIndex]["elevation"] ?? 4.0,
        title: Row(children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(50),
              boxShadow: const [
                BoxShadow(
                  color: Color.fromARGB(35, 0, 0, 0),
                  spreadRadius: 3,
                  blurRadius: 2,
                  offset: Offset(0, 1),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Image(
                image: NetworkImage(userDetails["userImgUrl"].toString()),
                width: 35,
              ),
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Text(
            screens[_selectedIndex]["title"],
            style: TextStyle(
                color: screens[_selectedIndex]["textColor"] ?? Colors.white,
                fontWeight: FontWeight.w800,
                fontSize: 24),
          )
        ]),
        backgroundColor: screens[_selectedIndex]["bgColor"],
        actions: [
          MaterialButton(
            child: const Text(
              'Log Out',
              style: TextStyle(fontSize: 0),
            ),
            onPressed: () async {
              await signOutGoogle().then((result) {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const Home()),
                  (Route<dynamic> route) => false,
                );
              });
            },
          ),
        ],
      ),
      body: screens[_selectedIndex]["screen"],
      bottomNavigationBar: BottomNavigationBar(
        elevation: screens[_selectedIndex]["elevation"] ?? 4.0,
        type: BottomNavigationBarType.shifting,
        items: [
          const BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Customers',
              backgroundColor: Colors.orange),
          BottomNavigationBarItem(
              icon: const Icon(Icons.money),
              label: 'Transaction',
              backgroundColor: screens[1]["bgColor"]),
          BottomNavigationBarItem(
              icon: const Icon(Icons.history),
              label: 'History',
              backgroundColor: screens[2]["bgColor"]),
        ],
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
