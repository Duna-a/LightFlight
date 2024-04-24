import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'Account.dart';
import 'recommendations.dart';
import 'FlightBookingHomePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyFlight(),
    );
  }
}

class MyFlight extends StatefulWidget {
  _ExpansionListState createState() => _ExpansionListState();
}

class _ExpansionListState extends State<MyFlight> {
  
  String myEmail = '';
  late List<Item> _data;
  bool _isLoading = true;

  TextEditingController departure = new TextEditingController();
  TextEditingController destination = new TextEditingController();
  TextEditingController departureDate = new TextEditingController();
  TextEditingController departuretime = new TextEditingController();
  TextEditingController arrivaTime = new TextEditingController();
  TextEditingController bookingClass = new TextEditingController();
  late List<String> departureAndDestinations;

  List<String> bookingclasses = [
    'First Class',
    'Economy',
    'Business',
    'Premium Economy'
  ];
  Future<void> fetchAndStoreFlights() async {
    departureAndDestinations = await getFlightArray();
  }

  String? ChoosedClass;
  String? ChoosedFlight;

  @override
  void initState() {
    super.initState();
    _fetch();
    fetchAndStoreFlights();
  }

  _fetch() async {
    //wait for user to sign/log in
    final user = await FirebaseAuth.instance.currentUser;
    //if the user signed/logged in
    if (user != null) {
      //get the id of the current user
      final userDoc = await FirebaseFirestore.instance
          .collection('User')
          .doc(user.uid)
          .get();
      //get email data of the user with this id
      myEmail = userDoc.data()?['Email'] ?? '';
      print(myEmail);
      //search in reservations for a user with this email -fk-
      final reservationsSnapshot = await FirebaseFirestore.instance
          .collection('Reservation')
          .where('Email',
              isEqualTo: FirebaseFirestore.instance.doc('User/$myEmail'))
          .get();
      List<Item> items = []; // List to store Item objects
      for (var reservationDoc in reservationsSnapshot.docs) {
        print('Reservation ID: ${reservationDoc.id}');
        print('Reservation Data: ${reservationDoc.data()}');
        //get the airline id 'fk'
        final airlineRef = reservationDoc.data()?['airlineID'];
        final airlineID = airlineRef != null ? airlineRef.id : '';
        //search for the airline with this id
        final airlineDoc = await FirebaseFirestore.instance
            .collection('Airline')
            .doc(airlineID)
            .get();
        print('Available airline info: ${airlineDoc.data()}');
        if (airlineDoc.exists) {
          //get available flight id
          final availableFlightRef = airlineDoc.data()?['AvaliableFlightID'];
          final availableFlightID =
              availableFlightRef != null ? availableFlightRef.id : '';
          //search for the available flight with this id
          final availableFlightDoc = await FirebaseFirestore.instance
              .collection('AvaliableFlight')
              .doc(availableFlightID)
              .get();
          if (availableFlightDoc.exists) {
            print('Available Flight info: ${availableFlightDoc.data()}');

            final classRef = reservationDoc.data()?['classID'];
            final classId = classRef != null ? classRef.id : '';
            final classDoc = await FirebaseFirestore.instance
                .collection('Class')
                .doc(classId)
                .get();
            print('class info: ${classDoc.data()}');

            final seatRef = reservationDoc.data()?['seatID'];
            final seatId = seatRef != null ? seatRef.id : '';
            final seatDoc = await FirebaseFirestore.instance
                .collection('Seat')
                .doc(seatId)
                .get();
            print('seat info: ${seatDoc.data()}');

            List<String> timeSplit =
                availableFlightDoc.data()?['DepartureTime'].split(':');
            int DepartureHour = int.parse(timeSplit[0]);
            int DepartureMinute = int.parse(timeSplit[1]);

            List<String> timeSplit2 =
                availableFlightDoc.data()?['ArrivalTime'].split(':');
            int arrivalHour = int.parse(timeSplit2[0]);
            int arrivalMinute = int.parse(timeSplit2[1]);

            Item item = Item(
              reservationID: reservationDoc.id,
              AirlineID: airlineID,
              availableFlightid: availableFlightID,
              logo: 'images/' + (airlineDoc.data()?['logo'] ?? ''),
              destination: availableFlightDoc.data()?['Destenation'] ?? '',
              departure: availableFlightDoc.data()?['Departure'] ?? '',
              departureTime: availableFlightDoc.data()?['DepartureTime'] ?? '',
              arrivalTime: availableFlightDoc.data()?['ArrivalTime'] ?? '',
              seatNum: seatDoc.id ?? '',
              departureDate: availableFlightDoc.data()?['DepartureDate'] ?? '',
              bookingClass: classDoc.data()?['Type'] ?? '',
              timeOfDayDeparure:
                  TimeOfDay(hour: DepartureHour, minute: DepartureMinute),
              timeOfDayArrival:
                  TimeOfDay(hour: arrivalHour, minute: arrivalMinute),
            );

            items.add(item);
          } else {
            print('AvailableFlight  is not for: $availableFlightID');
          }
        } else {
          print('Airline is not found for: $airlineID');
        }
      }
      setState(() {
        _data = items;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        appBar: AppBar(
          title: Text("View flights",
              style:
                  TextStyle(color: Theme.of(context).scaffoldBackgroundColor)),
          backgroundColor: Color(0xFF1BAEC6),
          centerTitle: true,
        ),
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text("View flights",
              style:
                  TextStyle(color: Theme.of(context).scaffoldBackgroundColor)),
          backgroundColor: Color(0xFF1BAEC6),
          centerTitle: true,
        ),
        
        body: SingleChildScrollView(
          child: Column(
            children: _data.map<Widget>((Item item) {
              return ExpansionTile(
                title: ListTile(
                  leading: Image.asset(item.logo),
                  title: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("From:",
                              style: Theme.of(context).textTheme.bodyLarge),
                          Text(item.departure,
                              style: Theme.of(context).textTheme.bodyMedium),
                        ],
                      ),
                      SizedBox(width: 100),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("To:",
                                style: Theme.of(context).textTheme.bodyLarge),
                            Text(item.destination,
                                style: Theme.of(context).textTheme.bodyMedium),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                children: [
                  ListTile(
                    leading: GestureDetector(
                      onTap: () {
                        EditFlightDetail(item);
                      },
                      child: Icon(Icons.edit),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Departure Date:",
                            style: Theme.of(context).textTheme.bodyMedium),
                        Text(item.departureDate,
                            style: Theme.of(context).textTheme.bodySmall),
                        Text("Departure time:",
                            style: Theme.of(context).textTheme.bodyMedium),
                        Text(item.departureTime,
                            style: Theme.of(context).textTheme.bodySmall),
                        Text("Arrival time:",
                            style: Theme.of(context).textTheme.bodyMedium),
                        Text(item.arrivalTime,
                            style: Theme.of(context).textTheme.bodySmall),
                        Text("Booking Class:",
                            style: Theme.of(context).textTheme.bodyMedium),
                        Text(item.bookingClass,
                            style: Theme.of(context).textTheme.bodySmall),
                        Text("Seat number:",
                            style: Theme.of(context).textTheme.bodyMedium),
                        Text(item.seatNum,
                            style: Theme.of(context).textTheme.bodySmall),
                        Text("Concierge Services:",
                            style: Theme.of(context).textTheme.bodyMedium),
                        Text("Restaurant:",
                            style: Theme.of(context).textTheme.bodyMedium),
                        Text("Pink Mamma",
                            style: Theme.of(context).textTheme.bodySmall),
                        Text("Car Rental:",
                            style: Theme.of(context).textTheme.bodyMedium),
                        Text("rentalCars",
                            style: Theme.of(context).textTheme.bodySmall),
                        Text("Tourist Spot:",
                            style: Theme.of(context).textTheme.bodyMedium),
                        Text("Palace of Versailles",
                            style: Theme.of(context).textTheme.bodySmall),
                      ],
                    ),
                    trailing: IconButton(
                      onPressed: () {
                        // Show dialog to confirm deletion
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text("Confirm Delete"),
                              content: Text(
                                  "Are you sure you want to delete this item?"),
                              actions: <Widget>[
                                TextButton(
                                  child: Text("Cancel"),
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pop(); // Dismiss the dialog
                                  },
                                ),
                                TextButton(
                                  child: Text("Delete"),
                                  onPressed: () async {
                                    // Delete the document from Firestore
                                    await FirebaseFirestore.instance
                                        .collection('Reservation')
                                        .doc(item.reservationID)
                                        .delete();

                                    // Use setState to remove the item from the local list and refresh the UI
                                    setState(() {
                                      _data.removeWhere((currentItem) =>
                                          currentItem.reservationID ==
                                          item.reservationID);
                                    });

                                    Navigator.of(context)
                                        .pop(); // Dismiss the dialog
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                      icon: Icon(Icons.delete),
                    ),
                  ),
                ],
                initiallyExpanded: item.isExpanded,
              );
            }).toList(),
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          child: Container(
            height: 80,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) =>
                              FlightBookingHomePage.noParams(),
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(
                            Icons.home_filled,
                            color: Colors.grey,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => MyFlight(),
                        ),
                      );
                    },
                    child: Icon(
                      Icons.airplane_ticket,
                      color: Color(0xFF096499),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => ReviewScreen(),
                        ),
                      );
                    },
                    child: Icon(
                      Icons.star,
                      color: Colors.grey,
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => Account(),
                        ),
                      );
                    },
                    child: Icon(
                      Icons.person_outline,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
  }

  Future<void> EditFlightDetail(Item item) async {
    String initialChoosedFlight =
        'From:${item.departure} To:${item.destination}';
    String initialChoosedClass = item.bookingClass;
    departuretime = TextEditingController(text: item.departureTime);
    arrivaTime = TextEditingController(text: item.arrivalTime);
    departureDate = TextEditingController(text: item.departureDate);

    await showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return AlertDialog(
            content: SingleChildScrollView(
              child: Column(
                children: [
                  DropdownButton<String>(
                    hint: Text('Change flights'),
                    value: initialChoosedFlight,
                    isExpanded: true,
                    onChanged: (newValue) {
                      if (newValue != null &&
                          newValue != initialChoosedFlight) {
                        showConfirmationDialog(
                            context,
                            "Confirm Flight Change!!",
                            "Are you sure you want to change the flight?", () {
                          setState(() {
                            initialChoosedFlight = newValue;
                          });
                          _UpdateAvailableFlight(newValue, item);
                        });
                      }
                    },
                    items: departureAndDestinations.map((valueItem) {
                      return DropdownMenuItem(
                        value: valueItem,
                        child: Text(valueItem),
                      );
                    }).toList(),
                  ),
                  DropdownButton<String>(
                    hint: Text('Update the booking class'),
                    value: initialChoosedClass,
                    isExpanded: true,
                    onChanged: (newValue) {
                      if (newValue != null && newValue != initialChoosedClass) {
                        showConfirmationDialog(
                            context,
                            "Confirm Booking Class Change!!",
                            "Are you sure you want to change the booking class?",
                            () {
                          setState(() {
                            initialChoosedClass = newValue;
                          });
                          _UpdateBokkingClass(newValue, item);
                        });
                      }
                    },
                    items: bookingclasses.map((valueItem) {
                      return DropdownMenuItem(
                        value: valueItem,
                        child: Text(valueItem),
                      );
                    }).toList(),
                  ),
                  TextField(
                    controller: departureDate,
                    decoration: InputDecoration(
                      labelText: 'Departure date',
                      filled: true,
                      prefixIcon: Icon(Icons.calendar_today),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context).primaryColorDark),
                      ),
                    ),
                    readOnly: true,
                    onTap: () => _selectDate(item),
                  ),
                  TextField(
                    controller: departuretime,
                    decoration: InputDecoration(labelText: 'Departure time'),
                    readOnly: true,
                    onTap: () => _showTimePickerDeparture(item),
                  ),
                  TextField(
                    controller: arrivaTime,
                    decoration: InputDecoration(labelText: 'Arrival time'),
                    readOnly: true,
                    onTap: () => _showTimePickerArrival(item),
                  ),
                ],
              ),
            ),
            title: Center(
                child: Text("Edit Flight",
                    style: Theme.of(context).textTheme.bodyMedium)),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('Close'),
              ),
            ],
          );
        },
      ),
    );
  }

  void showConfirmationDialog(
      BuildContext context, String title, String content, Function onConfirm) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: <Widget>[
            TextButton(
              child: Text('No'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: Text('Yes'),
              onPressed: () {
                onConfirm();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _selectDate(Item item) async {
    DateTime initialDate =
        DateTime.tryParse(item.departureDate) ?? DateTime.now();
    DateTime? _picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2024),
      lastDate: DateTime(2100),
    );
    if (_picked != null) {
      String formattedDate = DateFormat('yyyy/MM/dd').format(_picked);
      setState(() {
        departureDate.text = formattedDate;
        item.departureDate = formattedDate;
      });
      await FirebaseFirestore.instance
          .collection('AvaliableFlight')
          .doc(item.availableFlightid)
          .update({
        'DepartureDate': formattedDate,
      });
    }
  }

  Future<void> _showTimePickerDeparture(Item item) async {
    TimeOfDay? pickedTime = await showTimePicker(
        context: context, initialTime: item.timeOfDayDeparure);

    if (pickedTime != null) {
      setState(() {
        item.timeOfDayDeparure = pickedTime;
        String formattedHour1 = pickedTime.hour.toString().padLeft(2, '0');
        String formattedMinute1 = pickedTime.minute.toString().padLeft(2, '0');
        item.departureTime = '$formattedHour1:$formattedMinute1';
        departuretime.text = item.departureTime;
      });

      String formattedHour = pickedTime.hour.toString().padLeft(2, '0');
      String formattedMinute = pickedTime.minute.toString().padLeft(2, '0');
      String storeNewTime = '$formattedHour:$formattedMinute';

      await FirebaseFirestore.instance
          .collection('AvaliableFlight')
          .doc(item.availableFlightid)
          .update({
        'DepartureTime': storeNewTime,
      });
    }
  }

  Future<void> _showTimePickerArrival(Item item) async {
    TimeOfDay? pickedTime = await showTimePicker(
        context: context, initialTime: item.timeOfDayArrival);

    if (pickedTime != null) {
      setState(() {
        item.timeOfDayArrival = pickedTime;
        String formattedHour1 = pickedTime.hour.toString().padLeft(2, '0');
        String formattedMinute1 = pickedTime.minute.toString().padLeft(2, '0');
        item.arrivalTime = '$formattedHour1:$formattedMinute1';
        arrivaTime.text = item.arrivalTime;
      });

      String formattedHour = pickedTime.hour.toString().padLeft(2, '0');
      String formattedMinute = pickedTime.minute.toString().padLeft(2, '0');
      String storeNewTime = '$formattedHour:$formattedMinute';

      await FirebaseFirestore.instance
          .collection('AvaliableFlight')
          .doc(item.availableFlightid)
          .update({
        'DepartureTime': storeNewTime,
      });
    }
  }

  Future<void> _UpdateAvailableFlight(String newValue, Item item) async {
    var bySpace = newValue.split(" To:");
    String departure = bySpace[0].replaceFirst("From:", "");
    String destination = bySpace[1];

    if (departure.isNotEmpty && destination.isNotEmpty) {
      QuerySnapshot changeFlights = await FirebaseFirestore.instance
          .collection('AvaliableFlight')
          .where('Departure', isEqualTo: departure)
          .where('Destenation', isEqualTo: destination)
          .get();
      var newFlight = changeFlights.docs.first;
      print(newFlight.data());
      if (changeFlights.docs.isNotEmpty) {
        QuerySnapshot changeAirline = await FirebaseFirestore.instance
            .collection('Airline')
            .where('AvaliableFlightID', isEqualTo: newFlight.reference)
            .get();
        if (changeAirline.docs.isNotEmpty) {
          var newAirline = changeAirline.docs.first;
          print(newAirline.data());
          await FirebaseFirestore.instance
              .collection('Reservation')
              .doc(item.reservationID)
              .update({
            'airlineID': newAirline.reference,
          });
          print("Airline/${newAirline.id}");
          print("New Flight Reference: ${newAirline.reference.path}");
          print(newFlight.id);
          String documentId = newFlight.id.toString();
          print(documentId);
          DocumentSnapshot newFlightDetails = await FirebaseFirestore.instance
              .collection('AvaliableFlight')
              .doc(documentId)
              .get();
          print(newFlightDetails.data());
          DocumentSnapshot newAirline2 = await FirebaseFirestore.instance
              .collection('Airline')
              .doc(newAirline.id)
              .get();
          print(newAirline2.data());
          Map<String, dynamic> newAirlineData =
              newAirline2.data() as Map<String, dynamic>;
          Map<String, dynamic> newFlightData =
              newFlightDetails.data() as Map<String, dynamic>;

          setState(() {
            item.AirlineID = "Airline/${newAirline.id}";
            item.logo = 'images/' + (newAirlineData['logo']);
            item.departure = newFlightData['Departure'];
            item.destination = newFlightData['Destenation'];
            item.arrivalTime = newFlightData['ArrivalTime'];
            item.departureTime = newFlightData['DepartureTime'];
            item.departureDate = newFlightData['DepartureDate'];

            ChoosedFlight = 'From:${departure} To:${destination}';
          });
        }
      }
    }
  }

  Future<void> _UpdateBokkingClass(String newValue, Item item) async {
    Map<String, String> classMapping = {
      'Economy': 'class2',
      'Business': 'class3',
      'First Class': 'class1',
      'Premium Economy': 'class4',
    };

    String? classID = classMapping[newValue];

    if (classID != null) {
      DocumentReference classRef =
          FirebaseFirestore.instance.collection('Class').doc(classID);
      print(classRef);
      FirebaseFirestore.instance
          .collection('Reservation')
          .doc(item.reservationID)
          .update({
        'classID': classRef,
      });

      setState(() {
        item.bookingClass = newValue;
      });
    }
  }
}

Future<List<String>> getFlightArray() async {
  List<String> DepartureToDestination = [];

  final availableFlightDoc =
      await FirebaseFirestore.instance.collection('AvaliableFlight');

  QuerySnapshot flights = await availableFlightDoc.get();
  for (var availableFlight in flights.docs) {
    Map<String, dynamic> flightData =
        availableFlight.data() as Map<String, dynamic>;
    String departure = flightData?['Departure'] ?? '';
    String destination = flightData?['Destenation'] ?? '';
    DepartureToDestination.add('From:$departure To:$destination');
  }
  return DepartureToDestination;
}

class Item {
  String reservationID;
  String AirlineID;
  String availableFlightid;
  String logo;
  String destination;
  String departure;
  String departureTime;
  String arrivalTime;
  String seatNum;
  String departureDate;
  String bookingClass;
  TimeOfDay timeOfDayDeparure;
  TimeOfDay timeOfDayArrival;
  bool isExpanded;
  Item({
    required this.reservationID,
    required this.AirlineID,
    required this.availableFlightid,
    required this.logo,
    required this.destination,
    required this.departure,
    required this.departureTime,
    required this.arrivalTime,
    required this.seatNum,
    required this.departureDate,
    required this.bookingClass,
    required this.timeOfDayDeparure,
    required this.timeOfDayArrival,
    this.isExpanded = false,
  });
}