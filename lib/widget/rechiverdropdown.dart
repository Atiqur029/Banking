import 'package:flutter/material.dart';

typedef void StringCallback(String val);

class RecheiverDropdown extends StatefulWidget {
  final List<String>? customerlist;
  final StringCallback aceptrecheiver;
  const RecheiverDropdown({
    Key? key,
    required this.customerlist,
    required this.aceptrecheiver,
  }) : super(key: key);

  @override
  State<RecheiverDropdown> createState() => _RecheiverDropdownState();
}

class _RecheiverDropdownState extends State<RecheiverDropdown> {
  String rechiver = "Riad";
  @override
  Widget build(BuildContext context) {
    return widget.customerlist != null
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                  padding: const EdgeInsets.fromLTRB(4, 0, 0, 0),
                  child: Text(
                    "Select Receiver *",
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[600]),
                  )),
              Card(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(15, 0, 5, 0),
                  child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                    icon: const Icon(Icons.arrow_drop_down_rounded),
                    iconSize: 26,
                    elevation: 1,
                    itemHeight: 50,
                    onChanged: (value) {
                      setState(() {
                        rechiver = value.toString();
                      });
                      widget.aceptrecheiver(value.toString());
                    },
                    iconEnabledColor: Colors.deepPurple,
                    style: TextStyle(
                        color: Colors.deepPurple[400],
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.2),
                    iconDisabledColor: Colors.grey,
                    value: rechiver.toString(),
                    items: widget.customerlist
                        ?.map<DropdownMenuItem<String>>(
                            (value) => DropdownMenuItem(
                                  child: Text(value),
                                ))
                        .toList(),
                  )),
                ),
              )
            ],
          )
        : const Center(
            child: CircularProgressIndicator(),
          );
  }
}
