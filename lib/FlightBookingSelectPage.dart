import 'package:flutter/material.dart';
import 'package:flutter_application_1/FlightBookingHomePage.dart';

import 'package:flutter_application_1/flight_data.dart';

class FlightBookingSelectPage extends StatelessWidget {
  const FlightBookingSelectPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF1BAEC6),
        title: Text(
          'Select a Seat',
          style: TextStyle(
            color: Color(0xFFF3F9FB),
          ),
        ),
      ),
      body: Container(
        color: Color.fromARGB(255, 255, 255, 255),
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  children: [
                    Container(
                      height: 12,
                      width: 12,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2),
                        border: Border.all(
                          color: Colors.grey[400]!,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    const Text("Available")
                  ],
                ),
                Row(
                  children: [
                    Container(
                      height: 12,
                      width: 12,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2),
                        color: Colors.grey[400],
                        border: Border.all(
                          color: Colors.grey[400]!,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    const Text("Booked")
                  ],
                ),
                Row(
                  children: [
                    Container(
                      height: 12,
                      width: 12,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2),
                        color: const Color.fromRGBO(53, 112, 255, 1),
                        border: Border.all(
                          color: Colors.grey[400]!,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    const Text("Selected")
                  ],
                )
              ],
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 24, 16, 24),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 7,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 16,
                    childAspectRatio: 0.68,
                  ),
                  itemCount: flightSeatItems.length,
                  itemBuilder: (context, index) {
                    final item = flightSeatItems[index];
                    if (item.seatType == SeatType.aisle) {
                      return Container();
                    }
                    return Column(
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey,
                              ),
                              borderRadius: BorderRadius.circular(4),
                              color: item.seatType == SeatType.available
                                  ? Colors.white
                                  : item.seatType == SeatType.booked
                                      ? Colors.blueGrey[50]
                                      : Color.fromARGB(186, 53, 114, 255),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Text(item.seatName),
                      ],
                    );
                  },
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => FlightBookingHomePage(),
                  ),
                );
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 20),
                decoration: BoxDecoration(
                  color: Color(0xFF1BAEC6),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Center(
                  child: Text(
                    "Book A Flight",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
