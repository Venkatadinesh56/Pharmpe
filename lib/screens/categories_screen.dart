import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:app/screens/CategoryDetailScreen.dart';

class CategoriesScreen extends StatefulWidget {
  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  List<Map<String, dynamic>> _categories = [];
  List<Map<String, dynamic>> _filteredCategories = [];
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadCategories();
    _searchController.addListener(_filterCategories);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadCategories() async {
    // Load data from JSON files
    String medicationsJsonString =
        await DefaultAssetBundle.of(context).loadString('assets/medications.json');
    String skincareJsonString =
        await DefaultAssetBundle.of(context).loadString('assets/skincare.json');
    String babyJsonString =
        await DefaultAssetBundle.of(context).loadString('assets/babyproducts.json');
    String soapsJsonString =
        await DefaultAssetBundle.of(context).loadString('assets/soaps.json');
    String mensProductsJsonString =
        await DefaultAssetBundle.of(context).loadString('assets/mensproducts.json'); // Load Men's Products
    String perfumesJsonString =
        await DefaultAssetBundle.of(context).loadString('assets/perfumeproducts.json'); 
    String healthkitJsonString =
        await DefaultAssetBundle.of(context).loadString('assets/healthkit.json'); 
    String healthdrinksJsonString =
        await DefaultAssetBundle.of(context).loadString('assets/healthydrinks.json'); 

    // Parse JSON strings into lists
    List<dynamic> medicationsData = jsonDecode(medicationsJsonString);
    List<dynamic> skincareData = jsonDecode(skincareJsonString);
    List<dynamic> babyproductsData = jsonDecode(babyJsonString);
    List<dynamic> soapsData = jsonDecode(soapsJsonString);
    List<dynamic> mensProductsData = jsonDecode(mensProductsJsonString); // Parse Men's Products
    List<dynamic> perfumesData=jsonDecode(perfumesJsonString);
    List<dynamic> healthkitData=jsonDecode(healthkitJsonString);
    List<dynamic> healthdrinksData=jsonDecode(healthdrinksJsonString);

    // Update categories list
    setState(() {
      _categories = [
        {'name': 'Medications', 'items': medicationsData},
        {'name': 'Skincare Products', 'items': skincareData},
        {'name': 'Baby Products', 'items': babyproductsData},
        {'name': 'Soaps', 'items': soapsData},
        {'name': 'Mens Products', 'items': mensProductsData},
        {'name': 'Perfumes', 'items': perfumesData},
        {'name': 'Healthkit', 'items': healthkitData},
        {'name': 'Healthdrinks', 'items': healthdrinksData},
      ];
      _filteredCategories = _categories; // Initially show all categories
    });
  }

  void _filterCategories() {
    // Filter categories based on search text
    String query = _searchController.text.toLowerCase();
    setState(() {
      _filteredCategories = _categories
          .where((category) =>
              category['name'].toLowerCase().contains(query))
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
            hintText: 'Search categories...',
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
        itemCount: _filteredCategories.length,
        itemBuilder: (context, index) {
          var category = _filteredCategories[index];
          return GestureDetector(
            onTap: () {
              _navigateToCategoryDetails(category['name'], category['items']);
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
                    width: double.infinity,
                    height: 180,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(_getImageUrl(category['name'])),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  SizedBox(height: 8),
                  Center(
                    child: Text(
                      category['name'],
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _navigateToCategoryDetails(String categoryName, List<dynamic> items) {
    // Navigate to category details screen with selected category items
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            CategoryDetailsScreen(categoryName: categoryName, items: items),
      ),
    );
  }

  String _getImageUrl(String categoryName) {
    // Define image URLs based on category name
    switch (categoryName) {
      case 'Medications':
        return 'assets/Medicationimg.png';
      case 'Skincare Products':
        return 'assets/skincareimg.png';
      case 'Baby Products':
        return 'assets/babyproductimg.png';
      case 'Soaps':
        return 'assets/soapimg.png';
      case 'Mens Products':
        return 'assets/mensproductsimg.png';
      case 'Perfumes':
        return 'assets/perfumesimg.png';
      case 'Healthkit':
        return 'assets/healthkitimg.jpeg';
      case 'Healthdrinks':
        return 'assets/healthdrinksimg.png';
      default:
        return 'assets/default.png'; // Default image URL
    }
  }
}
