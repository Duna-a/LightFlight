import 'package:flutter/material.dart';
import 'Account.dart';
import 'recommendations.dart';
import 'FlightBookingHomePage.dart';

class MyFlight extends StatefulWidget {
  @override
  _ExpansionListState createState() => _ExpansionListState();
}

class _ExpansionListState extends State<MyFlight> {
  final List<Map<String, String>> itemData = [
    {
      'logo': 'images/saudia.png',
      'destination': 'Riyadh',
      'departure': 'France',
      'departureTime':'9:30PM',
      'arrivalTime':'12:10AM',
      'seatNum':'S01',
      'departureDate': '01/01/2024',
      'bookingClass': 'Business',
    },
    {
      'logo': 'images/flynas.png',
      'destination': 'Dubai',
      'departure': 'Cairo',
      'departureTime':'9:00AM',
      'arrivalTime':'3:00PM',
      'seatNum':'S02',
      'departureDate': '23/01/2024',
      'bookingClass': 'Economy',
    },
    {
      'logo': 'images/gulf.png',
      'destination': 'Riyadh',
      'departure': 'London',
      'departureTime':'7:00PM',
      'arrivalTime':'2:00AM',
      'seatNum':'S03',
      'departureDate': '27/08/2024',
      'bookingClass': 'Premium economy',
    },
    {
      'logo': 'images/kuwait.jpeg',
      'destination': 'Kuwait',
      'departure': 'Paris',
      'departureTime':'6:30AM',
      'arrivalTime':'10:15AM',
      'seatNum':'S04',
      'departureDate': '01/10/2024',
      'bookingClass': 'First class',
    },

  ];

  @override
  Widget build(BuildContext context) {
    List<Item> _data = generateItems(itemData);

    return Scaffold(
      appBar: AppBar(
        title: Text("View flights",style:TextStyle(color: Theme.of(context).scaffoldBackgroundColor)),
        backgroundColor: Theme.of(context).primaryColorLight,
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
                        Text("From:",style: Theme.of(context).textTheme.bodyLarge, ),

                        Text( item.destination,style: Theme.of(context).textTheme.bodyMedium,),
                      ],
                    ),
                    SizedBox(width: 100,),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text( "To:", style: Theme.of(context).textTheme.bodyLarge, ),

                          Text(item.departure,style: Theme.of(context).textTheme.bodyMedium,),
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
                      Text("Departure Date:",style: Theme.of(context).textTheme.bodyMedium,),

                      Text( item.departureDate,style: Theme.of(context).textTheme.bodySmall, ),

                      Text("Departure time:",style: Theme.of(context).textTheme.bodyMedium, ),

                      Text(item.departureTime,style: Theme.of(context).textTheme.bodySmall,),

                      Text("Arrival time:",style: Theme.of(context).textTheme.bodyMedium, ),

                      Text(item.arrivalTime,style: Theme.of(context).textTheme.bodySmall,),

                      Text("Booking Class:",style: Theme.of(context).textTheme.bodyMedium, ),

                      Text(item.bookingClass, style: Theme.of(context).textTheme.bodySmall, ),

                      Text("Seat number:",style: Theme.of(context).textTheme.bodyMedium,),

                      Text(item.seatNum, style: Theme.of(context).textTheme.bodySmall,),

                      Text( "Concierge Services:",style: Theme.of(context).textTheme.bodyMedium, ),

                      Text("Restaurant:", style: Theme.of(context).textTheme.bodyMedium,),

                      Text( "Pink Mamma", style: Theme.of(context).textTheme.bodySmall, ),

                      Text("Car Rental:",style: Theme.of(context).textTheme.bodyMedium, ),

                      Text( "rentalCars",style: Theme.of(context).textTheme.bodySmall,),

                      Text("Tourist Spot:",style: Theme.of(context).textTheme.bodyMedium, ),

                      Text("Palace of Versailles",style: Theme.of(context).textTheme.bodySmall, ),
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
                        builder: (context) => MyApp(),
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

List<Item> generateItems(List<Map<String, String>> itemData) {
  return itemData.map((item) {
    return Item(
      logo: item['logo'] ?? '',
      destination: item['destination'] ?? '',
      departure: item['departure'] ?? '',
      departureTime: item['departureTime'] ?? '',
      arrivalTime: item['arrivalTime'] ?? '',
      seatNum: item['seatNum'] ?? '',
      departureDate: item['departureDate'] ?? '',
      bookingClass: item['bookingClass'] ?? '',
    );
  }).toList();
}
