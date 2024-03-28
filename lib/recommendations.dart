
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Account.dart';
import 'package:flutter_application_1/FlightBookingHomePage.dart';
import 'package:flutter_application_1/MyFlight.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'App',
      home: ReviewScreen(),
    );
  }
}

class ReviewScreen extends StatelessWidget {
  final List<Review> reviews = [
    Review(avatar: 'images/aa.jpg', name: 'Sara', reviewText: 'had a great experience!', rating: 4),
    Review(avatar: 'images/bb.jpg', name: 'Ahmad', reviewText: "The best airline 💛", rating: 5),
    Review(avatar: 'images/cc.jpg', name: 'Noura', reviewText: "Great staff and services !", rating: 4),
    Review(avatar: 'images/dd.jpg', name: 'Abdullah', reviewText: "Everything was great 😍", rating: 5),
    Review(avatar: 'images/aa.jpg', name: 'Sarah', reviewText: "The service was slow ", rating: 2),
    Review(avatar: 'images/bb.jpg', name: 'Khaled', reviewText: 'had a great experience!', rating: 4),
    Review(avatar: 'images/cc.jpg', name: 'Maha', reviewText: "Everything was great 😍", rating: 5),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Recommendation',
          style: TextStyle(
            color: Color(0xFFF3F9FB),
          ),
        ),
        backgroundColor: Color(0xFF1BAEC6),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: reviews.length,
        itemBuilder: (context, index) {
          return ReviewCard(review: reviews[index]);
        },
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
                    color: Colors.grey,
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
                    color: Color(0xFF096499),
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

class Review {
  final String name;
  final String reviewText;
  final int rating;
  final String avatar;

  Review({required this.avatar, required this.name, required this.reviewText, required this.rating});
}

class ReviewCard extends StatelessWidget {
  final Review review;

  ReviewCard({required this.review});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: AssetImage(review.avatar),
          backgroundColor: Colors.transparent,
        ),
        title: Text(review.name, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(review.reviewText),
            SizedBox(height: 4),
            Row(
              children: List.generate(5, (index) {
                return Icon(
                  index < review.rating ? Icons.star : Icons.star_border,
                  color: Colors.amber,
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}


