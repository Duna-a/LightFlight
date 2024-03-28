import 'package:flutter/material.dart';
import 'package:flutter_application_1/FlightBookingSelectPage.dart';

class FlightSearch extends StatelessWidget {
  const FlightSearch({Key? key}) : super(key: key);

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
        backgroundColor: Color(0xFF1BAEC6),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xFF1BAEC6),
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(
                          color: Colors.grey,
                          width: 0.5,
                        ),
                      ),
                      child: TextButton(
                        onPressed: () {},
                        child: Text(
                          'All',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 221, 221, 221),
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(
                          color: Colors.grey,
                          width: 0.5,
                        ),
                      ),
                      child: TextButton(
                        onPressed: () {},
                        child: Text(
                          'Price',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 221, 221, 221),
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(
                          color: Colors.grey,
                          width: 0.5,
                        ),
                      ),
                      child: TextButton(
                        onPressed: () {},
                        child: Text(
                          'Recommended',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12.2,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildFlightCard(
                  context,
                  "KW",
                  "Kuwait",
                  "12 : 20",
                  "EG",
                  "Egypt",
                  "14 : 15",
                  "\$ 34.92",
                ),
                buildFlightCard(
                  context,
                  "KW",
                  "Kuwait",
                  "1 : 20",
                  "EG",
                  "Egypt",
                  "3 : 15",
                  "\$ 55.92",
                ),
                buildFlightCard(
                  context,
                  "KW",
                  "Kuwait",
                  "8 : 20",
                  "EG",
                  "Egypt",
                  "10 : 15",
                  "\$ 46.92",
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildFlightCard(
    BuildContext context,
    String departureCode,
    String departureName,
    String departureTime,
    String destinationCode,
    String destinationName,
    String arrivalTime,
    String price,
  ) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey[300]!,
        ),
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Image.asset(
            'images/flynas.png',
            height: 42,
            width: 100,
            fit: BoxFit.cover,
          ),
          Container(
            height: 84,
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(departureCode),
                    Text(departureName),
                    Text(departureTime),
                  ],
                ),
                Expanded(
                  child: Icon(
                    Icons.flight,
                    size: 35,
                    color: Color(0xFF096499),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(destinationCode),
                    Text(destinationName),
                    Text(arrivalTime),
                  ],
                ),
              ],
            ),
          ),
          Row(
            children: [
              Text(
                price,
              ),
              Spacer(),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FlightBookingSelectPage(),
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.blue[100],
                    borderRadius: BorderRadius.circular(4),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 4,
                  ),
                  child: const Center(
                    child: Text(
                      "Select",
                      style: TextStyle(
                        color: Color(0xFF1BAEC6),
                      ),
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
