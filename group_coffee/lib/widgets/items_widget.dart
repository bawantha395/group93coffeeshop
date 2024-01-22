// import 'package:flutter/material.dart';
// import 'package:group_coffee/screens/single_item_screen.dart';

// class ItemsWidget extends StatefulWidget {
//   final Set<String> favoriteItems;
//   final Function(Set<String>) updateFavorites;
//   final String category;
//   final String searchTerm;

//   ItemsWidget({
//     required this.favoriteItems,
//     required this.updateFavorites,
//     required this.category,
//     required this.searchTerm,
//   });

//   @override
//   _ItemsWidgetState createState() => _ItemsWidgetState();
// }

// class _ItemsWidgetState extends State<ItemsWidget> {
//   List<Map<String, dynamic>> coffeeItems = [
//     {
//       'name': 'Latte',
//       'type': 'hot',
//       'price': 300.0,
//       'description': 'Creamy and rich'
//     },
//     {
//       'name': 'Espresso',
//       'type': 'hot',
//       'price': 250.0,
//       'description': 'Strong and bold'
//     },
//     {
//       'name': 'BlackCoffee',
//       'type': 'hot',
//       'price': 200.0,
//       'description': 'Simple and classic'
//     },
//     {
//       'name': 'ColdCoffee',
//       'type': 'cold',
//       'price': 350.0,
//       'description': 'Refreshing'
//     },
//     {
//       'name': 'IcedLatte',
//       'type': 'cold',
//       'price': 400.0,
//       'description': 'Iced latte'
//     },
//     {
//       'name': 'Cappuccino',
//       'type': 'cappuccino',
//       'price': 320.0,
//       'description': 'Delicious'
//     },
//     {
//       'name': 'Macchiato',
//       'type': 'cappuccino',
//       'price': 280.0,
//       'description': 'Simple'
//     },
//     {
//       'name': 'IcedCappuccino',
//       'type': 'cappuccino',
//       'price': 380.0,
//       'description': 'Delightful'
//     },
//     {
//       'name': 'Americano',
//       'type': 'americano',
//       'price': 220.0,
//       'description': 'Black coffee'
//     },
//     {
//       'name': 'Mocha',
//       'type': 'americano',
//       'price': 420.0,
//       'description': 'Chocolatey'
//     },
//     {
//       'name': 'IcedAmericano',
//       'type': 'americano',
//       'price': 300.0,
//       'description': 'Iced'
//     },
//     {
//       'name': 'IcedCoffee',
//       'type': 'cold',
//       'price': 300.0,
//       'description': 'Perfection'
//     },
//   ];

//   List<Map<String, dynamic>> getFilteredItems() {
//     return coffeeItems
//         .where((item) =>
//             item['type'] == widget.category &&
//             item['name']
//                 .toLowerCase()
//                 .contains(widget.searchTerm.toLowerCase()))
//         .toList();
//   }

//   @override
//   Widget build(BuildContext context) {
//     List<Map<String, dynamic>> filteredItems = getFilteredItems();

//     return SingleChildScrollView(
//       child: GridView.count(
//         physics: NeverScrollableScrollPhysics(),
//         crossAxisCount: 2,
//         shrinkWrap: true,
//         childAspectRatio: (150 / 195),
//         children: [
//           for (int i = 0; i < filteredItems.length; i++)
//             Container(
//               padding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
//               margin: EdgeInsets.symmetric(vertical: 8, horizontal: 13),
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(20),
//                 color: Color(0xFF212325),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black.withOpacity(0.4),
//                     spreadRadius: 1,
//                     blurRadius: 8,
//                   ),
//                 ],
//               ),
//               child: Column(
//                 children: [
//                   InkWell(
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) =>
//                               SingleItemScreen(imageUrl: filteredItems[i]['name']!),
//                         ),
//                       );
//                     },
//                     child: Container(
//                       margin: EdgeInsets.all(10),
//                       child: Image.asset(
//                         "images/${filteredItems[i]['name']}.png",
//                         width: 120,
//                         height: 70,
//                         fit: BoxFit.contain,
//                       ),
//                     ),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.only(
//                       bottom: 10,
//                     ),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           filteredItems[i]['name']!,
//                           style: TextStyle(
//                             fontSize: 18,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.white,
//                           ),
//                           overflow: TextOverflow.ellipsis,
//                         ),
//                         SizedBox(
//                           height: 5,
//                         ),
//                         Text(
//                           filteredItems[i]['description']!,
//                           style: TextStyle(
//                             fontSize: 16,
//                             color: Colors.white60,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.symmetric(vertical: 5),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           "\Rs${filteredItems[i]['price']}",
//                           style: TextStyle(
//                             fontSize: 18,
//                             fontWeight: FontWeight.w500,
//                             color: Colors.white,
//                           ),
//                         ),
//                         Container(
//                           padding: EdgeInsets.all(5),
//                           decoration: BoxDecoration(
//                             color: Color(0xFFE57734),
//                             borderRadius: BorderRadius.circular(20),
//                           ),
//                           child: buildFavoriteIconButton(filteredItems[i]['name']!),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//         ],
//       ),
//     );
//   }

//   IconButton buildFavoriteIconButton(String item) {
//     return IconButton(
//       icon: Icon(
//         widget.favoriteItems.contains(item)
//             ? Icons.favorite
//             : Icons.favorite_outline,
//         size: 20,
//         color: Colors.white,
//       ),
//       onPressed: () {
//         setState(() {
//           if (widget.favoriteItems.contains(item)) {
//             widget.favoriteItems.remove(item);
//           } else {
//             widget.favoriteItems.add(item);
//           }
//         });
//         widget.updateFavorites(widget.favoriteItems);
//       },
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:group_coffee/screens/single_item_screen.dart';

class ItemsWidget extends StatefulWidget {
  final Set<String> favoriteItems;
  final Function(Set<String>) updateFavorites;
  final String category;
  final String searchTerm;

  ItemsWidget({
    required this.favoriteItems,
    required this.updateFavorites,
    required this.category,
    required this.searchTerm,
  });

  @override
  _ItemsWidgetState createState() => _ItemsWidgetState();
}

class _ItemsWidgetState extends State<ItemsWidget> {
  List<Map<String, dynamic>> coffeeItems = [
  {
    'name': 'Latte',
    'type': 'hot',
    'price': 300.0,
    'description': 'Creamy and rich',
  },
  {
    'name': 'Espresso',
    'type': 'hot',
    'price': 250.0,
    'description': 'Strong and bold',
  },
  {
    'name': 'BlackCoffee',
    'type': 'hot',
    'price': 200.0,
    'description': 'Simple and classic',
  },
  {
    'name': 'ColdCoffee',
    'type': 'cold',
    'price': 350.0,
    'description': 'Refreshing',
  },
  {
    'name': 'IcedLatte',
    'type': 'cold',
    'price': 400.0,
    'description': 'Iced latte',
  },
  {
    'name': 'Cappuccino',
    'type': 'cappuccino',
    'price': 320.0,
    'description': 'Delicious',
  },
  {
    'name': 'Macchiato',
    'type': 'cappuccino',
    'price': 280.0,
    'description': 'Simple',
  },
  {
    'name': 'IcedCappuccino',
    'type': 'cappuccino',
    'price': 380.0,
    'description': 'Delightful',
  },
  {
    'name': 'Americano',
    'type': 'americano',
    'price': 220.0,
    'description': 'Black coffee',
  },
  {
    'name': 'Mocha',
    'type': 'americano',
    'price': 420.0,
    'description': 'Chocolatey',
  },
  {
    'name': 'IcedAmericano',
    'type': 'americano',
    'price': 300.0,
    'description': 'Iced',
  },
  {
    'name': 'IcedCoffee',
    'type': 'cold',
    'price': 300.0,
    'description': 'Perfection',
  },
  // Add the rest of the coffee items here
];

  List<Map<String, dynamic>> getFilteredItems() {
    return coffeeItems
        .where((item) =>
            item['type'] == widget.category &&
            item['name']
                .toLowerCase()
                .contains(widget.searchTerm.toLowerCase()))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filteredItems = getFilteredItems();

    return SingleChildScrollView(
      child: GridView.count(
        physics: NeverScrollableScrollPhysics(),
        crossAxisCount: 2,
        shrinkWrap: true,
        childAspectRatio: (150 / 195),
        children: [
          for (int i = 0; i < filteredItems.length; i++)
            Container(
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
              margin: EdgeInsets.symmetric(vertical: 8, horizontal: 13),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Color(0xFF212325),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.4),
                    spreadRadius: 1,
                    blurRadius: 8,
                  ),
                ],
              ),
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              SingleItemScreen(imageUrl: filteredItems[i]['name']!),
                        ),
                      );
                    },
                    child: Container(
                      margin: EdgeInsets.all(10),
                      child: Image.asset(
                        "images/${filteredItems[i]['name']}.png",
                        width: 120,
                        height: 70,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      bottom: 10,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          filteredItems[i]['name']!,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          filteredItems[i]['description']!,
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
                          "\Rs${filteredItems[i]['price']}",
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
                          child: buildFavoriteIconButton(filteredItems[i]['name']!),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  IconButton buildFavoriteIconButton(String item) {
    return IconButton(
      icon: Icon(
        widget.favoriteItems.contains(item)
            ? Icons.favorite
            : Icons.favorite_outline,
        size: 20,
        color: Colors.white,
      ),
      onPressed: () {
        setState(() {
          if (widget.favoriteItems.contains(item)) {
            widget.favoriteItems.remove(item);
          } else {
            widget.favoriteItems.add(item);
          }
        });
        widget.updateFavorites(widget.favoriteItems);
      },
    );
  }
}


