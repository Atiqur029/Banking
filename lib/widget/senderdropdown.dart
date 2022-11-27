// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';

typedef void StringCallback(String val);

class Senderdropdown extends StatefulWidget {
  final List<String>? customerlist;
  final StringCallback sender;
  const Senderdropdown({
    Key? key,
    required this.customerlist,
    required this.sender,
  }) : super(key: key);

  @override
  State<Senderdropdown> createState() => _SenderdropdownState();
}

class _SenderdropdownState extends State<Senderdropdown> {
  String currentSender = "Atiqur Rahman";
  @override
  Widget build(BuildContext context) {
    return widget.customerlist != null
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(4, 0, 0, 0),
                child: Text(
                  "Select Sender *",
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[600]),
                ),
              ),
              Card(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(15, 0, 5, 0),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton(
                      value: currentSender.toString(),
                      icon: const Icon(Icons.arrow_drop_down_rounded),
                      iconSize: 25,
                      itemHeight: 50,
                      elevation: 1,
                      iconDisabledColor: Colors.grey,
                      iconEnabledColor: Colors.deepPurple,
                      style: TextStyle(
                        color: Colors.deepPurple[400],
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.2,
                      ),
                      onChanged: (value) {
                        setState(() {
                          currentSender = value.toString();
                        });
                        widget.sender(value.toString());
                      },
                      items: widget.customerlist
                          ?.map<DropdownMenuItem<String>>(
                              (value) => DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  ))
                          .toList(),
                    ),
                  ),
                ),
              )
            ],
          )
        : const Center(
            child: CircularProgressIndicator(),
          );
  }
}
