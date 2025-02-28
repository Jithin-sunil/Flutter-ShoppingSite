import 'package:flutter/material.dart';

class ProductRatingPage extends StatefulWidget {
  @override
  _ProductRatingPageState createState() => _ProductRatingPageState();
}

class _ProductRatingPageState extends State<ProductRatingPage> {
  int selectedStars = 0;
  TextEditingController reviewController = TextEditingController();

  List<Map<String, dynamic>> reviews = [
    {'name': 'Alice', 'rating': 5, 'review': 'Amazing product! Totally worth it.'},
    {'name': 'John', 'rating': 4, 'review': 'Good quality, but shipping was slow.'},
  ];

  // Function to Submit Review
  void submitReview() {
    if (selectedStars == 0 || reviewController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please select a rating and write a review!')),
      );
      return;
    }

    setState(() {
      reviews.insert(0, {
        'name': 'You',
        'rating': selectedStars,
        'review': reviewController.text
      });
      selectedStars = 0;
      reviewController.clear();
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Review Submitted Successfully!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rate Product'),
        backgroundColor: Colors.pinkAccent,
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Rate this Product",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (index) {
                return IconButton(
                  icon: Icon(
                    Icons.star,
                    size: 32,
                    color: index < selectedStars ? Colors.amber : Colors.grey,
                  ),
                  onPressed: () {
                    setState(() {
                      selectedStars = index + 1;
                    });
                  },
                );
              }),
            ),

            SizedBox(height: 10),

            Text(
              "Write a Review",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            TextFormField(
              controller: reviewController,
              maxLines: 3,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Share your experience...",
              ),
            ),

            SizedBox(height: 15),

            Center(
              child: ElevatedButton(
                onPressed: submitReview,
                child: Text('Submit Review', style: TextStyle(fontSize: 16)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pinkAccent,
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 50),
                ),
              ),
            ),

            SizedBox(height: 20),
            Divider(),

            Text(
              "User Reviews",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            Expanded(
              child: ListView.builder(
                itemCount: reviews.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.pinkAccent,
                      child: Text(reviews[index]['name'][0]),
                    ),
                    title: Text(reviews[index]['name']),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: List.generate(5, (i) {
                            return Icon(
                              Icons.star,
                              size: 18,
                              color: i < reviews[index]['rating'] ? Colors.amber : Colors.grey,
                            );
                          }),
                        ),
                        SizedBox(height: 5),
                        Text(reviews[index]['review']),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
