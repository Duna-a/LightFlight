import 'package:flutter/material.dart';
import 'package:flutter_application_1/Account.dart';
import 'package:flutter_application_1/FlightSearch.dart';
import 'package:flutter_application_1/MyFlight.dart';
import 'package:flutter_application_1/recommendations.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:flutter_application_1/FlightBookingSelectPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FlightBookingHomePage.noParams(),
    );
  }
}

class FlightBookingHomePage extends StatefulWidget {
  final String email;

  const FlightBookingHomePage({Key? key, required this.email})
      : super(key: key);

  const FlightBookingHomePage.noParams({Key? key})
      : email = '',
        super(key: key);

  @override
  _FlightBookingHomePageState createState() => _FlightBookingHomePageState();
}

class _FlightBookingHomePageState extends State<FlightBookingHomePage> {
  // State variables
  String fromValue = '';
  String toValue = '';
  String dateValue = '';
  String flightClassValue = '';
  String myEmail = '';

  @override
  void initState() {
    super.initState();
    fetchEmail();
  }

  Future<void> fetchEmail() async {
    try {
      final user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        final userDoc = await FirebaseFirestore.instance
            .collection('User')
            .doc(user.uid)
            .get();

        setState(() {
          myEmail = userDoc.data()?['Email'] ?? '';
        });

        print(myEmail);
      } else {
        print("User is not logged in.");
      }
    } catch (e) {
      print("An error occurred while fetching email: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    color: Color(0xFF1BAEC6),
                  ),
                ),
                Expanded(
                  child: Container(
                    color: Color(0xFFF3F9FB),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            left: 16,
            right: 16,
            top: 24,
            bottom: 0,
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Hello",
                            style: TextStyle(
                              color: Color(0xFFF3F9FB),
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            "Where are you flying to?",
                            style: TextStyle(
                              color: Color(0xFFF3F9FB),
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                    ],
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: buildSearchCard(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: buildBottomNavigationBar(),
    );
  }

  Widget buildSearchCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            buildTextField(
              icon: Icons.flight_takeoff,
              hintText: 'From',
              onChanged: (value) {
                fromValue = value;
              },
            ),
            buildTextField(
              icon: Icons.flight_land,
              hintText: 'To',
              onChanged: (value) {
                toValue = value;
              },
            ),
            buildDateTextField(),
            buildFlightClassDropdown(),
            const SizedBox(height: 40),
            buildSelectFlightButton(),
          ],
        ),
      ),
    );
  }

  Widget buildTextField({
    required IconData icon,
    required String hintText,
    required ValueChanged<String> onChanged,
  }) {
    return Container(
      height: 48,
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: TextField(
        onChanged: onChanged,
        decoration: InputDecoration(
          icon: Icon(icon),
          hintText: hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }

  // New function for date picker
  Widget buildDateTextField() {
    return Container(
      height: 48,
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Icon(Icons.calendar_today),
          const SizedBox(width: 8),
          Expanded(
            child: GestureDetector(
              onTap: () => selectDate(context),
              child: Text(
                dateValue.isEmpty ? 'Select a Date' : dateValue,
                style: TextStyle(
                    color: dateValue.isEmpty
                        ? Color.fromARGB(255, 109, 109, 109)
                        : Colors.black),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      final DateFormat formatter = DateFormat('yyyy/MM/dd');
      final String formattedDate = formatter.format(pickedDate);

      setState(() {
        dateValue = formattedDate;
      });
    }
  }

  Widget buildFlightClassDropdown() {
    return Container(
      height: 48,
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Icon(Icons.airline_seat_recline_extra,
              color: Color.fromARGB(255, 53, 52, 52)),
          const SizedBox(width: 8),
          Expanded(
            child: DropdownButton<String>(
              hint: Text('Select a class'),
              value: flightClassValue.isEmpty ? null : flightClassValue,
              items: [
                DropdownMenuItem(
                  value: 'Economy',
                  child: Text('Economy Class'),
                ),
                DropdownMenuItem(
                  value: 'Business',
                  child: Text('Business Class'),
                ),
                DropdownMenuItem(
                  value: 'First Class',
                  child: Text('First Class'),
                ),
                DropdownMenuItem(
                  value: 'Premium Economy',
                  child: Text('Premium Economy'),
                ),
              ],
              isExpanded: true,
              onChanged: (value) {
                setState(() {
                  flightClassValue = value!;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSelectFlightButton() {
    return GestureDetector(
      onTap: navigateToFlightSelectPage,
      child: Container(
        height: 48,
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: Color(0xFF1BAEC6),
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Center(
          child: Text(
            "Select Flight",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  Widget buildBottomNavigationBar() {
    return BottomAppBar(
      child: Container(
        height: 80,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          children: [
            buildNavItem(Icons.home_filled, Color(0xFF096499), () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => FlightBookingHomePage.noParams(),
                ),
              );
            }),
            buildNavItem(Icons.airplane_ticket, Colors.grey, () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => MyFlight(),
                ),
              );
            }),
            buildNavItem(Icons.star, Colors.grey, () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => ReviewScreen(),
                ),
              );
            }),
            buildNavItem(Icons.person_outline, Colors.grey, () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => Account(),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget buildNavItem(IconData icon, Color color, Function() onTap) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 40,
          child: Column(
            children: [
              Icon(icon, color: color),
            ],
          ),
        ),
      ),
    );
  }

  void navigateToFlightSelectPage() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => FlightSearch(
          from: fromValue,
          to: toValue,
          date: dateValue,
          flightClass: flightClassValue,
          email: myEmail,
        ),
      ),
    );
  }
}
