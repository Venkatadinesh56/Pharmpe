import 'package:app/MainScreen.dart';
import 'package:app/screens/cartManager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'share_screen.dart'; // Import the ShareScreen
import 'package:url_launcher/url_launcher.dart';
import 'cart_screen.dart'; // Import the CartScreen
import 'cart_item.dart';

class MedicationDetailsScreen extends StatefulWidget {
  final dynamic medication;

  MedicationDetailsScreen({required this.medication});

  @override
  _MedicationDetailsScreenState createState() =>
      _MedicationDetailsScreenState();
}

class _MedicationDetailsScreenState extends State<MedicationDetailsScreen> {
  late String topImageUrl;
  double userRating = 0.0; // Initial user rating
  TextEditingController _commentController = TextEditingController();

  List<Review> _reviews = [];
  List<dynamic> _cartItems = []; // List to store cart items

  @override
  void initState() {
    super.initState();
    topImageUrl = widget.medication['imgurl1']; // Initialize with imgurl1
  }

  void changeTopImage(String newImageUrl) {
    setState(() {
      topImageUrl = newImageUrl;
    });
  }

  void rateMedication(double rating) {
    setState(() {
      userRating = rating;
    });
    // Logic to save rating to backend or local storage
  }

  void addToCart() {
    // Create a CartItem object from medication details
    CartItem cartItem = CartItem(
      name: widget.medication['name'],
      imgurl1: widget.medication['imgurl1'],
      Quantity: widget.medication['Quantity'], // Ensure this matches your data structure
      mrp: widget.medication['MRP'],
    );

    setState(() {
      cartManager.addToCart(cartItem); // Add cartItem to cartManager
    });

    ScaffoldMessenger.of(context).showSnackBar(
  SnackBar(
    content: Text(
      '${widget.medication['name']} added to cart',
      textAlign: TextAlign.center, // Align text to center
    ),
    duration: Duration(seconds: 2),
  ),
);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Medication Details'),
        actions: [
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ShareScreen(
                    productName: widget.medication['name'],
                    productImageUrl: topImageUrl,
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      changeTopImage(widget.medication['imgurl2']);
                    },
                    child: Container(
                      width: 250,
                      height: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        image: DecorationImage(
                          image: NetworkImage(topImageUrl),
                          fit: BoxFit.cover,
                        ),
                      ),
                      margin: EdgeInsets.only(bottom: 10),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          changeTopImage(widget.medication['imgurl2']);
                        },
                        child: Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            image: DecorationImage(
                              image: NetworkImage(widget.medication['imgurl2']),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 5),
                      GestureDetector(
                        onTap: () {
                          changeTopImage(widget.medication['imgurl1']);
                        },
                        child: Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            image: DecorationImage(
                              image: NetworkImage(widget.medication['imgurl1']),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Text(
              widget.medication['name'],
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            SizedBox(height: 10),
            Text(
              '${widget.medication['Quantity']} - \$${widget.medication['MRP']}',
              style: TextStyle(fontSize: 18, color: Colors.blue),
            ),
            SizedBox(height: 20),
            Text(
              'Manufacturer: ${widget.medication['manufacturer']}',
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
            SizedBox(height: 20),
            Text(
              'User Ratings:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            _buildRatingStars(),
            SizedBox(height: 20),
            Text(
              'Reviews:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            _buildReviews(),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _showReviewDialog();
              },
              child: Text('Add Your Review'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: addToCart,
              child: Text('Add to Cart'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CartScreen(),
            ),
          );
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(Icons.shopping_cart),
      ),
    );
  }

  Widget _buildRatingStars() {
    return Column(
      children: [
        RatingBar.builder(
          initialRating: userRating,
          minRating: 0,
          direction: Axis.horizontal,
          allowHalfRating: true,
          itemCount: 5,
          itemSize: 30,
          itemBuilder: (context, _) => Icon(
            Icons.star,
            color: Colors.yellow,
          ),
          onRatingUpdate: (rating) {
            setState(() {
              userRating = rating;
            });
          },
        ),
        SizedBox(height: 10),
        Text(
          'Current Rating: $userRating',
          style: TextStyle(fontSize: 16),
        ),
      ],
    );
  }

  Widget _buildReviews() {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: _reviews.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(
            _reviews[index].comment,
            style: TextStyle(fontSize: 16),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  RatingBarIndicator(
                    rating: _reviews[index].rating,
                    itemBuilder: (context, index) => Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    itemCount: 5,
                    itemSize: 20.0,
                    unratedColor: Colors.grey[300],
                    direction: Axis.horizontal,
                  ),
                  SizedBox(width: 5),
                  Text(
                    '${_reviews[index].rating}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(width: 10),
                  Text(
                    'by ${_reviews[index].reviewerName}',
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
      
    );
  }

  void _showReviewDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add Your Review'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              RatingBar.builder(
                initialRating: userRating,
                minRating: 0,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemSize: 30,
                itemBuilder: (context, _) => Icon(
                  Icons.star,
                  color: Colors.yellow,
                ),
                onRatingUpdate: (rating) {
                  setState(() {
                    userRating = rating;
                  });
                },
              ),
              SizedBox(height: 10),
              TextField(
                controller: _commentController,
                decoration: InputDecoration(
                  hintText: 'Enter your review',
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                _postReview();
                Navigator.of(context).pop();
              },
              child: Text('Post'),
            ),
          ],
        );
      },
    );
  }

  void _postReview() {
    String comment = _commentController.text.trim();
    if (comment.isNotEmpty && userRating > 0) {
      Review newReview = Review(
        reviewerName: 'You',
        rating: userRating,
        comment: comment,
      );
      setState(() {
        _reviews.add(newReview);
        _commentController.clear();
        userRating = 0;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Your review has been posted'),
          duration: Duration(seconds: 2),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please provide a rating and comment'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }
}

class Review {
  final String reviewerName;
  final double rating;
  final String comment;

  Review({
    required this.reviewerName,
    required this.rating,
    required this.comment,
  });
}