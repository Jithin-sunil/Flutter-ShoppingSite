import 'package:adminapp/main.dart';
import 'package:flutter/material.dart';

class Category extends StatefulWidget {
  const Category({super.key});

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  bool _isFormVisible = false;
  final Duration _animationDuration = const Duration(milliseconds: 300);

  final TextEditingController _categoryController = TextEditingController();
  
  List<Map<String, dynamic>> categoryList = [];

  Future<void> insertCategory() async {
    try {
      String name = _categoryController.text;
      await supabase.from('tbl_category').insert({'category_name': name});
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Category Added Successfully", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.green,
      ));
      fetchCategories();
      _categoryController.clear();
    } catch (e) {
      print("ERROR INSERTING DATA: $e");
    }
  }

  Future<void> fetchCategories() async {
    try {
      final response = await supabase.from('tbl_category').select();
      setState(() {
        categoryList = response;
      });
    } catch (e) {
      print("ERROR FETCHING DATA: $e");
    }
  }

  int cid = 0;

  Future<void> editCategory() async {
    try {
      await supabase.from('tbl_category').update({'category_name': _categoryController.text}).eq('id', cid);
      fetchCategories();
      _categoryController.clear();
    } catch (e) {
      print("ERROR UPDATING DATA: $e");
    }
  }

  Future<void> deleteCategory(String cid) async {
    try {
      await supabase.from("tbl_category").delete().eq("id", cid);
      fetchCategories();
    } catch (e) {
      print("ERROR: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    fetchCategories();
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
              Text("Manage Categories", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF161616),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                  padding: EdgeInsets.symmetric(horizontal: 25, vertical: 18),
                ),
                onPressed: () {
                  setState(() {
                    _isFormVisible = !_isFormVisible;
                    if (!_isFormVisible) {
                      _categoryController.clear();
                      cid = 0;
                    }
                  });
                },
                label: Text(_isFormVisible ? "Cancel" : "Add Category", style: TextStyle(color: Colors.white)),
                icon: Icon(_isFormVisible ? Icons.cancel : Icons.add, color: Colors.white),
              )
            ],
          ),
          AnimatedSize(
            duration: _animationDuration,
            curve: Curves.easeInOut,
            child: _isFormVisible
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: _categoryController,
                      decoration: InputDecoration(
                        labelText: "Category Name",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  )
                : Container(),
          ),
          if (_isFormVisible)
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 50),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
              ),
              onPressed: () {
                if (cid == 0) {
                  insertCategory();
                } else {
                  editCategory();
                }
              },
              child: Text("Submit", style: TextStyle(color: Colors.white)),
            ),
          SizedBox(height: 20),
          Text("Categories Table", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: [
                  DataColumn(label: Text("Sl No")),
                  DataColumn(label: Text("Category Name")),
                  DataColumn(label: Text("Action")),
                ],
                rows: categoryList.asMap().entries.map((entry) {
                  return DataRow(cells: [
                    DataCell(Text((entry.key + 1).toString())),
                    DataCell(Text(entry.value['category_name'])),
                    DataCell(Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            deleteCategory(entry.value['id'].toString());
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.green),
                          onPressed: () {
                            setState(() {
                              _categoryController.text = entry.value['category_name'];
                              cid = entry.value['id'];
                              _isFormVisible = true;
                            });
                          },
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
