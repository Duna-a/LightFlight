import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/FlightBookingSelectPage.dart';

class FlightSearch extends StatelessWidget {
  final String from;
  final String to;
  final String date;
  final String flightClass;
  final String email;

  const FlightSearch({
    Key? key,
    required this.from,
    required this.to,
    required this.date,
    required this.flightClass,
    required this.email,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Search Results',
          style: TextStyle(
            color: Color(0xFFF3F9FB),
          ),
        ),
        centerTitle: true,
        backgroundColor: Color(0xFF1BAEC6),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('AvaliableFlight')
            .where('Departure', isEqualTo: from)
            .where('Destenation', isEqualTo: to)
            .where('DepartureDate', isEqualTo: date)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(
              child: Text('No flights available'),
            );
          }
          final flights = snapshot.data!.docs;
          return Expanded(
            child: ListView.builder(
              itemCount: flights.length,
              itemBuilder: (context, index) {
                final flightData =
                    flights[index].data() as Map<String, dynamic>;
                return buildFlightCard(
                  context,
                  flightData['Departure'],
                  flightData['Destenation'],
                  flightData['DepartureTime'],
                  flightData['ArrivalTime'],
                  flightData['Price'].toString(),
                  flightData['AirlineID'],
                );
              },
            ),
          );
        },
      ),
    );
  }

  Widget buildFlightCard(
    BuildContext context,
    String departure,
    String destination,
    String departureTime,
    String arrivalTime,
    String price,
    DocumentReference airlineRef,
  ) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: ListTile(
        contentPadding: EdgeInsets.all(16.0),
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(departure),
                  Text(departureTime),
                  Text('\$$price'),
                ],
              ),
            ),
            FutureBuilder<DocumentSnapshot>(
              future: airlineRef.get(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                }
                if (snapshot.hasError ||
                    !snapshot.hasData ||
                    !snapshot.data!.exists) {
                  return Icon(Icons.error);
                }
                final airlineData =
                    snapshot.data!.data() as Map<String, dynamic>;
                final logo = airlineData['logo'];
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 8.0), // Updated padding
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'images/$logo',
                        width: 55,
                        height: 55,
                      ),
                      Icon(Icons.flight),
                    ],
                  ),
                );
              },
            ),
            SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(destination),
                  Text(arrivalTime),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FlightBookingSelectPage(
                            from: from,
                            to: to,
                            date: date,
                            flightClass: flightClass,
                            email: email,
                            departureTime: departureTime,
                            arrivalTime: arrivalTime,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.blue[100],
                        borderRadius: BorderRadius.circular(4),
                      ),
                      width: 70,
                      height: 40,
                      child: const Center(
                        child: Text(
                          "Select",
                          style: TextStyle(
                            color: Color(0xFF1BAEC6),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
