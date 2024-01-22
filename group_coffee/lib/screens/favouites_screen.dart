import 'package:flutter/material.dart';

import 'package:group_coffee/widgets/home_bottom_bar.dart';

class FavouritesScreen extends StatefulWidget {
  final Set<String> favoriteItems;

  FavouritesScreen({required this.favoriteItems});

  @override
  _FavouritesScreenState createState() => _FavouritesScreenState();
}

class _FavouritesScreenState extends State<FavouritesScreen> {
  // Define coffeeItems with unique prices and descriptions
  List<Map<String, dynamic>> coffeeItems = [
    {'name': 'Latte', 'type': 'hot', 'price': 300.0, 'description': 'Creamy and rich'},
    {'name': 'Espresso', 'type': 'hot', 'price': 250.0, 'description': 'Strong and bold'},
    {'name': 'BlackCoffee', 'type': 'hot', 'price': 200.0, 'description': 'Simple and classic'},
    {'name': 'ColdCoffee', 'type': 'cold', 'price': 350.0, 'description': 'Iced and refreshing'},
    {'name': 'IcedLatte', 'type': 'cold', 'price': 400.0, 'description': 'Iced latte with a twist'},
    {'name': 'Cappuccino', 'type': 'cappuccino', 'price': 320.0, 'description': 'Foamy and delicious'},
    {'name': 'Macchiato', 'type': 'cappuccino', 'price': 280.0, 'description': 'Simple and satisfying'},
    {'name': 'IcedCappuccino', 'type': 'cappuccino', 'price': 380.0, 'description': 'Iced and delightful'},
    {'name': 'Americano', 'type': 'americano', 'price': 220.0, 'description': 'Classic black coffee'},
    {'name': 'Mocha', 'type': 'americano', 'price': 420.0, 'description': 'Chocolatey and indulgent'},
    {'name': 'IcedAmericano', 'type': 'americano', 'price': 300.0, 'description': 'Iced Americano'},
    {'name': 'IcedCoffee', 'type': 'cold', 'price': 300.0, 'description': 'Chilled coffee perfection'},
    
  ];

  @override
  Widget build(BuildContext context) {
    List<String> favoriteItemsList = widget.favoriteItems.toList();

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 33, 34, 35),
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.sort_rounded,
            color: Colors.white,
          ),
          onPressed: () {
            
          },
        ),
        title: Text(
          'Favourites',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        // actions: [
        //   IconButton(
        //     icon: Icon(
        //       Icons.notifications,
        //       color: Colors.white,
        //     ),
        //     onPressed: () {
              
        //     },
        //   ),
        // ],
      ),
      body: favoriteItemsList.isEmpty
          ? Center(
              child: Text(
                'No favourite coffee items.',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            )
          : GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: (150 / 200),
              ),
              itemCount: favoriteItemsList.length,
              itemBuilder: (context, index) {
                String item = favoriteItemsList[index];
                var coffeeItem = coffeeItems.firstWhere((element) => element['name'] == item);

                return Container(
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 13),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Color(0xFF212325),
                    boxShadow: [
                      BoxShadow(
                        color: const Color.fromARGB(255, 33, 33, 33).withOpacity(0.4),
                        spreadRadius: 1,
                        blurRadius: 8,
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        margin: EdgeInsets.all(10),
                        child: Image.asset(
                          "images/$item.png",
                          width: 120,
                          height: 70,
                          fit: BoxFit.contain,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          bottom: 8,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              coffeeItem['description'],
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white60,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "\Rs${coffeeItem['price']}",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                color: Color(0xFFE57734),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: IconButton(
                                icon: Icon(
                                  Icons.favorite,
                                  size: 20,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  setState(() {
                                    widget.favoriteItems.remove(item);
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
      bottomNavigationBar: HomeBottomBar(favoriteItems: widget.favoriteItems),
    );
  }
}
