import 'package:adminapp/main.dart';
import 'package:flutter/material.dart';

class Place extends StatefulWidget {
  const Place({super.key});

  @override
  State<Place> createState() => _PlaceState();
}

class _PlaceState extends State<Place> {
  bool _isFormVisible = false;
  final Duration _animationDuration = const Duration(milliseconds: 300);

  final TextEditingController _placeController = TextEditingController();
  String? _selectedDistrict;

  List<Map<String, dynamic>> districtList = [];
  List<Map<String, dynamic>> placeList = [];

  Future<void> fetchDistricts() async {
    try {
      final response = await supabase.from('tbl_district').select();
      setState(() {
        districtList = response;
      });
    } catch (e) {
      print("ERROR FETCHING DISTRICTS: $e");
    }
  }

  Future<void> insertPlace() async {
    try {
      String name = _placeController.text;
      await supabase.from('tbl_place').insert({
        'place_name': name,
        'district_id': _selectedDistrict
      });
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Place Added Successfully",
            style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.green,
      ));
      fetchPlaces();
      _placeController.clear();
      _selectedDistrict = null;
    } catch (e) {
      print("ERROR INSERTING PLACE: $e");
    }
  }

  Future<void> fetchPlaces() async {
    try {
      final response = await supabase.from('tbl_place').select();
      setState(() {
        placeList = response;
      });
    } catch (e) {
      print("ERROR FETCHING PLACES: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    fetchDistricts();
    fetchPlaces();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Manage Places",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF161616),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)),
                  padding: EdgeInsets.symmetric(horizontal: 25, vertical: 18),
                ),
                onPressed: () {
                  setState(() {
                    _isFormVisible = !_isFormVisible;
                    if (!_isFormVisible) {
                      _placeController.clear();
                      _selectedDistrict = null;
                    }
                  });
                },
                label: Text(_isFormVisible ? "Cancel" : "Add Place",
                    style: TextStyle(color: Colors.white)),
                icon: Icon(
                  _isFormVisible ? Icons.cancel : Icons.add,
                  color: Colors.white,
                ),
              )
            ],
          ),
          AnimatedSize(
            duration: _animationDuration,
            curve: Curves.easeInOut,
            child: _isFormVisible
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        DropdownButtonFormField<String>(
                          value: _selectedDistrict,
                          hint: Text("Select District"),
                          items: districtList.map((district) {
                            return DropdownMenuItem<String>(
                              value: district['id'].toString(),
                              child: Text(district['district_name']),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              _selectedDistrict = value;
                            });
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                          ),
                        ),
                        SizedBox(height: 10),
                        TextField(
                          controller: _placeController,
                          decoration: InputDecoration(
                            labelText: "Place Name",
                            border: OutlineInputBorder(),
                          ),
                        ),
                        SizedBox(height: 10),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            padding:
                                EdgeInsets.symmetric(vertical: 15, horizontal: 50),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5)),
                          ),
                          onPressed: () {
                            insertPlace();
                          },
                          child: Text("Submit", style: TextStyle(color: Colors.white)),
                        ),
                      ],
                    ),
                  )
                : Container(),
          ),
          SizedBox(height: 20),
          Text("Places Table",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: [
                  DataColumn(label: Text("Sl No")),
                  DataColumn(label: Text("District Name")),
                  DataColumn(label: Text("Place Name")),
                ],
                rows: placeList.asMap().entries.map((entry) {
                  return DataRow(cells: [
                    DataCell(Text((entry.key + 1).toString())),
                    DataCell(Text(entry.value['district_name'] ?? "")),
                    DataCell(Text(entry.value['place_name'])),
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
