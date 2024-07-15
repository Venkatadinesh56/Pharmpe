import 'package:app/screens/address_page.dart';
import 'package:flutter/material.dart';
import 'cartManager.dart'; // Import cartManager
import 'package:app/screens/cart_item.dart'; // Import CartItem

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
        backgroundColor: Colors.green,
      ),
      body: cartManager.cartItems.isEmpty ? _buildEmptyCart() : _buildCartContent(),
    );
  }

  Widget _buildEmptyCart() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.shopping_cart,
            size: 80,
            color: Colors.grey,
          ),
          SizedBox(height: 20),
          Text(
            'Your cart is empty.',
            style: TextStyle(fontSize: 20),
          ),
        ],
      ),
    );
  }

  Widget _buildCartContent() {
    return Column(
      children: <Widget>[
        Expanded(child: _buildCartList()),
        _buildTotalCost(),
        _buildProceedButton(),
      ],
    );
  }

  Widget _buildCartList() {
    return ListView.builder(
      itemCount: cartManager.cartItems.length,
      itemBuilder: (context, index) {
        CartItem cartItem = cartManager.cartItems[index];
        return ListTile(
          leading: Image.network(cartItem.imgurl1),
          title: Row(
            children: <Widget>[
              Expanded(
                child: Text(cartItem.name),
              ),
              SizedBox(width: 10), // Adjust as needed
              _buildQuantityInput(index), // Quantity input box
            ],
          ),
          subtitle: Text('MRP: \$${cartItem.mrp}'),
          trailing: IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              setState(() {
                cartManager.removeCartItem(index);
              });
            },
          ),
        );
      },
    );
  }

  Widget _buildQuantityInput(int index) {
    return SizedBox(
      width: 60,
      child: TextField(
        decoration: InputDecoration(
          labelText: 'Qty',
          border: OutlineInputBorder(),
          contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
        ),
        keyboardType: TextInputType.number,
        onChanged: (value) {
          // Update quantity in cartManager or handle as per your logic
        },
      ),
    );
  }

  Widget _buildTotalCost() {
    double totalCost = cartManager.cartItems.fold(0, (sum, item) {
      double itemMrp = double.tryParse(item.mrp) ?? 0.0;
      int itemQuantity = int.tryParse(item.Quantity) ?? 0;
      return sum + (itemMrp * itemQuantity);
    });

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            'Total Cost:',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text(
            '\$${totalCost.toStringAsFixed(2)}',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildProceedButton() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddressPage(cartItems: cartManager.cartItems),
            ),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green,
          padding: EdgeInsets.symmetric(vertical: 16),
          textStyle: TextStyle(fontSize: 18),
        ),
        child: Center(child: Text('Proceed')),
      ),
    );
  }
}
