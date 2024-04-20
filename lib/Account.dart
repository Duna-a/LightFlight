import 'package:flutter/material.dart';
import 'editProfile.dart';
import 'addNewCard.dart';
import 'recommendations.dart';
import 'MyFlight.dart';
import 'FlightBookingHomePage.dart';
import 'main.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Account(),
    );
  }
}

class Account extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF3F9FB),
      appBar: AppBar(
        title: Text(
          'My Account',
          style: TextStyle(
            color: Color(0xFFF3F9FB),
          ),
        ),
        backgroundColor: Color(0xFF1BAEC6),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 1,
          padding: EdgeInsets.all(10),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.9,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 5,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Account Details',
                      style: TextStyle(
                        color: Color(0xFF096499),
                        fontSize: 23,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    MaterialButton(
                      minWidth: 100,
                      height: 40,
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => EditProfileForm()));
                      },
                      color: Color.fromARGB(255, 104, 204, 220),
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          color: Color(0xFF1BAEC6),
                        ),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Text(
                        "Edit",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Name',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      'Ruba Ahmad',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 15),
                    Text(
                      'Email',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      'example@gmail.com',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30),
                Divider(),
                SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Credit Card Details',
                      style: TextStyle(
                        color: Color(0xFF096499),
                        fontSize: 23,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    MaterialButton(
                      minWidth: 100,
                      height: 40,
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CreditCardForm()));
                      },
                      color: Color.fromARGB(255, 104, 204, 220),
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          color: Color(0xFF1BAEC6),
                        ),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Text(
                        "Add New",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 15),
                Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Color(0xFFF3F9FB),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Color(0xFF096499)),
                  ),
                  child: Text(
                    'Ruba Ahmad - 9906',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),
                ),
                SizedBox(height: 40),
                MaterialButton(
                  minWidth: 100,
                  height: 40,
                  onPressed: () {
                    showDeleteConfirmationDialog(context, 'Ruba Ahmad - 9906');
                  },
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Text(
                    "Delete",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                ),
                SizedBox(height: 50),
                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => (welcomPage())));
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        Colors.red,
                      ),
                      elevation: MaterialStateProperty.all(5),
                    ),
                    child: Text(
                      'Logout',
                      style: TextStyle(
                        color: Color(0xFFF3F9FB),
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
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
                        builder: (context) => FlightBookingHomePage.noParams(),
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
                    color: Color(0xFF096499),
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

void showDeleteConfirmationDialog(BuildContext context, String cardDetails) {
  bool isChecked = false;

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Color(0xFFF3F9FB),
        title: Text('Delete Card'),
        content: StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Are you sure you want to delete the following card?'),
                SizedBox(height: 10),
                Row(
                  children: [
                    Checkbox(
                      value: isChecked,
                      onChanged: (value) {
                        setState(() {
                          isChecked = value!;
                        });
                      },
                      checkColor: Color(0xFF1BAEC6),
                      activeColor: Color(0xFF096499),
                    ),
                    Text(
                      cardDetails,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.white),
              side: MaterialStateProperty.all(BorderSide(color: Colors.black)),
            ),
            child: Text(
              "Cancel",
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              if (isChecked) {
                Navigator.pop(context);
              } else {}
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.red),
            ),
            child: Text(
              "Delete",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ),
        ],
      );
    },
  );
}
