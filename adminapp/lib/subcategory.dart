import 'package:adminapp/main.dart';
import 'package:flutter/material.dart';

class SubCategory extends StatefulWidget {
  const SubCategory({super.key});

  @override
  State<SubCategory> createState() => _SubCategoryState();
}

class _SubCategoryState extends State<SubCategory> {
  bool _isFormVisible = false;
  final Duration _animationDuration = const Duration(milliseconds: 300);
  
  final TextEditingController _subcategoryController = TextEditingController();
  List<Map<String, dynamic>> subcategoryList = [];
  List<Map<String, dynamic>> categoryList = [];
  String? selectedCategory;

  Future<void> fetchCategories() async {
    try {
      final response = await supabase.from('tbl_category').select();
      setState(() {
        categoryList = response;
      });
    } catch (e) {
      print("ERROR FETCHING CATEGORIES: $e");
    }
  }

  Future<void> insertSubCategory() async {
    try {
      String name = _subcategoryController.text;
      await supabase.from('tbl_subcategory').insert({
        'subcategory_name': name,
        'category_id': selectedCategory
      });
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Subcategory Added Successfully",
            style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.green,
      ));
      fetchSubCategories();
      _subcategoryController.clear();
    } catch (e) {
      print("ERROR INSERTING DATA: $e");
    }
  }

  Future<void> fetchSubCategories() async {
    try {
      final response = await supabase.from('tbl_subcategory').select();
      setState(() {
        subcategoryList = response;
      });
    } catch (e) {
      print("ERROR FETCHING DATA: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    fetchCategories();
    fetchSubCategories();
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
              Text("Manage Subcategories",
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
                      _subcategoryController.clear();
                      selectedCategory = null;
                    }
                  });
                },
                label: Text(_isFormVisible ? "Cancel" : "Add Subcategory",
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
                        DropdownButtonFormField(
                          value: selectedCategory,
                          decoration: InputDecoration(
                            labelText: "Select Category",
                            border: OutlineInputBorder(),
                          ),
                          items: categoryList.map((category) {
                            return DropdownMenuItem(
                              value: category['id'].toString(),
                              child: Text(category['category_name']),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              selectedCategory = value as String?;
                            });
                          },
                        ),
                        SizedBox(height: 10),
                        TextField(
                          controller: _subcategoryController,
                          decoration: InputDecoration(
                            labelText: "Subcategory Name",
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ],
                    ),
                  )
                : Container(),
          ),
          if (_isFormVisible)
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 50),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
              ),
              onPressed: insertSubCategory,
              child: Text("Submit", style: TextStyle(color: Colors.white)),
            ),
          SizedBox(height: 20),
          Text("Subcategories Table",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: [
                  DataColumn(label: Text("Sl No")),
                  DataColumn(label: Text("Category")),
                  DataColumn(label: Text("Subcategory Name")),
                  DataColumn(label: Text("Action")),
                ],
                rows: subcategoryList.asMap().entries.map((entry) {
                  return DataRow(cells: [
                    DataCell(Text((entry.key + 1).toString())),
                    DataCell(Text(entry.value['category_id'].toString())),
                    DataCell(Text(entry.value['subcategory_name'])),
                    DataCell(Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () {},
                        ),
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.green),
                          onPressed: () {},
                        )
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
