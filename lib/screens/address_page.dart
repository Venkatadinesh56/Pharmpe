import 'package:flutter/material.dart';
import 'review_page.dart';
import 'cart_item.dart'; // Import CartItem

class AddressPage extends StatefulWidget {
  final List<CartItem> cartItems;

  AddressPage({required this.cartItems});

  @override
  _AddressPageState createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  TextEditingController _addressController = TextEditingController();
  TextEditingController _pinCodeController = TextEditingController();
  TextEditingController _stateController = TextEditingController();
  TextEditingController _cityController = TextEditingController();
  TextEditingController _landmarkController = TextEditingController();

  List<Map<String, String>> _addresses = [];
  int? _selectedAddressIndex;
  bool _isAddingAddress = false;

  @override
  void dispose() {
    _addressController.dispose();
    _pinCodeController.dispose();
    _stateController.dispose();
    _cityController.dispose();
    _landmarkController.dispose();
    super.dispose();
  }

  void _saveAddress() {
    setState(() {
      final address = {
        'Address': _addressController.text,
        'Pin Code': _pinCodeController.text,
        'State': _stateController.text,
        'City': _cityController.text,
        'Landmark': _landmarkController.text,
      };
      _addresses.add(address);
      _isAddingAddress = false;
      _clearForm();
    });
  }

  void _clearForm() {
    _addressController.clear();
    _pinCodeController.clear();
    _stateController.clear();
    _cityController.clear();
    _landmarkController.clear();
  }

  void _editAddress(int index) {
    setState(() {
      final address = _addresses[index];
      _addressController.text = address['Address']!;
      _pinCodeController.text = address['Pin Code']!;
      _stateController.text = address['State']!;
      _cityController.text = address['City']!;
      _landmarkController.text = address['Landmark']!;
      _addresses.removeAt(index);
      _isAddingAddress = true;
    });
  }

  void _addNewAddress() {
    setState(() {
      _isAddingAddress = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Address'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (_isAddingAddress) ...[
              _buildAddressInput(),
              SizedBox(height: 20),
              _buildTextField('Pin Code', _pinCodeController),
              SizedBox(height: 20),
              _buildTextField('State', _stateController),
              SizedBox(height: 20),
              _buildTextField('City', _cityController),
              SizedBox(height: 20),
              _buildTextField('Landmark', _landmarkController),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveAddress,
                child: Text('Save Address'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  minimumSize: Size(double.infinity, 50),
                  textStyle: TextStyle(fontSize: 18),
                ),
              ),
            ],
            if (!_isAddingAddress) ...[
              Text(
                'Select Address:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: _addresses.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedAddressIndex = index;
                        });
                      },
                      child: Card(
                        color: _selectedAddressIndex == index
                            ? Colors.blue.shade100
                            : Colors.white,
                        child: ListTile(
                          title: Text(_addresses[index]['Address']!),
                          subtitle: Text(
                            'Pin Code: ${_addresses[index]['Pin Code']}\n'
                            'State: ${_addresses[index]['State']}\n'
                            'City: ${_addresses[index]['City']}\n'
                            'Landmark: ${_addresses[index]['Landmark']}',
                          ),
                          leading: Radio<int>(
                            value: index,
                            groupValue: _selectedAddressIndex,
                            onChanged: (int? value) {
                              setState(() {
                                _selectedAddressIndex = value;
                              });
                            },
                          ),
                          trailing: IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () {
                              _editAddress(index);
                            },
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              ElevatedButton(
                onPressed: _addNewAddress,
                child: Text('Add Address'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  minimumSize: Size(double.infinity, 50),
                  textStyle: TextStyle(fontSize: 18),
                ),
              ),
              SizedBox(height: 10,),
              ElevatedButton(
                onPressed: () {
                  if (_selectedAddressIndex != null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ReviewPage(
                          selectedAddress: _addresses[_selectedAddressIndex!],
                          cartItems: widget.cartItems, // Pass cart items to ReviewPage
                        ),
                      ),
                    );
                  }
                },
                child: Text('Proceed to Review'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  minimumSize: Size(double.infinity, 50),
                  textStyle: TextStyle(fontSize: 18),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildAddressInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Address:',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        TextField(
          controller: _addressController,
          decoration: InputDecoration(
            hintText: 'Enter your address',
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          ),
        ),
      ],
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$label:',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: 'Enter $label',
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          ),
        ),
      ],
    );
  }
}
