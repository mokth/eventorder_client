import 'dart:convert';

import 'package:eventdemo/model/event_booking.dart';
import 'package:http/http.dart' as http;

import '../model/event.dart';

class EventRepository {
  String apiUrl = "https://localhost:7114/api/";

  Future<List<Event>> getAllEvents() async {
    String url = "${apiUrl}event/events";
    print(Uri.parse(url));
    var response = await http
        .get(Uri.parse(url), headers: {'content-type': 'application/json'});

    var resp = jsonDecode(response.body);

    List<Event> list = <Event>[];
    if (resp['ok'] == "yes") {
      dynamic data = resp['data'];

      data.forEach((item) {
        list.add(Event.fromJson(item));
      });
    } else {
      print(resp['error']);
    }
    print(list.length);
    return list;
  }

  Future<String> postBooking(EventBooking booking) async {
    String url = "${apiUrl}event/booking";

    var body = jsonEncode(booking.toJson(booking));
    print(body);

    var response = await http.post(Uri.parse(url),
        body: body, headers: {'content-type': 'application/json'});

    String respMsg = "";
    print(response.body);
    var resp = jsonDecode(response.body);
    if (resp['ok'] == "yes") {
      respMsg = "0|Successfully submitted booking";
    } else {
      respMsg = "1|" + resp['error'];
    }
    print(respMsg);
    return respMsg;
  }
}
