import 'package:flutter/material.dart';
import 'package:app/screens/MedicationDetailsScreen.dart';

class SearchScreen extends StatefulWidget {
  final List<dynamic> medications;

  SearchScreen({required this.medications});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<dynamic> _filteredMedications = [];
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _filteredMedications = widget.medications;
    _searchController.addListener(_filterMedications);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterMedications() {
    String query = _searchController.text.toLowerCase();
    setState(() {
      _filteredMedications = widget.medications
          .where((medication) =>
              medication['name'].toLowerCase().contains(query))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Categories'), // Update title to Categories
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // 2 items per row
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 0.75,
        ),
        itemCount: _filteredMedications.length,
        itemBuilder: (context, index) {
          var medication = _filteredMedications[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      MedicationDetailsScreen(medication: medication),
                ),
              );
            },
            child: Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        image: NetworkImage(medication['imgurl1']),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    medication['name'],
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    '${medication['Quantity']} ml - \$${medication['MRP']}',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
