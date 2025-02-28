import 'package:flutter/material.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<Map<String, dynamic>> cartItems = [
    {'name': 'Luxury Perfume', 'price': 99, 'image': 'assets/perfume1.jpg', 'quantity': 1},
    {'name': 'Rose Fragrance', 'price': 120, 'image': 'assets/perfume2.jpg', 'quantity': 1},
  ];

  double calculateTotal() {
    double total = 0;
    for (var item in cartItems) {
      total += item['price'] * item['quantity'];
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shopping Cart', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.pinkAccent,
        centerTitle: true,
      ),
      body: cartItems.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.shopping_cart, size: 80, color: Colors.grey),
                  SizedBox(height: 10),
                  Text("Your cart is empty", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ],
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) {
                      return cartItemWidget(cartItems[index], index);
                    },
                  ),
                ),

                // Checkout Section
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                    boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5)],
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Total:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          Text('\$${calculateTotal().toStringAsFixed(2)}',
                              style: TextStyle(fontSize: 18, color: Colors.pinkAccent, fontWeight: FontWeight.bold)),
                        ],
                      ),
                      SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: cartItems.isEmpty ? null : () {},
                        child: Text('Proceed to Checkout', style: TextStyle(fontSize: 16)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.pinkAccent,
                          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 50),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }

  Widget cartItemWidget(Map<String, dynamic> item, int index) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Row(
          children: [
            // Product Image
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(item['image'], width: 70, height: 70, fit: BoxFit.cover),
            ),
            SizedBox(width: 12),

            // Product Name & Price in Column
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item['name'], style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  SizedBox(height: 4),
                  Text('\$${item['price']}',
                      style: TextStyle(fontSize: 14, color: Colors.pinkAccent, fontWeight: FontWeight.bold)),
                ],
              ),
            ),

            // Quantity Controls
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.remove, color: Colors.pinkAccent),
                  onPressed: () {
                    setState(() {
                      if (item['quantity'] > 1) {
                        item['quantity']--;
                      } else {
                        cartItems.removeAt(index);
                      }
                    });
                  },
                ),
                Text('${item['quantity']}', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                IconButton(
                  icon: Icon(Icons.add, color: Colors.pinkAccent),
                  onPressed: () {
                    setState(() {
                      item['quantity']++;
                    });
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete, color: Colors.redAccent),
                  onPressed: () {
                    setState(() {
                      cartItems.removeAt(index);
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
