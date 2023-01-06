import 'package:eventdemo/model/event.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../Util/util.dart';
import 'event_model.dart';

class EventList extends StatelessWidget {
  const EventList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: context.read<EventModel>().scaffoldKey,
      body: eventBody(context),
    );
  }

  Widget eventBody(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: createCustView(context));
  }

  Widget createCustView(BuildContext context) {
    return ListView.builder(
        itemCount: context.watch<EventModel>().events.length,
        itemBuilder: (BuildContext context, int index) {
          Event event = context.read<EventModel>().events[index];
          return Card(
              margin: const EdgeInsets.all(5),
              elevation: 0.8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Expanded(
                                    flex: 1, child: Text("Event Id")),
                                Expanded(
                                    flex: 2,
                                    child: Text(event.eventId.toString()))
                              ],
                            ),
                            Row(
                              children: [
                                const Expanded(flex: 1, child: Text("Name")),
                                Expanded(flex: 2, child: Text(event.eventName!))
                              ],
                            ),
                            Row(
                              children: [
                                const Expanded(
                                    flex: 1, child: Text("Start Time")),
                                Expanded(
                                    flex: 2,
                                    child: Text(Utility.dateToStringWithTime(
                                        event.startTime!)))
                              ],
                            ),
                            Row(
                              children: [
                                const Expanded(
                                    flex: 1, child: Text("End Time")),
                                Expanded(
                                    flex: 2,
                                    child: Text(Utility.dateToStringWithTime(
                                        event.endTime!)))
                              ],
                            ),
                            Row(
                              children: [
                                const Expanded(
                                    flex: 1, child: Text("Max Seats")),
                                Expanded(
                                    flex: 2,
                                    child: Text(event.maxSeats.toString()))
                              ],
                            ),
                            Row(
                              children: [
                                const Expanded(
                                    flex: 1, child: Text("Seats Taken")),
                                Expanded(
                                    flex: 2,
                                    child: Text(event.seatBook.toString() +
                                        context
                                            .read<EventModel>()
                                            .fullyBookMsg(event)))
                              ],
                            ),
                          ]),
                    ),
                    Column(
                      children: [
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              foregroundColor: context
                                      .read<EventModel>()
                                      .isfullyBookMsg(event)
                                  ? Theme.of(context).disabledColor
                                  : Theme.of(context).primaryColor,
                              backgroundColor: Colors.white,
                              shadowColor: Colors.black,
                              padding:
                                  const EdgeInsets.fromLTRB(15, 15, 15, 15),
                              elevation: 3,
                            ),
                            onPressed: () {
                              if (!context
                                  .read<EventModel>()
                                  .isfullyBookMsg(event)) {
                                context
                                    .read<EventModel>()
                                    .showOrderDialog(context, event);
                              }
                            },
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(10, 2, 10, 2),
                              child: Text('Order',
                                  style: GoogleFonts.roboto(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600)),
                            )),
                      ],
                    )
                  ],
                ),
              ));
        });
  }
}
