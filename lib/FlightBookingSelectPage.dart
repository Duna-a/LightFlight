import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/FlightBookingHomePage.dart';
import 'checboxstate.dart';
import 'package:flutter_application_1/flight_data.dart';

class FlightBookingSelectPage extends StatefulWidget {
  final String email;
  final String from;
  final String to;
  final String date;
  final String flightClass;
  final String departureTime;
  final String arrivalTime;

  const FlightBookingSelectPage({
    Key? key,
    required this.email,
    required this.from,
    required this.to,
    required this.date,
    required this.flightClass,
    required this.departureTime,
    required this.arrivalTime,
  }) : super(key: key);

  @override
  _FlightBookingSelectPageState createState() =>
      _FlightBookingSelectPageState();
}

class _FlightBookingSelectPageState extends State<FlightBookingSelectPage> {
  late String email;
  late String from;
  late String to;
  late String date;
  late String flightClass;
  late String? airlineID;

  int selectedSeatIndex = 0; // Index of the seat you want to display in blue

  var services = [
    checkboxState(
        title: 'Le Petit Chef',
        Description:
            'Webpage: https://lepetitchef.com/le-meridien-paris?lang=EN'),
    checkboxState(
        title: 'Pink Mamma',
        Description:
            'Webpage: https://www.bigmammagroup.com/en/trattorias/pink-mamma'),
    checkboxState(
        title: 'Le Train Bleu',
        Description: 'Webpage: https://www.le-train-bleu.com/en/'),
    checkboxState(
        title: 'Andia',
        Description: 'Webpage: https://www.andia-restaurant.com/'),
  ];

  var services2 = [
    checkboxState(
        title: 'rentalCars',
        Description: 'Webpage:https://www.rentalcars.com/en/country/fr'),
    checkboxState(
        title: 'Europcar',
        Description:
            'Webpage:https://www.europcar.com/en/car-rental/locations/france'),
    checkboxState(
        title: 'Cars Scanner',
        Description: 'Webpage:https://www.rentalcars.com/car-rental/france'),
    checkboxState(
        title: 'Kayak',
        Description:
            'Webpage:https://www.kayak.com/France-Car-Rentals.82.crc.html'),
  ];

  var services3 = [
    checkboxState(
        title: 'Eiffel Tower',
        Description: 'Webpage:https://www.toureiffel.paris/fr'),
    checkboxState(
        title: 'Arc de Triomphe',
        Description: 'Webpage:https://www.paris-arc-de-triomphe.fr/'),
    checkboxState(
        title: 'Palace of Versailles',
        Description: 'Webpage:https://www.chateauversailles.fr/'),
    checkboxState(
        title: 'Mémorial De Caen',
        Description: 'Webpage:https://www.memorial-caen.fr/'),
  ];

  @override
  void initState() {
    super.initState();
    email = widget.email;
    from = widget.from;
    to = widget.to;
    date = widget.date;
    flightClass = widget.flightClass;
  }

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
        centerTitle: true,
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
                              color: index == selectedSeatIndex
                                  ? Color.fromARGB(186, 53, 114, 255)
                                  : index % 2 == 0
                                      ? Colors.white
                                      : Colors.blueGrey[50],
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
                    builder: (context) => FlightBookingHomePage.noParams(),
                  ),
                );
              },
              child: ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => StatefulBuilder(
                      builder: (context, setStateInsideDialog) => AlertDialog(
                        contentPadding: EdgeInsets.all(10),
                        content: SizedBox(
                          width: MediaQuery.of(context).size.width * 80,
                          height: MediaQuery.of(context).size.height * 60,
                          child: DefaultTabController(
                            length: 3,
                            child: Scaffold(
                              appBar: AppBar(
                                bottom: TabBar(
                                  indicatorColor:
                                      Theme.of(context).primaryColorDark,
                                  labelStyle:
                                      Theme.of(context).textTheme.bodyMedium,
                                  unselectedLabelColor:
                                      Theme.of(context).primaryColorLight,
                                  tabs: const [
                                    Tab(text: "Diner"),
                                    Tab(text: "Car rental"),
                                    Tab(text: "attraction"),
                                  ],
                                ),
                                title: Text(
                                  'Concierge services',
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                              ),
                              body: TabBarView(
                                children: [
                                  SingleChildScrollView(
                                    child: Column(
                                      children: services
                                          .map((checkbox) =>
                                              buildingSingleCheckbox(checkbox,
                                                  setStateInsideDialog))
                                          .toList(),
                                    ),
                                  ),
                                  SingleChildScrollView(
                                    child: Column(
                                      children: services2
                                          .map((checkbox) =>
                                              buildingSingleCheckbox(checkbox,
                                                  setStateInsideDialog))
                                          .toList(),
                                    ),
                                  ),
                                  SingleChildScrollView(
                                    child: Column(
                                      children: services3
                                          .map((checkbox) =>
                                              buildingSingleCheckbox(checkbox,
                                                  setStateInsideDialog))
                                          .toList(),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                              insertData();
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) =>
                                      FlightBookingHomePage.noParams(),
                                ),
                              );
                            },
                            child: Text('Next',
                                style: Theme.of(context).textTheme.bodyLarge),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 60),
                  backgroundColor: Color(0xFF1BAEC6),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  "Book a flight",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildingSingleCheckbox(
          checkboxState checkbox, Function setStateInsideDialog) =>
      CheckboxListTile(
        title: Text(
          checkbox.title,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        value: checkbox.value,
        onChanged: (value) {
          setStateInsideDialog(() {
            checkbox.value = value!;
          });
        },
        activeColor: Theme.of(context).primaryColorDark,
        checkColor: Theme.of(context).primaryColorLight,
        subtitle: Text(
          checkbox.Description,
          style: Theme.of(context).textTheme.bodySmall,
        ),
        controlAffinity: ListTileControlAffinity.leading,
      );

  void insertData() async {
    final firestore = FirebaseFirestore.instance;

    QuerySnapshot flightSnapshot = await firestore
        .collection('AvaliableFlight')
        .where('Departure', isEqualTo: widget.from)
        .where('Destenation', isEqualTo: widget.to)
        .where('DepartureDate', isEqualTo: widget.date)
        .where('DepartureTime', isEqualTo: widget.departureTime)
        .where('ArrivalTime', isEqualTo: widget.arrivalTime)
        .get();

    if (flightSnapshot.docs.isEmpty) {
      print("No matching flight found");
      return;
    }

    var matchingFlight = flightSnapshot.docs.first;
    DocumentReference airlineRef = matchingFlight['AirlineID'];

    QuerySnapshot classSnapshot = await firestore
        .collection('Class')
        .where('Type', isEqualTo: widget.flightClass)
        .get();

    if (classSnapshot.docs.isEmpty) {
      print("No matching class found");
      return;
    }

    var matchingClass = classSnapshot.docs.first;
    DocumentReference classRef = matchingClass.reference;

    List<String> defaultConciergeIDs = ['con1', 'con2', 'con3'];
    DocumentReference seatRef = firestore.collection('Seat').doc('S2');

    try {
      await firestore.collection('Reservation').add({
        'Email': '/User/${widget.email}',
        'Email': firestore.doc('User/${widget.email}'),
        'airlineID': airlineRef,
        'classID': classRef,
        'seatID': seatRef,
        'conciergeID': defaultConciergeIDs
            .map(
                (conciergeID) => firestore.doc('ConciergeService/$conciergeID'))
            .toList(),
      });

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Booking added successfully!')));
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Failed to add booking: $e')));
    }
  }
}
