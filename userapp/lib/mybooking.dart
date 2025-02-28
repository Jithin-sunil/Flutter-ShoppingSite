import 'package:flutter/material.dart';

class MyBookingsPage extends StatefulWidget {
  @override
  _MyBookingsPageState createState() => _MyBookingsPageState();
}

class _MyBookingsPageState extends State<MyBookingsPage> {
  List<Map<String, dynamic>> myBookings = [
    {
      'id': '#12345',
      'name': 'Luxury Perfume',
      'price': 99,
      'image': 'assets/perfume1.jpg',
      'status': 'Shipped',
      'tracking': ['Ordered', 'Packed', 'Shipped'],
    },
    {
      'id': '#12346',
      'name': 'Rose Fragrance',
      'price': 120,
      'image': 'assets/perfume2.jpg',
      'status': 'Delivered',
      'tracking': ['Ordered', 'Packed', 'Shipped', 'Delivered'],
    },
    {
      'id': '#12347',
      'name': 'Floral Scent',
      'price': 80,
      'image': 'assets/perfume3.jpg',
      'status': 'Processing',
      'tracking': ['Ordered', 'Packed'],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Bookings'),
        backgroundColor: Colors.pinkAccent,
        centerTitle: true,
      ),
      body: myBookings.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.shopping_bag, size: 80, color: Colors.grey),
                  SizedBox(height: 10),
                  Text("No bookings found", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ],
              ),
            )
          : ListView.builder(
              itemCount: myBookings.length,
              itemBuilder: (context, index) {
                return bookingItemWidget(myBookings[index]);
              },
            ),
    );
  }

  Widget bookingItemWidget(Map<String, dynamic> booking) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Order ID
            Text("Order ID: ${booking['id']}", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.grey)),

            SizedBox(height: 10),

            // Product Image & Details
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(booking['image'], width: 70, height: 70, fit: BoxFit.cover),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(booking['name'], style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      SizedBox(height: 4),
                      Text("\$${booking['price']}", style: TextStyle(fontSize: 14, color: Colors.pinkAccent, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.pinkAccent.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(booking['status'], style: TextStyle(color: Colors.pinkAccent, fontWeight: FontWeight.bold)),
                ),
              ],
            ),

            SizedBox(height: 10),

            // Order Tracking Progress
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: ['Ordered', 'Packed', 'Shipped', 'Delivered']
                  .map((step) => Column(
                        children: [
                          Icon(
                            booking['tracking'].contains(step) ? Icons.check_circle : Icons.radio_button_unchecked,
                            color: booking['tracking'].contains(step) ? Colors.pinkAccent : Colors.grey,
                          ),
                          SizedBox(height: 4),
                          Text(step, style: TextStyle(fontSize: 12)),
                        ],
                      ))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
