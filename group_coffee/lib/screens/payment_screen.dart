import 'package:flutter/material.dart';

class PaymentScreen extends StatefulWidget {
  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _cardNumberController = TextEditingController();
  TextEditingController _expiryDateController = TextEditingController();
  TextEditingController _cvvController = TextEditingController();

  bool _isProcessing = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 33, 34, 35),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 33, 34, 35),
        title: Text('Secure Payment', style: TextStyle(color: Colors.white)),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'images/card_image.png',
                  width: 350,
                  height: 200,
                  fit: BoxFit.contain,
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _cardNumberController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Card Number',
                    labelStyle: TextStyle(color: Colors.white),
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.white10,
                    prefixIcon: Icon(Icons.credit_card, color: Colors.white),
                  ),
                  style: TextStyle(color: Colors.white),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter card number (xxxxxxxxxxxx)';
                    }
                    if (!isValidCreditCard(value)) {
                      return 'Please enter a valid debit card number (xxxxxxxxxxxx)';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _expiryDateController,
                        keyboardType: TextInputType.datetime,
                        decoration: InputDecoration(
                          labelText: 'Expiry Date',
                          labelStyle: TextStyle(color: Colors.white),
                          border: OutlineInputBorder(),
                          filled: true,
                          fillColor: Colors.white10,
                        ),
                        style: TextStyle(color: Colors.white),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter expiry date (MM/YY)';
                          }
                          if (!isValidExpiryDate(value)) {
                            return 'Please enter a valid expiry date (MM/YY)';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: TextFormField(
                        controller: _cvvController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'CVV',
                          labelStyle: TextStyle(color: Colors.white),
                          border: OutlineInputBorder(),
                          filled: true,
                          fillColor: Colors.white10,
                        ),
                        style: TextStyle(color: Colors.white),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter CVV (xxx)';
                          }
                          if (!isValidCVV(value)) {
                            return 'Please enter a valid CVV (xxx)';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 40),
                ElevatedButton(
                  onPressed: _isProcessing ? null : _processPayment,
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xFFE57734),
                    onPrimary: Colors.white,
                    padding: EdgeInsets.symmetric(
                        vertical: 20), // Adjust the vertical padding
                    minimumSize: Size(
                        double.infinity, 50), // Adjust the height of the button
                  ),
                  child: _isProcessing
                      ? CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white))
                      : Text('Pay Now', style: TextStyle(fontSize: 18)),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: _navigateToHome,
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xFFE57734),
                    onPrimary: Colors.white,
                    padding: EdgeInsets.symmetric(
                        vertical: 20), // Adjust the vertical padding
                    minimumSize: Size(
                        double.infinity, 50), // Adjust the height of the button
                  ),
                  child: Text('Go to Home', style: TextStyle(fontSize: 18)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _processPayment() async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        _isProcessing = true;
      });

      // Simulate a payment processing delay
      await Future.delayed(Duration(seconds: 2));

      // Simulate a successful payment (replace with actual payment processing logic)
      bool paymentSuccessful = true;

      setState(() {
        _isProcessing = false;
      });

      if (paymentSuccessful) {
        _showSuccessDialog();
      } 
    }
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Payment Successful'),
        content: Text('Thank you for your payment!'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              // Add any additional logic after a successful payment
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showErrorDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Payment Failed'),
        content: Text('Oops! Something went wrong. Please try again.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  bool isValidCreditCard(String value) {
    // Simple Luhn algorithm check for credit card validation
    if (value.length < 12 || value.length > 19) {
      return false;
    }

    List<int> digits =
        value.split('').map((String digit) => int.parse(digit)).toList();
    for (int i = digits.length - 2; i >= 0; i -= 2) {
      int doubleDigit = digits[i] * 2;
      digits[i] = doubleDigit > 9 ? doubleDigit - 9 : doubleDigit;
    }

    int sum = digits.reduce((int a, int b) => a + b);
    return sum % 10 == 0;
  }

  bool isValidExpiryDate(String value) {
    // Basic validation for expiry date (MM/YY format)
    RegExp expiryDateRegex = RegExp(r'^((0[1-9])|(1[0-2]))\/(\d{2})$');
    return expiryDateRegex.hasMatch(value);
  }

  bool isValidCVV(String value) {
    // Basic validation for CVV (3 digits)
    RegExp cvvRegex = RegExp(r'^\d{3}$');
    return cvvRegex.hasMatch(value);
  }

  void _navigateToHome() {
    // Navigator.popUntil(context, ModalRoute.withName('/home')); // Pop until the home route
     Navigator.pushReplacementNamed(context, '/home');
  }
}
