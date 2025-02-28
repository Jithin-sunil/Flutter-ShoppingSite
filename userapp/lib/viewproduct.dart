import 'package:flutter/material.dart';

class ViewAllProductsPage extends StatefulWidget {
  @override
  _ViewAllProductsPageState createState() => _ViewAllProductsPageState();
}

class _ViewAllProductsPageState extends State<ViewAllProductsPage> {
  List<Map<String, dynamic>> products = [
    {'name': 'Luxury Perfume', 'price': 99, 'image': 'assets/perfume1.jpg', 'favorite': false},
    {'name': 'Rose Fragrance', 'price': 120, 'image': 'assets/perfume2.jpg', 'favorite': false},
    {'name': 'Floral Scent', 'price': 80, 'image': 'assets/perfume3.jpg', 'favorite': false},
    {'name': 'Aqua Essence', 'price': 110, 'image': 'assets/perfume4.jpg', 'favorite': false},
    {'name': 'Sweet Blossom', 'price': 95, 'image': 'assets/perfume5.jpg', 'favorite': false},
    {'name': 'Fresh Citrus', 'price': 105, 'image': 'assets/perfume6.jpg', 'favorite': false},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Products'),
        backgroundColor: Colors.pinkAccent,
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: GridView.builder(
          itemCount: products.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 0.75,
          ),
          itemBuilder: (context, index) {
            return productCard(products[index]);
          },
        ),
      ),
    );
  }

  Widget productCard(Map<String, dynamic> product) {
    return GestureDetector(
      onTap: () {
        // Navigate to Product Details Page (You can implement this later)
      },
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                  child: Image.asset(product['image'], width: double.infinity, height: 120, fit: BoxFit.cover),
                ),
                Positioned(
                  top: 5,
                  right: 5,
                  child: IconButton(
                    icon: Icon(
                      product['favorite'] ? Icons.favorite : Icons.favorite_border,
                      color: product['favorite'] ? Colors.red : Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        product['favorite'] = !product['favorite'];
                      });
                    },
                  ),
                ),
              ],
            ),

            // Product Name & Price
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product['name'],
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 5),
                  Text(
                    "\$${product['price']}",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.pinkAccent),
                  ),
                ],
              ),
            ),

            Spacer(),

            // Add to Cart Button
            Container(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Add to cart functionality here
                },
                child: Text("Add to Cart"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pinkAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
