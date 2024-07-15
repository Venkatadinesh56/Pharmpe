import 'package:flutter/material.dart';
import 'MedicationDetailsScreen.dart';

class CategoryDetailsScreen extends StatefulWidget {
  final String categoryName;
  final List<dynamic> items;

  CategoryDetailsScreen({required this.categoryName, required this.items});

  @override
  _CategoryDetailsScreenState createState() => _CategoryDetailsScreenState();
}

class _CategoryDetailsScreenState extends State<CategoryDetailsScreen> {
  List<dynamic> _filteredItems = [];
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _filteredItems = widget.items;
    _searchController.addListener(_filterItems);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterItems() {
    String query = _searchController.text.toLowerCase();
    setState(() {
      _filteredItems = widget.items
          .where((item) => item['name'].toLowerCase().contains(query))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          decoration: InputDecoration(
            hintText: 'Search items...',
            border: InputBorder.none,
            hintStyle: TextStyle(color: Colors.white60),
            icon: Icon(Icons.search, color: Colors.white),
          ),
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.green,
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 0.75,
        ),
        itemCount: _filteredItems.length,
        itemBuilder: (context, index) {
          var item = _filteredItems[index];
          return GestureDetector(
            onTap: () {
              _navigateToMedicationDetails(context, item);
            },
            child: Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: double.infinity,
                      height: 140,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(item['imgurl1'] ?? 'assets/default.png'), // Provide a default image
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    SizedBox(height: 8),
                    Center(
                      child: Text(
                        item['name'] ?? 'No Name',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                    Center(
                      child: Text(
                        item['MRP'] != null ? '\$${item['MRP']}' : 'No Price',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _navigateToMedicationDetails(BuildContext context, dynamic item) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MedicationDetailsScreen(medication: item),
      ),
    );
  }
}
