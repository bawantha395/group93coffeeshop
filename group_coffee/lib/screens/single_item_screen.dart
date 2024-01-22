import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:group_coffee/models/cart_model.dart';
import 'package:provider/provider.dart';

class SingleItemScreen extends StatefulWidget {
  final String imageUrl; // Change 'img' to 'imageUrl'

  SingleItemScreen({required this.imageUrl});

  @override
  _SingleItemScreenState createState() => _SingleItemScreenState();
}

class _SingleItemScreenState extends State<SingleItemScreen> {
  int quantity = 1;
  late double itemPrice;
  late String itemVolume;
  late String itemDescription;

  List<Map<String, dynamic>> coffeeItems = [
  {
    'name': 'Latte',
    'type': 'hot',
    'price': 300.0,
    'volume': '250 ml',
    'description':
        'A classic coffee drink with espresso and steamed milk. The latte, a quintessential hot coffee beverage, seamlessly blends robust espresso with velvety steamed milk. This classic concoction offers a harmonious balance, where the intense kick of espresso dances gracefully with the creamy embrace of meticulously steamed milk. A sip of this timeless delight promises a symphony of flavors, making the latte an enduring favorite among coffee enthusiasts seeking a refined and satisfying experience.',
  },
  {
    'name': 'Espresso',
    'type': 'hot',
    'price': 250.0,
    'volume': '30 ml',
    'description': 'Strong and concentrated coffee shot.',
  },
  {
    'name': 'BlackCoffee',
    'type': 'hot',
    'price': 200.0,
    'volume': '300 ml',
    'description': 'Pure black coffee without milk or sugar.',
  },
  {
    'name': 'ColdCoffee',
    'type': 'cold',
    'price': 350.0,
    'volume': '350 ml',
    'description': 'Chilled coffee perfect for a hot day.',
  },
  {
    'name': 'IcedLatte',
    'type': 'cold',
    'price': 400.0,
    'volume': '300 ml',
    'description': 'Iced version of the classic Latte.',
  },
  {
    'name': 'Cappuccino',
    'type': 'cappuccino',
    'price': 320.0,
    'volume': '200 ml',
    'description': 'Espresso with equal parts of steamed milk and foam.',
  },
  {
    'name': 'Macchiato',
    'type': 'cappuccino',
    'price': 280.0,
    'volume': '50 ml',
    'description': 'Espresso with a dash of frothy milk.',
  },
  {
    'name': 'IcedCappuccino',
    'type': 'cappuccino',
    'price': 380.0,
    'volume': '300 ml',
    'description': 'Chilled version of the classic Cappuccino.',
  },
  {
    'name': 'Americano',
    'type': 'americano',
    'price': 220.0,
    'volume': '350 ml',
    'description': 'Diluted espresso with hot water.',
  },
  {
    'name': 'Mocha',
    'type': 'americano',
    'price': 420.0,
    'volume': '400 ml',
    'description': 'Espresso with chocolate and steamed milk.',
  },
  {
    'name': 'IcedAmericano',
    'type': 'americano',
    'price': 300.0,
    'volume': '350 ml',
    'description': 'Chilled version of the classic Americano.',
  },
  {
    'name': 'IcedCoffee',
    'type': 'cold',
    'price': 300.0,
    'volume': '350 ml',
    'description': 'Refreshing iced coffee.',
  },
  // Add the rest of the coffee items here
];


  @override
  @override
  void initState() {
    super.initState();
    var selectedItem =
        coffeeItems.firstWhere((item) => item['name'] == widget.imageUrl);
    itemPrice = selectedItem['price'];
    itemVolume = selectedItem['volume'];
    itemDescription = selectedItem['description'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(top: 30, bottom: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 25),
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.arrow_back_ios_new,
                      color: Colors.white.withOpacity(0.5),
                    ),
                  ),
                ),
                SizedBox(height: 50),
                Center(
                  child: Image.asset(
                    "images/${widget.imageUrl}.png",
                    width: MediaQuery.of(context).size.width / 1.2,
                  ),
                ),
                SizedBox(height: 50),
                Padding(
                  padding: EdgeInsets.only(left: 25, right: 40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "BEST COFFEE",
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.4),
                          letterSpacing: 3,
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        widget.imageUrl,
                        style: TextStyle(
                          fontSize: 30,
                          letterSpacing: 1,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 25),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 15),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.white,
                                ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Row(
                                children: [
                                  IconButton(
                                    icon: Icon(
                                      CupertinoIcons.minus,
                                      size: 18,
                                      color: Colors.white,
                                    ),
                                    onPressed: () {
                                      if (quantity > 1) {
                                        setState(() {
                                          quantity--;
                                        });
                                      }
                                    },
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    "$quantity",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  IconButton(
                                    icon: Icon(
                                      CupertinoIcons.plus,
                                      size: 18,
                                      color: Colors.white,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        quantity++;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              "\Rs ${(itemPrice * quantity).toStringAsFixed(2)}",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        itemDescription,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.white.withOpacity(0.4),
                        ),
                      ),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          Text(
                            "Volume: ",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(width: 10),
                          Text(
                            itemVolume,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 30),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                CartItem newItem = CartItem(
                                  name: widget.imageUrl,
                                  quantity: quantity,
                                  price: itemPrice, 
                                  imageUrl: "images/${widget.imageUrl}.png",
                                  
                                );
                                Provider.of<CartModel>(context, listen: false)
                                    .addToCart(newItem);

                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'Item added to cart: ${widget.imageUrl}',
                                    ),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    Color.fromARGB(255, 223, 117, 31),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18),
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  vertical: 20,
                                  horizontal: 50,
                                ),
                                child: Text(
                                  "Add to Cart",
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

