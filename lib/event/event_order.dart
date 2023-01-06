import 'package:eventdemo/model/event.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'event_model.dart';

class EventOrder {
  static showOrderDialog(BuildContext context, Event event) {
    var size = MediaQuery.of(context).size;

    var dialog = Dialog(
        elevation: 0.8,
        insetPadding: const EdgeInsets.all(20),
        child: SizedBox(
            height: size.height * 0.6,
            width: size.width * 0.6,
            child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('Event Name :${event.eventName}',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontFamily: 'Candal')),
                    const Divider(height: 15, color: Colors.transparent),
                    const Text('User Name',
                        style: TextStyle(
                            color: Colors.black, fontFamily: 'Candal')),
                    TextFormField(
                      enabled: true,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w500),
                      textAlign: TextAlign.left,
                      controller: context.read<EventModel>().nameController,
                      keyboardType: TextInputType.text,
                    ),
                    // const Divider(height: 10, color: Colors.transparent),
                    // const Text('Email',
                    //     style: TextStyle(
                    //         color: Colors.black, fontFamily: 'Candal')),
                    // TextFormField(
                    //   enabled: true,
                    //   style: const TextStyle(
                    //       fontSize: 18, fontWeight: FontWeight.w500),
                    //   textAlign: TextAlign.left,
                    //   controller: context.read<EventModel>().emailController,
                    //   keyboardType: TextInputType.text,
                    // ),
                    const Divider(height: 30, color: Colors.transparent),
                    Row(
                      children: [
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Theme.of(context).primaryColor,
                              backgroundColor: Colors.white,
                              shadowColor: Colors.black,
                              padding:
                                  const EdgeInsets.fromLTRB(15, 15, 15, 15),
                              elevation: 3,
                            ),
                            onPressed: () {
                              context
                                  .read<EventModel>()
                                  .submitOrder(context, event);
                            },
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(10, 2, 10, 2),
                              child: Text('Submit',
                                  style: GoogleFonts.roboto(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600)),
                            )),
                        const VerticalDivider(
                            width: 10, color: Colors.transparent),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Theme.of(context).errorColor,
                              backgroundColor: Colors.white,
                              shadowColor: Colors.black,
                              padding:
                                  const EdgeInsets.fromLTRB(15, 15, 15, 15),
                              elevation: 3,
                            ),
                            onPressed: () {
                              context.read<EventModel>().closeDialog(context);
                            },
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(10, 2, 10, 2),
                              child: Text('Cancel',
                                  style: GoogleFonts.roboto(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600)),
                            )),
                      ],
                    ),
                  ],
                ))));

    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return dialog;
        });
  }
}
