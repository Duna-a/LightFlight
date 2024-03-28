import 'package:flutter/material.dart';
import 'package:flutter_application_1/Account.dart';
import 'package:flutter_application_1/FlightSearch.dart';
import 'package:flutter_application_1/MyFlight.dart';
import 'recommendations.dart';

class FlightBookingHomePage extends StatefulWidget {
  const FlightBookingHomePage({Key? key}) : super(key: key);

  @override
  State<FlightBookingHomePage> createState() => _FlightBookingHomePageState();
}

class _FlightBookingHomePageState extends State<FlightBookingHomePage> {
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
                        children: const [
                          Text(
                            "Hello",
                            style: TextStyle(
                              color: Color(0xFFF3F9FB),
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            "Where Are Flying to?",
                            style: TextStyle(
                              color: Color(0xFFF3F9FB),
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Container(
                        height: 48,
                        width: 48,
                      ),
                    ],
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            child: Card(
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  children: [
                                    Container(
                                      height: 48,
                                      margin: const EdgeInsets.only(bottom: 12),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors.grey[300]!,
                                        ),
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 16,
                                      ),
                                      child: const TextField(
                                        decoration: InputDecoration(
                                          icon: Icon(Icons.flight_takeoff),
                                          hintText: 'From',
                                          border: InputBorder.none,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 48,
                                      margin: const EdgeInsets.only(bottom: 12),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors.grey[300]!,
                                        ),
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 16,
                                      ),
                                      child: const TextField(
                                        decoration: InputDecoration(
                                          icon: Icon(Icons.flight_land),
                                          hintText: 'To',
                                          border: InputBorder.none,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 48,
                                      margin: const EdgeInsets.only(bottom: 12),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors.grey[300]!,
                                        ),
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 16,
                                      ),
                                      child: const TextField(
                                        decoration: InputDecoration(
                                          icon: Icon(Icons.calendar_month),
                                          hintText: 'Select a Date',
                                          border: InputBorder.none,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 48,
                                      margin: const EdgeInsets.only(bottom: 12),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors.grey[300]!,
                                        ),
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 16,
                                      ),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          const Icon(
                                            Icons.airline_seat_recline_extra,
                                          ),
                                          const SizedBox(
                                            width: 16,
                                          ),
                                          Expanded(
                                            child: DropdownButton<String>(
                                              hint: Text('Select a class'),
                                              items: [
                                                DropdownMenuItem(
                                                  value: 'Economy Class',
                                                  child: Text("Economy Class"),
                                                ),
                                                DropdownMenuItem(
                                                  value: 'First Class',
                                                  child: Text("First Class"),
                                                ),
                                                DropdownMenuItem(
                                                  value: 'Business Class',
                                                  child: Text("Business Class"),
                                                ),
                                              ],
                                              isExpanded: true,
                                              onChanged: (value) {
                                                print(value);
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 40),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                FlightSearch(),
                                          ),
                                        );
                                      },
                                      child: Container(
                                        height: 48,
                                        margin:
                                            const EdgeInsets.only(bottom: 12),
                                        decoration: BoxDecoration(
                                          color: Color(0xFF1BAEC6),
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        child: const Center(
                                          child: Text(
                                            "Search",
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
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
                          color: Color(0xFF096499),
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
                    color: Colors.grey,
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
