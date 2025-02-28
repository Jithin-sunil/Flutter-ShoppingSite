import 'package:flutter/material.dart';
import 'package:userapp/cart.dart';
import 'package:userapp/profile.dart';


class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int _selectedIndex = 0; // Track selected page index

  // Pages
  final List<Widget> _pages = [
    HomeScreen(), // Home Page
    CartPage(),   // Cart Page
    MyProfilePage() // Profile Page
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex], // Display selected page
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.pinkAccent,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'Cart'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}

// Extracted HomeScreen Widget
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppBar(
          title: Text('Perfume Store', style: TextStyle(fontWeight: FontWeight.bold)),
          centerTitle: true,
          backgroundColor: Colors.pinkAccent,
        ),
        // Banner Section
        Container(
          height: 180,
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/perfume_banner.jpg'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(height: 10),
        // Categories Section
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text('Categories', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ),
        SizedBox(height: 10),
        Container(
          height: 80,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              categoryItem('Men', Icons.man),
              categoryItem('Women', Icons.woman),
              categoryItem('Unisex', Icons.people),
            ],
          ),
        ),
        SizedBox(height: 10),
        // Featured Products
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text('Featured Perfumes', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ),
        SizedBox(height: 10),
        Expanded(
          child: GridView.builder(
            padding: EdgeInsets.symmetric(horizontal: 16),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 0.7,
            ),
            itemCount: 4,
            itemBuilder: (context, index) {
              return perfumeItem('Perfume ${index + 1}', 'assets/perfume${index + 1}.jpg', '\$99');
            },
          ),
        ),
      ],
    );
  }

  Widget categoryItem(String title, IconData icon) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: Chip(
        label: Text(title, style: TextStyle(color: Colors.white)),
        avatar: Icon(icon, color: Colors.white),
        backgroundColor: Colors.pinkAccent,
      ),
    );
  }

  Widget perfumeItem(String name, String image, String price) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
              child: Image.asset(image, width: double.infinity, fit: BoxFit.cover),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                Text(price, style: TextStyle(fontSize: 14, color: Colors.pinkAccent)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
