import 'dart:convert';
import 'package:app/screens/categories_screen.dart';
import 'package:flutter/material.dart';
import 'package:app/screens/MedicationDetailsScreen.dart';
import 'package:app/screens/cart_screen.dart';
import 'package:app/screens/profile_page.dart';
import 'package:app/screens/search_screen.dart';

class HomeScreen extends StatefulWidget {
  final String email;

  HomeScreen({required this.email});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<dynamic> _medications = [];
  List<dynamic> _skincareProducts = [];
  List<dynamic> _babyproducts = [];
  List<dynamic> _soaps = [];
  List<dynamic> _mensProducts = [];
  List<dynamic> _perfumes = [];
  List<dynamic> _filteredItems = [];
  List<dynamic> _healthkit = [];
  List<dynamic> _healthdrinks = [];
  TextEditingController _searchController = TextEditingController();
  TextEditingController _pincodeController = TextEditingController();
  bool _showMedications = true;
  bool _showskincareProducts = false;
  bool _showbabyproducts = false;
  bool _showsoaps = false;
  bool _showMensProducts = false; 
  bool _showperfumes = false;
  bool _showhealthkit = false;
  bool _showhealthdrinks = false;
  bool _showPincodeInput = true;
  String _cityName = '';

  @override
  void initState() {
    super.initState();
    _loadData();
    _searchController.addListener(_filterItems);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _pincodeController.dispose();
    super.dispose();
  }

  Future<void> _loadData() async {
    String medicationsJsonString =
        await DefaultAssetBundle.of(context).loadString('assets/medications.json');
    String skincareJsonString =
        await DefaultAssetBundle.of(context).loadString('assets/skincare.json');
    String babyJsonString =
        await DefaultAssetBundle.of(context).loadString('assets/babyproducts.json');
    String soapsJsonString =
        await DefaultAssetBundle.of(context).loadString('assets/soaps.json');
    String mensProductsJsonString =
        await DefaultAssetBundle.of(context).loadString('assets/mensproducts.json'); 
    String perfumesJsonString =
        await DefaultAssetBundle.of(context).loadString('assets/perfumeproducts.json'); 
    String healthkitJsonString =
        await DefaultAssetBundle.of(context).loadString('assets/healthkit.json'); 
    String healthdrinksJsonString =
        await DefaultAssetBundle.of(context).loadString('assets/healthydrinks.json'); 
    List<dynamic> medicationsData = jsonDecode(medicationsJsonString);
    List<dynamic> skincareData = jsonDecode(skincareJsonString);
    List<dynamic> babyproductsData = jsonDecode(babyJsonString);
    List<dynamic> soapsData = jsonDecode(soapsJsonString);
    List<dynamic> mensProductsData = jsonDecode(mensProductsJsonString); 
    List<dynamic> perfumesData = jsonDecode(perfumesJsonString);
    List<dynamic> healthkitData = jsonDecode(healthkitJsonString);
    List<dynamic> healthdrinksData = jsonDecode(healthdrinksJsonString);
    setState(() {
      _medications = medicationsData;
      _skincareProducts = skincareData;
      _babyproducts = babyproductsData;
      _soaps = soapsData;
      _perfumes = perfumesData;
      _mensProducts = mensProductsData; 
      _healthdrinks = healthdrinksData;
      _healthkit = healthkitData;
      _filteredItems = _medications; 
    });
  }

  void _filterItems() {
    String query = _searchController.text.toLowerCase();
    setState(() {
      _filteredItems = [];
      if (_showMedications) {
        _filteredItems.addAll(_medications
            .where((item) =>
                (item['Name'] ?? item['name']).toLowerCase().contains(query))
            .toList());
      }
      if (_showskincareProducts) {
        _filteredItems.addAll(_skincareProducts
            .where((item) =>
                (item['Name'] ?? item['name']).toLowerCase().contains(query))
            .toList());
      }
      if (_showbabyproducts) {
        _filteredItems.addAll(_babyproducts
            .where((item) =>
                (item['Name'] ?? item['name']).toLowerCase().contains(query))
            .toList());
      }
      if (_showsoaps) {
        _filteredItems.addAll(_soaps
            .where((item) =>
                (item['Name'] ?? item['name']).toLowerCase().contains(query))
            .toList());
      }
      if (_showMensProducts) {
        _filteredItems.addAll(_mensProducts
            .where((item) =>
                (item['Name'] ?? item['name']).toLowerCase().contains(query))
            .toList());
      }
      if (_showperfumes) {
        _filteredItems.addAll(_perfumes
            .where((item) =>
                (item['Name'] ?? item['name']).toLowerCase().contains(query))
            .toList());
      }
      if (_showhealthdrinks) {
        _filteredItems.addAll(_healthdrinks
            .where((item) =>
                (item['Name'] ?? item['name']).toLowerCase().contains(query))
            .toList());
      }
      if (_showhealthkit) {
        _filteredItems.addAll(_healthkit
            .where((item) =>
                (item['Name'] ?? item['name']).toLowerCase().contains(query))
            .toList());
      }
    });
  }

  Future<void> _fetchCityName(String pincode) async {
    // Mock city names for demonstration purposes
    Map<String, String> pincodeCityMap = {
      
  "500001": "Hyderabad G.P.O., Hyderabad, Telangana",
  "500002": "Ramakrishna Mutt, Hyderabad, Telangana",
  "500003": "Shankermutt, Hyderabad, Telangana",
  "500004": "Osmania University, Hyderabad, Telangana",
  "500005": "Kattedan Ie, Hyderabad, Telangana",
  "500006": "Gandhi Bhawan, Hyderabad, Telangana",
  "500007": "Secunderabad, Hyderabad, Telangana",
  "500008": "Lal Bazar, Hyderabad, Telangana",
  "500009": "Gandhi Nagar, Hyderabad, Telangana",
  "500010": "Gandi Maisamma, Hyderabad, Telangana",
  "500011": "Erragadda, Hyderabad, Telangana",
  "500012": "Hyder Shah Kote, Hyderabad, Telangana",
  "500013": "Kanchanbagh, Hyderabad, Telangana",
  "500014": "Charminar, Hyderabad, Telangana",
  "500015": "Jubilee H.O, Hyderabad, Telangana",
  "500016": "Vidhan Sabha, Hyderabad, Telangana",
  "500017": "Secunderabad, Hyderabad, Telangana",
  "500018": "Amberpet, Hyderabad, Telangana",
  "500019": "Jubilee Hills, Hyderabad, Telangana",
  "500020": "Trimulgherry, Hyderabad, Telangana",
  "500021": "Karwan Sahu, Hyderabad, Telangana",
  "500022": "Himayatnagar, Hyderabad, Telangana",
  "500023": "Malakpet Colony, Hyderabad, Telangana",
  "500024": "Falaknuma, Hyderabad, Telangana",
  "500025": "Ramnagar Gundu, Hyderabad, Telangana",
  "500026": "Sultan Bazar, Hyderabad, Telangana",
  "500027": "Mallapur, Hyderabad, Telangana",
  "500028": "Dilsukhnagar, Hyderabad, Telangana",
  "500029": "I.E.Nacharam, Hyderabad, Telangana",
  "500030": "Sanath Nagar Colony, Hyderabad, Telangana",
  "500031": "G.P.O., Hyderabad, Telangana",
  "500032": "Gulzar Houz, Hyderabad, Telangana",
  "500033": "Santhosh Nagar Colony, Hyderabad, Telangana",
  "500034": "Uppal, Hyderabad, Telangana",
  "500035": "Kachiguda, Hyderabad, Telangana",
  "500036": "Nampally, Hyderabad, Telangana",
  "500037": "Hyderabad Central, Hyderabad, Telangana",
  "500038": "Gowlipura, Hyderabad, Telangana",
  "500039": "Bowenpally, Hyderabad, Telangana",
  "500040": "Somajiguda, Hyderabad, Telangana",
  "500041": "Habshiguda, Hyderabad, Telangana",
  "500042": "Srinagar Colony, Hyderabad, Telangana",
  "500043": "Ramanthapur, Hyderabad, Telangana",
  "500044": "Yakutpura, Hyderabad, Telangana",
  "500045": "Jeedimetla, Hyderabad, Telangana",
  "500046": "Musheerabad H.O, Hyderabad, Telangana",
  "500047": "Boduppal, Hyderabad, Telangana",
  "500048": "Alwal, Hyderabad, Telangana",
  "500049": "Safilguda, Hyderabad, Telangana",
  "500050": "Kukatpally, Hyderabad, Telangana",
  "500051": "Kukatpally Housing Board, Hyderabad, Telangana",
  "500052": "Balnagar, Hyderabad, Telangana",
  "500053": "Old Malakpet, Hyderabad, Telangana",
  "500054": "Sanjeev Reddy Nagar, Hyderabad, Telangana",
  "500055": "Fatehdarwaza, Hyderabad, Telangana",
  "500056": "Haffezpet, Hyderabad, Telangana",
  "500057": "Chikkadpally, Hyderabad, Telangana",
  "500058": "Falaknuma Palace, Hyderabad, Telangana",
  "500059": "Falaknuma Cocks, Hyderabad, Telangana",
  "500060": "Gandi Maisamma X Roads, Hyderabad, Telangana",
  "500061": "Katedan Ie, Hyderabad, Telangana",
  "500062": "Gandhi Bhawan, Hyderabad, Telangana",
  "500063": "Secunderabad, Hyderabad, Telangana",
  "500064": "Lal Bazar, Hyderabad, Telangana",
  "500065": "Gandhi Nagar, Hyderabad, Telangana",
  "500066": "Gandi Maisamma, Hyderabad, Telangana",
  "500067": "Erragadda, Hyderabad, Telangana",
  "500068": "Hyder Shah Kote, Hyderabad, Telangana",
  "500069": "Kanchanbagh, Hyderabad, Telangana",
  "500070": "Charminar, Hyderabad, Telangana",
  "500071": "Jubilee H.O, Hyderabad, Telangana",
  "500072": "Vidhan Sabha, Hyderabad, Telangana",
  "500073": "Secunderabad, Hyderabad, Telangana",
  "500074": "Amberpet, Hyderabad, Telangana",
  "500075": "Jubilee Hills, Hyderabad, Telangana",
  "500076": "Trimulgherry, Hyderabad, Telangana",
  "500077": "Karwan Sahu, Hyderabad, Telangana",
  "500078": "Himayatnagar, Hyderabad, Telangana",
  "500079": "Malakpet Colony, Hyderabad, Telangana",
  "500080": "Falaknuma, Hyderabad, Telangana",
  "500081": "Ramnagar Gundu, Hyderabad, Telangana",
  "500082": "Sultan Bazar, Hyderabad, Telangana",
  "500083": "Mallapur, Hyderabad, Telangana",
  "500084": "Dilsukhnagar, Hyderabad, Telangana",
  "500085": "I.E.Nacharam, Hyderabad, Telangana",
  "500086": "Sanath Nagar Colony, Hyderabad, Telangana",
  "500087": "G.P.O., Hyderabad, Telangana",
  "500088": "Gulzar Houz, Hyderabad, Telangana",
  "500089": "Santhosh Nagar Colony, Hyderabad, Telangana",
  "500090": "Uppal, Hyderabad, Telangana",
  "500091": "Kachiguda, Hyderabad, Telangana",
  "500092": "Nampally, Hyderabad, Telangana",
  "500093": "Hyderabad Central, Hyderabad, Telangana",
  "500094": "Gowlipura, Hyderabad, Telangana",
  "500095": "Bowenpally, Hyderabad, Telangana",
  "500096": "Somajiguda, Hyderabad, Telangana",
  "500097": "Habshiguda, Hyderabad, Telangana",
  "500098": "Srinagar Colony, Hyderabad, Telangana",
  "500099": "Ramanthapur, Hyderabad, Telangana",
  "500100": "Yakutpura, Hyderabad, Telangana",
  "500101": "Jeedimetla, Hyderabad, Telangana",
  "500102": "Musheerabad H.O, Hyderabad, Telangana",
  "500103": "Boduppal, Hyderabad, Telangana",
  "500104": "Alwal, Hyderabad, Telangana",
  "500105": "Safilguda, Hyderabad, Telangana",
  "500106": "Kukatpally, Hyderabad, Telangana",
  "500107": "Kukatpally Housing Board, Hyderabad, Telangana",
  "500108": "Balnagar, Hyderabad, Telangana",
  "500109": "Old Malakpet, Hyderabad, Telangana",
  "500110": "Sanjeev Reddy Nagar, Hyderabad, Telangana",
  "500111": "Fatehdarwaza, Hyderabad, Telangana",
  "500112": "Haffezpet, Hyderabad, Telangana",
  "500113": "Chikkadpally, Hyderabad, Telangana",
  "500114": "Falaknuma Palace, Hyderabad, Telangana",
  "500115": "Falaknuma Cocks, Hyderabad, Telangana",
  "500116": "Gandi Maisamma X Roads, Hyderabad, Telangana",
  "500117": "Katedan Ie, Hyderabad, Telangana",
  "500118": "Gandhi Bhawan, Hyderabad, Telangana",
  "500119": "Secunderabad, Hyderabad, Telangana",
  "500120": "Lal Bazar, Hyderabad, Telangana",
  "500121": "Gandhi Nagar, Hyderabad, Telangana",
  "500122": "Gandi Maisamma, Hyderabad, Telangana",
  "500123": "Erragadda, Hyderabad, Telangana",
  "500124": "Hyder Shah Kote, Hyderabad, Telangana",
  "500125": "Kanchanbagh, Hyderabad, Telangana",
  "500126": "Charminar, Hyderabad, Telangana",
  "500127": "Jubilee H.O, Hyderabad, Telangana",
  "500128": "Vidhan Sabha, Hyderabad, Telangana",
  "500129": "Secunderabad, Hyderabad, Telangana",
  "500130": "Amberpet, Hyderabad, Telangana",
  "500131": "Jubilee Hills, Hyderabad, Telangana",
  "500132": "Trimulgherry, Hyderabad, Telangana",
  "500133": "Karwan Sahu, Hyderabad, Telangana",
  "500134": "Himayatnagar, Hyderabad, Telangana",
  "500135": "Malakpet Colony, Hyderabad, Telangana",
  "500136": "Falaknuma, Hyderabad, Telangana",
  "500137": "Ramnagar Gundu, Hyderabad, Telangana",
  "500138": "Sultan Bazar, Hyderabad, Telangana",
  "500139": "Mallapur, Hyderabad, Telangana",
  "500140": "Dilsukhnagar, Hyderabad, Telangana",
  "500141": "I.E.Nacharam, Hyderabad, Telangana",
  "500142": "Sanath Nagar Colony, Hyderabad, Telangana",
  "500143": "G.P.O., Hyderabad, Telangana",
  "500144": "Gulzar Houz, Hyderabad,Telangana",
  "500001": "Visakhapatnam, Andhra Pradesh",
  "500002": "Vijayawada, Andhra Pradesh",
  "500003": "Guntur, Andhra Pradesh",
  "500004": "Nellore, Andhra Pradesh",
  "500005": "Kurnool, Andhra Pradesh",
  "500006": "Rajahmundry, Andhra Pradesh",
  "500007": "Tirupati, Andhra Pradesh",
  "500008": "Kakinada, Andhra Pradesh",
  "500009": "Anantapur, Andhra Pradesh",
  "500010": "Vizianagaram, Andhra Pradesh",
  "500011": "Eluru, Andhra Pradesh",
  "500012": "Ongole, Andhra Pradesh",
  "500013": "Machilipatnam, Andhra Pradesh",
  "500014": "Adoni, Andhra Pradesh",
  "500015": "Tenali, Andhra Pradesh",
  "500016": "Proddatur, Andhra Pradesh",
  "500017": "Chittoor, Andhra Pradesh",
  "500018": "Hindupur, Andhra Pradesh",
  "500019": "Bhimavaram, Andhra Pradesh",
  "500020": "Madanapalle, Andhra Pradesh",
  "500021": "Srikakulam, Andhra Pradesh",
  "500022": "Nandyal, Andhra Pradesh",
  "500023": "Karimnagar, Andhra Pradesh",
  "500024": "Guntakal, Andhra Pradesh",
  "500025": "Narasaraopet, Andhra Pradesh",
  "500026": "Tadepalligudem, Andhra Pradesh",
  "500027": "Jaggaiahpet, Andhra Pradesh",
  "500028": "Srikalahasti, Andhra Pradesh",
  "500029": "Chilakaluripet, Andhra Pradesh",
  "500030": "Amalapuram, Andhra Pradesh",
  "500031": "Bapatla, Andhra Pradesh",
  "500032": "Palasa Kasibugga, Andhra Pradesh",
  "500033": "Markapur, Andhra Pradesh",
  "500034": "Ponnur, Andhra Pradesh",
  "500035": "Narasapur, Andhra Pradesh",
  "500036": "Repalle, Andhra Pradesh",
  "500037": "Mandapeta, Andhra Pradesh",
  "500038": "Tadepalle, Andhra Pradesh",
  "500039": "Kavali, Andhra Pradesh",
  "500040": "Venkatagiri, Andhra Pradesh",
  "500041": "Palakollu, Andhra Pradesh",
  "500042": "Piduguralla, Andhra Pradesh",
  "500043": "Nuzvid, Andhra Pradesh",
  "500044": "Sattenapalle, Andhra Pradesh",
  "500045": "Gudivada, Andhra Pradesh",
  "500046": "Macherla, Andhra Pradesh",
  "500047": "Tanuku, Andhra Pradesh",
  "500048": "Pithapuram, Andhra Pradesh",
  "500049": "Chirala, Andhra Pradesh",
  "500050": "Samalkot, Andhra Pradesh",
  "500051": "Vijayanagaram, Andhra Pradesh",
  "500052": "Palakonda, Andhra Pradesh",
  "500053": "Pamur, Andhra Pradesh",
  "500054": "Vinukonda, Andhra Pradesh",
  "500055": "Gudur, Andhra Pradesh",
  "500056": "Yemmiganur, Andhra Pradesh",
  "500057": "Tuni, Andhra Pradesh",
  "500058": "Kadapa, Andhra Pradesh",
  "500059": "Chittoor, Andhra Pradesh",
  "500060": "Puttur, Andhra Pradesh",
  "500061": "Rayachoti, Andhra Pradesh",
  "500062": "Sompeta, Andhra Pradesh",
  "500063": "Naidupet, Andhra Pradesh",
  "500064": "Ramachandrapuram, Andhra Pradesh",
  "500065": "Rajampet, Andhra Pradesh",
  "500066": "Jammalamadugu, Andhra Pradesh",
  "500067": "Punganur, Andhra Pradesh",
  "500068": "Ravulapalem, Andhra Pradesh",
  "500069": "Nagari, Andhra Pradesh",
  "500070": "Jaggaiahpet, Andhra Pradesh",
  "500071": "Tadipatri, Andhra Pradesh",
  "500072": "Bobbili, Andhra Pradesh",
  "500073": "Pileru, Andhra Pradesh",
  "500074": "Chinnamandem, Andhra Pradesh",
  "500075": "Bapatla, Andhra Pradesh",
  "500076": "Amudalavalasa, Andhra Pradesh",
  "500077": "Sullurpeta, Andhra Pradesh",
  "500078": "Nellimarla, Andhra Pradesh",
  "500079": "Kadiri, Andhra Pradesh",
  "500080": "Dharmavaram, Andhra Pradesh",
  "500081": "Mandapeta, Andhra Pradesh",
  "500082": "Addanki, Andhra Pradesh",
  "500083": "Nandyal, Andhra Pradesh",
  "500084": "Guntakal, Andhra Pradesh",
  "500085": "Tadepalligudem, Andhra Pradesh",
  "500086": "Jaggaiahpet, Andhra Pradesh",
  "500087": "Srikalahasti, Andhra Pradesh",
  "500088": "Chilakaluripet, Andhra Pradesh",
  "500089": "Amalapuram, Andhra Pradesh",
  "500090": "Bapatla, Andhra Pradesh",
  "500091": "Palasa Kasibugga, Andhra Pradesh",
  "500092": "Markapur, Andhra Pradesh",
  "500093": "Ponnur, Andhra Pradesh",
  "500094": "Narasapur, Andhra Pradesh",
  "500095": "Repalle, Andhra Pradesh",
  "500096": "Mandapeta, Andhra Pradesh",
  "500097": "Tadepalle, Andhra Pradesh",
  "500098": "Kavali, Andhra Pradesh",
  "500099": "Venkatagiri, Andhra Pradesh",
  "500100": "Palakollu, Andhra Pradesh",
  "500101": "Piduguralla, Andhra Pradesh",
  "500102": "Nuzvid, Andhra Pradesh",
  "500103": "Sattenapalle, Andhra Pradesh",
  "500104": "Gudivada, Andhra Pradesh",
  "500105": "Macherla, Andhra Pradesh",
  "500106": "Tanuku, Andhra Pradesh",
  "500107": "Pithapuram, Andhra Pradesh",
  "500108": "Chirala, Andhra Pradesh",
  "500109": "Samalkot, Andhra Pradesh",
  "500110": "Vijayanagaram, Andhra Pradesh",
  "500111": "Palakonda, Andhra Pradesh",
  "500112": "Pamur, Andhra Pradesh",
  "500113": "Vinukonda, Andhra Pradesh",
  "500114": "Gudur, Andhra Pradesh",
  "500115": "Yemmiganur, Andhra Pradesh",
  "500116": "Tuni, Andhra Pradesh",
  "500117": "Kadapa, Andhra Pradesh",
  "500118": "Chittoor, Andhra Pradesh",
  "500119": "Puttur, Andhra Pradesh",
  "500120": "Rayachoti, Andhra Pradesh",
  "500121": "Sompeta, Andhra Pradesh",
  "500122": "Naidupet, Andhra Pradesh",
  "500123": "Ramachandrapuram, Andhra Pradesh",
  "500124": "Rajampet, Andhra Pradesh",
  "500125": "Jammalamadugu, Andhra Pradesh",
  "500126": "Punganur, Andhra Pradesh",
  "500127": "Ravulapalem, Andhra Pradesh",
  "500128": "Nagari, Andhra Pradesh",
  "500129": "Jaggaiahpet, Andhra Pradesh",
  "500130": "Tadipatri, Andhra Pradesh",
  "500131": "Bobbili, Andhra Pradesh",
  "500132": "Pileru, Andhra Pradesh",
  "500133": "Chinnamandem, Andhra Pradesh",
  "500134": "Bapatla, Andhra Pradesh",
  "500135": "Amudalavalasa, Andhra Pradesh",
  "500136": "Sullurpeta, Andhra Pradesh",
  "500137": "Nellimarla, Andhra Pradesh",
  "500138": "Kadiri, Andhra Pradesh",
  "516173": "kadapa,Andhra Pradesh",
  "500139": "Ponnur, Andhra Pradesh",
  "500140": "Pulivendula, Andhra Pradesh",
  "500141": "Puttur, Andhra Pradesh",
  "500142": "Rajahmundry, Andhra Pradesh",
  "500143": "Rayachoti, Andhra Pradesh",
  "500144": "Rayadurg, Andhra Pradesh",
  "500145": "Renigunta, Andhra Pradesh",
  "500146": "Repalle, Andhra Pradesh",
  "500147": "Salur, Andhra Pradesh",
  "500148": "Samalkota, Andhra Pradesh",
  "500149": "Sattenapalle, Andhra Pradesh",
  "500150": "Srikakulam, Andhra Pradesh",
  "500151": "Srisailam, Andhra Pradesh",
  "500152": "Sullurupeta, Andhra Pradesh",
  "500153": "Tadepalligudem, Andhra Pradesh",
  "500154": "Tadpatri, Andhra Pradesh",
  "500155": "Tanuku, Andhra Pradesh",
  "500156": "Tenali, Andhra Pradesh",
  "500157": "Tirupati, Andhra Pradesh",
  "500158": "Tuni, Andhra Pradesh",
  "500159": "Uravakonda, Andhra Pradesh",
  "500160": "Venkatagiri, Andhra Pradesh",
  "500161": "Vijayawada, Andhra Pradesh",
  "500162": "Vinukonda, Andhra Pradesh",
  "500163": "Visakhapatnam, Andhra Pradesh",
  "500164": "Vizianagaram, Andhra Pradesh",
  "500165": "Vuyyuru, Andhra Pradesh",
  "500166": "Yemmiganur, Andhra Pradesh",
  "500167": "Yerraguntla, Andhra Pradesh",
  "517501": "Tirupati North, Andhra Pradesh",
  "517502": "Tirupati, Andhra Pradesh",
  "517503": "Tiruchanur, Andhra Pradesh",
  "517504": "Renigunta, Andhra Pradesh",
  "517505": "Tirumala, Andhra Pradesh",
  "517507": "RC Road, Andhra Pradesh",
  "517520": "Tirupati South, Andhra Pradesh",
  "517561": "Chandragiri, Andhra Pradesh",
  "517582": "Tummalagunta, Andhra Pradesh",
  "517583": "Sri Venkateswara University, Andhra Pradesh"

    };

    await Future.delayed(Duration(seconds: 1)); // Simulate network delay

    setState(() {
      _cityName = pincodeCityMap[pincode] ?? 'Unknown Pincode';
      _showPincodeInput = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pharmpe'),
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                 
                 
                  colors: [Colors.greenAccent, Colors.yellow],
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(0.0),
                child: Column(
                  
                  children: [
                    Text(
                    
                      'Welcome , ${widget.email}',
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    if (_showPincodeInput)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20.0),
                        child: TextField(
                          controller: _pincodeController,
                          decoration: InputDecoration(
                            hintText: 'Enter Pincode...',
                            prefixIcon: Icon(Icons.location_pin),
                            border: OutlineInputBorder(),
                          ),
                          onSubmitted: (value) => _fetchCityName(value),
                        ),
                      ),
                    if (!_showPincodeInput)
                  
                      Row(children: [
                        Icon(Icons.location_pin),
                        Text(
                        'Delivered to:-$_cityName',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                        textAlign: TextAlign.left,
                      ),
                      ],)
                      
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search medications...',
                  prefixIcon: Icon(Icons.search),
                  suffixIcon: _searchController.text.isNotEmpty
                      ? IconButton(
                          icon: Icon(Icons.clear),
                          onPressed: () {
                            setState(() {
                              _searchController.clear();
                              _filterItems();
                            });
                          },
                        )
                      : null,
                  border: OutlineInputBorder(),
                ),
                onChanged: (_) => _filterItems(),
              ),
            ),
            Container(
              width: double.infinity,
              height: _showMedications || _showskincareProducts || _showbabyproducts || _showsoaps || _showMensProducts || _showperfumes || _showhealthdrinks || _showhealthkit ? 200 : 300,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                image: DecorationImage(
                  image: AssetImage('assets/hospital.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 10),
            _buildToggleButtons(),
            SizedBox(height: 10),
            _buildItemGrid(),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildToggleButtons() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _buildToggleButton('Medications', _showMedications, _medications),
          SizedBox(width: 20),
          _buildToggleButton('Skincare Products', _showskincareProducts, _skincareProducts),
          SizedBox(width: 20),
          _buildToggleButton('Baby Products', _showbabyproducts, _babyproducts),
          SizedBox(width: 20),
          _buildToggleButton('Soaps', _showsoaps, _soaps),
          SizedBox(width: 20),
          _buildToggleButton('Mens Products', _showMensProducts, _mensProducts),
          SizedBox(width: 20),
          _buildToggleButton('Perfumes', _showperfumes, _perfumes),
          SizedBox(width: 20),
          _buildToggleButton('Healthkit', _showhealthkit, _healthkit),
          SizedBox(width: 20),
          _buildToggleButton('Healthdrinks', _showhealthdrinks, _healthdrinks),
        ],
      ),
    );
  }

  Widget _buildToggleButton(String title, bool isSelected, List<dynamic> items) {
    String imageUrl = ''; // Default image URL

    switch (title) {
      case 'Medications':
        imageUrl = 'assets/Medicationimg.png';
        break;
      case 'Skincare Products':
        imageUrl = 'assets/skincareimg.png';
        break;
      case 'Baby Products':
        imageUrl = 'assets/babyproductimg.png';
        break;
      case 'Soaps':
        imageUrl = 'assets/soapimg.png';
        break;
      case 'Mens Products':
        imageUrl = 'assets/mensproductsimg.png';
        break;
      case 'Perfumes':
        imageUrl = 'assets/perfumesimg.png';
        break;
      case 'Healthkit':
        imageUrl = 'assets/healthkitimg.jpeg';
        break;
      case 'Healthdrinks':
        imageUrl = 'assets/healthdrinksimg.png';
        break;
      default:
        imageUrl = '';
        break;
    }

    return GestureDetector(
      onTap: () {
        setState(() {
          _showMedications = title == 'Medications';
          _showskincareProducts = title == 'Skincare Products';
          _showbabyproducts = title == 'Baby Products';
          _showsoaps = title == 'Soaps';
          _showMensProducts = title == 'Mens Products';
          _showperfumes = title == 'Perfumes';
          _showhealthkit = title == 'Healthkit';
          _showhealthdrinks = title == 'Healthdrinks';
          _filteredItems = items;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: BoxDecoration(
          color: isSelected ? Colors.greenAccent : Colors.grey,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: isSelected ? 120 : 98,
              width: 100,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(imageUrl),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildItemGrid() {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 0.75,
      ),
      itemCount: _filteredItems.length,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        var item = _filteredItems[index];
        return GestureDetector(
          onTap: () {
            _navigateToItemDetails(item);
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
                  height: _showMedications || _showskincareProducts || _showbabyproducts || _showsoaps || _showMensProducts || _showhealthdrinks || _showhealthkit ? 150 : 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: NetworkImage(item['I1'] ?? item['imgurl1']),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Flexible(
                  child: Text(
                    item['Name'] ?? item['name'],
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
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
    );
  }

  void _navigateToItemDetails(dynamic item) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MedicationDetailsScreen(medication: item)),
    );
  }
}
