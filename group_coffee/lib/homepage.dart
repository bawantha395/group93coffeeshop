import 'package:flutter/material.dart';
import 'package:group_coffee/widgets/items_widget.dart';
import 'package:group_coffee/widgets/home_bottom_bar.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  Set<String> favoriteItems = {}; // Initial empty set
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    _tabController = TabController(length: 4, vsync: this, initialIndex: 0);
    _tabController.addListener(_handleTabSelection);
    super.initState();
  }

  _handleTabSelection() {
    if (_tabController.indexIsChanging) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    searchController.dispose();
    super.dispose();
  }

  void updateFavorites(Set<String> newFavorites) {
    setState(() {
      favoriteItems = newFavorites;
    });
  }
  

  void filterItems(String query) {
    setState(() {
      searchController.text = query;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 15),
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {},
                        child: Icon(
                          Icons.sort_rounded,
                          color: Colors.white.withOpacity(0.5),
                          size: 35,
                        ),
                      ),
                      // InkWell(
                      //   onTap: () {},
                      //   child: Icon(
                      //     Icons.notifications,
                      //     color: Colors.white.withOpacity(0.5),
                      //     size: 35,
                      //   ),
                      // ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Text(
                    "It's a Great Day for Coffee",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                  width: MediaQuery.of(context).size.width,
                  height: 60,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 50, 54, 56),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextFormField(
                    controller: searchController,
                    onChanged: filterItems,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Find your coffee",
                      hintStyle: TextStyle(
                        color: Colors.white.withOpacity(0.5),
                      ),
                      prefixIcon: Icon(
                        Icons.search,
                        size: 30,
                        color: Colors.white.withOpacity(0.5),
                      ),
                    ),
                  ),
                ),
                TabBar(
                  controller: _tabController,
                  labelColor: Color(0xFFE57734),
                  unselectedLabelColor: Colors.white.withOpacity(0.5),
                  isScrollable: true,
                  indicator: const UnderlineTabIndicator(
                    borderSide: BorderSide(
                      width: 3,
                      color: Color(0xFFE57734),
                    ),
                    insets: EdgeInsets.symmetric(horizontal: 16),
                  ),
                  labelStyle:
                      const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  labelPadding: const EdgeInsets.symmetric(horizontal: 20),
                  tabs: const [
                    Tab(text: "Hot Coffee"),
                    Tab(text: "Cold Coffee"),
                    Tab(text: "Cappuccino"),
                    Tab(text: "Americano"),
                  ],
                ),
                SizedBox(height: 10),
                Center(
                  child: ItemsWidget(
                    favoriteItems: favoriteItems,
                    updateFavorites: updateFavorites,
                    category: _tabController.index == 0
                        ? 'hot'
                        : _tabController.index == 1
                            ? 'cold'
                            : _tabController.index == 2
                                ? 'cappuccino'
                                : 'americano',
                    searchTerm: searchController.text,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: HomeBottomBar(favoriteItems: favoriteItems),
    );
  }
}
