import 'package:flutter/material.dart';
import 'package:group_coffee/models/cart_model.dart';
import 'package:group_coffee/screens/payment_screen.dart';
import 'package:group_coffee/widgets/home_bottom_bar.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 33, 34, 35),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.sort_rounded,
            color: Colors.white,
          ),
          onPressed: () {},
        ),
        title: const Text(
          'Shopping Cart',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [],
      ),
      body: Consumer<CartModel>(
        builder: (context, cartModel, child) {
          return cartModel.cartItems.isEmpty
              ? Center(
                  child: Text(
                    'Your shopping cart is empty.',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                )
              : ListView.builder(
                  itemCount: cartModel.cartItems.length,
                  itemBuilder: (context, index) {
                    CartItem item = cartModel.cartItems[index];
                    return Container(
                      width: screenWidth * 0.6, // Set the width to 90% of the screen width
                      padding:  EdgeInsets.symmetric(horizontal: screenWidth * 0.05), // Add horizontal padding
                      child: Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        color: const Color.fromARGB(255, 33, 34, 35),
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(16),
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(item.imageUrl),
                          ),
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                item.name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Colors.white,
                                ),
                              ),
                              IconButton(
                                icon: const Icon(
                                  Icons.remove_shopping_cart,
                                  color: Colors.red,
                                  size: 24,
                                ),
                                onPressed: () {
                                  cartModel.removeFromCart(index);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        'Item removed from cart: ${item.name}',
                                        style: const TextStyle(fontSize: 14),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 8),
                              Text(
                                'Quantity: ${item.quantity}',
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.remove),
                                    color: Colors.white,
                                    onPressed: () {
                                      cartModel.decrementQuantity(index);
                                      setState(() {}); // Trigger a rebuild
                                    },
                                  ),
                                  Text(
                                    '${item.quantity}',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                    ),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.add),
                                    color: Colors.white,
                                    onPressed: () {
                                      cartModel.incrementQuantity(index);
                                      setState(() {}); // Trigger a rebuild
                                    },
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Total: \Rs${(item.quantity * item.price).toStringAsFixed(2)}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
        },
      ),
      bottomNavigationBar: HomeBottomBar(favoriteItems: Set()),
      bottomSheet: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: const Color(0xFF212325),
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.4),
              spreadRadius: 1,
              blurRadius: 8,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Total: \Rs${context.read<CartModel>().totalPrice.toStringAsFixed(2)}',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PaymentScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFE57734),
                elevation: 4,
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: const Text(
                'Checkout',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
