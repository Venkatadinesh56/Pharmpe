import 'package:app/main.dart';
import 'package:flutter/material.dart';
import 'cart_item.dart'; // Import CartItem
import 'payment_page.dart';

class ReviewPage extends StatelessWidget {
  final Map<String, String> selectedAddress;
  final List<CartItem> cartItems;

  ReviewPage({required this.selectedAddress, required this.cartItems});

  Widget _buildSummaryRow(String label, double amount) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 16),
        ),
        Text(
          '\$${amount.toStringAsFixed(2)}',
          style: TextStyle(fontSize: 16),
        ),
      ],
    );
  }

  Widget _buildTotalCost() {
    double subtotal = cartItems.fold(0, (sum, item) {
      double itemMrp = double.tryParse(item.mrp) ?? 0.0;
      int itemQuantity = int.tryParse(item.Quantity) ?? 0;
      return sum + (itemMrp * itemQuantity);
    });

    double gst = subtotal * 0.18; // Assuming 18% GST
    double grandTotal = subtotal + gst;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Payment Summary:',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        _buildSummaryRow('Subtotal', subtotal),
        _buildSummaryRow('GST (18%)', gst),
        _buildSummaryRow('Total', grandTotal),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Review Order'),
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
            Text(
              'Selected Address:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Address: ${selectedAddress['Address']}\n'
              'Pin Code: ${selectedAddress['Pin Code']}\n'
              'State: ${selectedAddress['State']}\n'
              'City: ${selectedAddress['City']}\n'
              'Landmark: ${selectedAddress['Landmark']}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              'Cart Items:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: cartItems.length,
                itemBuilder: (context, index) {
                  final cartItem = cartItems[index];
                  return ListTile(
                    leading: Image.network(cartItem.imgurl1),
                    title: Text(cartItem.name),
                    subtitle: Text('MRP: \$${cartItem.mrp}\nQuantity: ${cartItem.Quantity}'),
                  );
                },
              ),
            ),
            _buildTotalCost(),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SelectCardPage(),
                  ),
                );
              },
              child: Text('Confirm Order'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                minimumSize: Size(double.infinity, 50),
                textStyle: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
