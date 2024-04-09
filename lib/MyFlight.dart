import 'package:flutter/material.dart';
import 'Account.dart';
import 'recommendations.dart';
import 'FlightBookingHomePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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

  @override
  void initState() {
    super.initState();
    _fetch();
  }

  _fetch() async {
    //wait for user to sign/log in
    final user = await FirebaseAuth.instance.currentUser;
    //if the user signed/logged in
    if (user != null) {
      //get the id of the current user
      final userDoc = await FirebaseFirestore.instance.collection('User').doc(user.uid).get();
      //get email data of the user with this id
      myEmail = userDoc.data()?['Email'] ?? '';
      print(myEmail);
    //search in reservations for a user with this email -fk-
      final reservationsSnapshot = await FirebaseFirestore.instance.collection('Reservation').where('Email', isEqualTo: FirebaseFirestore.instance.doc('User/$myEmail')).get();
      List<Item> items = []; // List to store Item objects
      for (var reservationDoc in reservationsSnapshot.docs) {
        print('Reservation ID: ${reservationDoc.id}');
        print('Reservation Data: ${reservationDoc.data()}');
      //get the airline id 'fk'
        final airlineRef = reservationDoc.data()?['airlineID'];
        final airlineID = airlineRef != null ? airlineRef.id : '';
      //search for the airline with this id
        final airlineDoc = await FirebaseFirestore.instance.collection('Airline').doc(airlineID).get();
        print('Available airline Data: ${airlineDoc.data()}');
        if (airlineDoc.exists) {
        //get available flight id
          final availableFlightRef = airlineDoc.data()?['AvaliableFlightID'];
          final availableFlightID = availableFlightRef != null ? availableFlightRef.id : '';
        //search for the available flight with this id
          final availableFlightDoc = await FirebaseFirestore.instance.collection('AvaliableFlight').doc(availableFlightID).get();
          if (availableFlightDoc.exists) {
            print('Available Flight Data: ${availableFlightDoc.data()}');

        final classRef= reservationDoc.data()?['classID'];
        final classId=  classRef !=null ? classRef.id: '';
        final classDoc= await FirebaseFirestore.instance.collection('Class').doc(classId).get();
        print ('class info: ${classDoc.data()}') ; 


        final seatRef= reservationDoc.data()?['seatID'];
        final seatId=  seatRef !=null ? seatRef.id: '';
        final seatDoc= await FirebaseFirestore.instance.collection('Seat').doc(seatId).get();
        print ('seat info: ${seatDoc.data()}') ; 



            Item item = Item(
              logo: 'images/'+ (airlineDoc.data()?['logo'] ?? ''),
              destination: availableFlightDoc.data()?['Destenation'] ?? '',
              departure: availableFlightDoc.data()?['Departure'] ?? '',
              departureTime: availableFlightDoc.data()?['DepartureTime'] ?? '',
              arrivalTime: availableFlightDoc.data()?['ArrivalTime'] ?? '',
              seatNum: seatDoc.id ?? '',
              departureDate: availableFlightDoc.data()?['DepartureDate'] ?? '',
              bookingClass: classDoc.data()?['Type'] ?? '',
            );

            items.add(item); 
          } else {
            print('Available Flight document not found for ID: $availableFlightID');
          }
        } else {
          print('Airline document not found for ID: $airlineID');
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
          title: Text("View flights", style: TextStyle(color: Theme.of(context).scaffoldBackgroundColor)),
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
          title: Text("View flights", style: TextStyle(color: Theme.of(context).scaffoldBackgroundColor)),
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
                          Text("From:", style: Theme.of(context).textTheme.bodyLarge),
                          Text(item.destination, style: Theme.of(context).textTheme.bodyMedium),
                        ],
                      ),
                      SizedBox(width: 100),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("To:", style: Theme.of(context).textTheme.bodyLarge),
                            Text(item.departure, style: Theme.of(context).textTheme.bodyMedium),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                children: [
                  ListTile(
                    leading: Icon(Icons.edit),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Departure Date:", style: Theme.of(context).textTheme.bodyMedium),
                        Text(item.departureDate, style: Theme.of(context).textTheme.bodySmall),
                        Text("Departure time:", style: Theme.of(context).textTheme.bodyMedium),
                        Text(item.departureTime, style: Theme.of(context).textTheme.bodySmall),
                        Text("Arrival time:", style: Theme.of(context).textTheme.bodyMedium),
                        Text(item.arrivalTime, style: Theme.of(context).textTheme.bodySmall),
                        Text("Booking Class:", style: Theme.of(context).textTheme.bodyMedium),
                        Text(item.bookingClass, style: Theme.of(context).textTheme.bodySmall),
                        Text("Seat number:", style: Theme.of(context).textTheme.bodyMedium),
                        Text(item.seatNum, style: Theme.of(context).textTheme.bodySmall),
                        Text("Concierge Services:", style: Theme.of(context).textTheme.bodyMedium),
                        Text("Restaurant:", style: Theme.of(context).textTheme.bodyMedium),
                        Text("Pink Mamma", style: Theme.of(context).textTheme.bodySmall),
                        Text("Car Rental:", style: Theme.of(context).textTheme.bodyMedium),
                        Text("rentalCars", style: Theme.of(context).textTheme.bodySmall),
                        Text("Tourist Spot:", style: Theme.of(context).textTheme.bodyMedium),
                        Text("Palace of Versailles", style: Theme.of(context).textTheme.bodySmall),
                      ],
                    ),
                    trailing: Icon(Icons.delete),
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
                          builder: (context) => FlightBookingHomePage(),
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
}

class Item {
  String logo;
  String destination;
  String departure;
  String departureTime;
  String arrivalTime;
  String seatNum;
  String departureDate;
  String bookingClass;
  bool isExpanded;
  Item({
    required this.logo,
    required this.destination,
    required this.departure,
    required this.departureTime,
    required this.arrivalTime,
    required this.seatNum,
    required this.departureDate,
    required this.bookingClass,
    this.isExpanded = false,
  });
}
