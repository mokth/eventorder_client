import 'package:eventdemo/model/event.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../model/event_booking.dart';
import '../repository/event_repository.dart';
import 'event_order.dart';

class EventModel extends ChangeNotifier {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final EventRepository repo = EventRepository();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  late BuildContext context;
  List<Event> events = <Event>[];

  initModel(BuildContext pcontext) {
    context = pcontext;
    repo.getAllEvents().then((value) {
      events = [...value];
      notifyListeners();
    });
  }

  refreshEventList() {
    repo.getAllEvents().then((value) {
      events = [...value];
      notifyListeners();
    });
  }

  showOrderDialog(BuildContext pcontext, Event event) {
    EventOrder.showOrderDialog(pcontext, event);
  }

  closeDialog(BuildContext context) {
    Navigator.of(context).pop(false);
  }

  fullyBookMsg(Event event) {
    String msg = "";
    if (event.maxSeats != null) {
      if (event.maxSeats == event.seatBook) {
        msg = "  (Fully Booked)";
      }
    }
    return msg;
  }

  isfullyBookMsg(Event event) {
    bool fullyBooked = false;
    if (event.maxSeats != null) {
      if (event.maxSeats == event.seatBook) {
        fullyBooked = true;
      }
    }
    return fullyBooked;
  }

  submitOrder(BuildContext context, Event event) {
    EventBooking eventBooking = EventBooking(
        eventId: event.eventId,
        dateBook: DateTime.now(),
        userName: nameController.text);

    repo.postBooking(eventBooking).then((value) {
      List<String> data = value.split('|');
      if (data[0] == "0") {
        showMessageDialog(context, "Order", "Successfully submited.", 0);
        //Navigator.of(context).pop();
      } else {
        showMessageDialog(
            context, "Warning", "Error Submitting order. " + data[1], 1);
      }
    });
  }

  showMessageDialog(
      BuildContext context, String title, String message, int returnVal) {
    double fontsize1 = 13;

    var alert = AlertDialog(
      title: Text(
        title,
        style: TextStyle(fontSize: fontsize1),
      ),
      content: Text(message),
      actions: <Widget>[
        TextButton(
          child: const Text('OK'),
          onPressed: () {
            Navigator.of(context).pop(true);
          },
        )
      ],
    );

    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return alert;
        }).then((value) {
      if (returnVal == 0) {
        refreshEventList();
        Navigator.of(context).pop(true);
      }
    });
  }
}
