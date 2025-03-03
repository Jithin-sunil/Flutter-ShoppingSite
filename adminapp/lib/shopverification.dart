import 'package:adminapp/main.dart';
import 'package:flutter/material.dart';

class VerifyShops extends StatefulWidget {
  const VerifyShops({super.key});

  @override
  State<VerifyShops> createState() => _VerifyShopsState();
}

class _VerifyShopsState extends State<VerifyShops> {
  List<Map<String, dynamic>> shopList = [];

  Future<void> fetchShops() async {
    try {
      final response = await supabase.from('tbl_shops').select();
      setState(() {
        shopList = response;
      });
    } catch (e) {
      print("ERROR FETCHING DATA: $e");
    }
  }

  Future<void> verifyShop(int shopId) async {
    try {
      await supabase.from('tbl_shops').update({'status': 'verified'}).eq('id', shopId);
      fetchShops();
    } catch (e) {
      print("ERROR VERIFYING SHOP: $e");
    }
  }

  Future<void> rejectShop(int shopId) async {
    try {
      await supabase.from('tbl_shops').update({'status': 'rejected'}).eq('id', shopId);
      fetchShops();
    } catch (e) {
      print("ERROR REJECTING SHOP: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    fetchShops();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Column(
        children: [
          Text("Verify Shops",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          SizedBox(height: 20),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: const [
                  DataColumn(label: Text("Shop Name")),
                  DataColumn(label: Text("Email")),
                  DataColumn(label: Text("Contact")),
                  DataColumn(label: Text("Address")),
                  DataColumn(label: Text("District")),
                  DataColumn(label: Text("Place")),
                  DataColumn(label: Text("Logo")),
                  DataColumn(label: Text("Proof")),
                  DataColumn(label: Text("Action")),
                ],
                rows: shopList.map((shop) {
                  return DataRow(cells: [
                    DataCell(Text(shop['shop_name'])),
                    DataCell(Text(shop['email'])),
                    DataCell(Text(shop['contact'])),
                    DataCell(Text(shop['address'])),
                    DataCell(Text(shop['district'])),
                    DataCell(Text(shop['place'])),
                    DataCell(Image.network(shop['logo'], width: 50, height: 50)),
                    DataCell(Image.network(shop['proof'], width: 50, height: 50)),
                    DataCell(Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.check, color: Colors.green),
                          onPressed: () => verifyShop(shop['id']),
                        ),
                        IconButton(
                          icon: const Icon(Icons.cancel, color: Colors.red),
                          onPressed: () => rejectShop(shop['id']),
                        ),
                      ],
                    ))
                  ]);
                }).toList(),
              ),
            ),
          )
        ],
      ),
    );
  }
}