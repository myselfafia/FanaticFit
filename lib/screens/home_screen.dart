import 'dart:async';
import 'package:flutter/material.dart';
import 'search_screen.dart';
import 'cart_screen.dart';
import 'favorite_screen.dart';
import 'account_screen.dart';
import 'sub_category_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  int _selectedIndex = 0;

  Widget _buildCurrentPage() {
    switch (_selectedIndex) {
      case 0:
        return const HomeContent();
      case 1:
        return const SearchScreen();
      case 2:
        return const CartScreen();
      case 3:
        return const FavoriteScreen();
      default:
        return const HomeContent();
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Column(
        children: [

          Container(
            padding: const EdgeInsets.symmetric(vertical: 15),
            color: Colors.grey.shade200,
            child: Center(
              child: Image.asset(
                "assets/images/fanaticfit.png",
                height: 70,
              ),
            ),
          ),

          Expanded(
            child: _buildCurrentPage(),
          ),
        ],
      ),

      bottomNavigationBar: Container(
        height: 75,
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(blurRadius: 10, color: Colors.black12)
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [

            navItem(Icons.home, "Home", 0),
            navItem(Icons.search, "Search", 1),
            navItem(Icons.shopping_cart_outlined, "Cart", 2),
            navItem(Icons.favorite_border, "Favorite", 3),

            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const AccountScreen(),
                  ),
                );
              },
              child: const Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.person_outline),
                  SizedBox(height: 5),
                  Text("Account", style: TextStyle(fontSize: 12)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget navItem(IconData icon, String label, int index) {
    bool isSelected = _selectedIndex == index;

    return GestureDetector(
      onTap: () => _onItemTapped(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon,
              color: isSelected ? Colors.red : Colors.black),
          const SizedBox(height: 5),
          Text(label,
              style: TextStyle(
                  fontSize: 12,
                  color: isSelected ? Colors.red : Colors.black)),
        ],
      ),
    );
  }
}

class HomeContent extends StatefulWidget {
  const HomeContent({super.key});

  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {

  final ScrollController _scrollController = ScrollController();
  Timer? _timer;

  int currentIndex = 0;
  Timer? bannerTimer;

  final List<String> bannerImages = [
    "assets/images/pic1.png",
    "assets/images/pic2.png",
    "assets/images/pic3.png",
    "assets/images/pic4.png",
  ];

  final Map<String, Map<String, dynamic>> categories = {

    "Premier League": {
      "image": "assets/images/pl.png",
      "sub": [
        {"name": "Arsenal", "image": "assets/images/arsenal.jpeg"},
        {"name": "Chelsea", "image": "assets/images/Chelsea.png"},
        {"name": "Leicester", "image": "assets/images/Leicester.png"},
        {"name": "Tottenham", "image": "assets/images/tottehnham.png"},
        {"name": "Manchester UTD", "image": "assets/images/manU.png"},
      ]
    },

    "Bundesliga": {
      "image": "assets/images/bundesliga.png",
      "sub": [
        {"name": "Bayern Munich", "image": "assets/images/bayern.jpeg"},
        {"name": "Dortmund", "image": "assets/images/dortmund.png"},
        {"name": "RB Leipzig", "image": "assets/images/leipzig.png"},
        {"name": "Leverkusen", "image": "assets/images/leverkusen.png"},
      ]
    },

    "EFL": {
      "image": "assets/images/EFL1.png",
      "sub": [
        {"name": "Norwich", "image": "assets/images/norwich.png"},
        {"name": "Watford", "image": "assets/images/watford.png"},
        {"name": "Sunderland", "image": "assets/images/sunderland.png"},
        {"name": "Leeds", "image": "assets/images/leeds.png"},
      ]
    },

    "La Liga": {
      "image": "assets/images/laliga.png",
      "sub": [
        {"name": "Barcelona", "image": "assets/images/barcelona.png"},
        {"name": "Real Madrid", "image": "assets/images/realmadrid.png"},
        {"name": "Atletico Madrid", "image": "assets/images/atleticomadrid.png"},
      ]
    },

    "Ligue 1": {
      "image": "assets/images/ligue1.jpg",
      "sub": [
        {"name": "PSG", "image": "assets/images/psg.png"},
        {"name": "Marseille", "image": "assets/images/Marseille.png"},
        {"name": "Monaco", "image": "assets/images/monaco.png"},
        {"name": "Lyon", "image": "assets/images/lyon.png"},
      ]
    },

    "Serie A": {
      "image": "assets/images/serieA.png",
      "sub": [
        {"name": "Juventus", "image": "assets/images/Juventus1.png"},
        {"name": "Inter", "image": "assets/images/interMilan.png"},
        {"name": "AC Milan", "image": "assets/images/acmilan.png"},
        {"name": "Napoli", "image": "assets/images/napoli.png"},
      ]
    },

    "International": {
      "image": "assets/images/international.png",
      "sub": [
        {"name": "Argentina", "image": "assets/images/argentina.png"},
        {"name": "Brazil", "image": "assets/images/brazil1.png"},
        {"name": "France", "image": "assets/images/france.png"},
        {"name": "Germany", "image": "assets/images/germany.png"},
      ]
    },
  };

  void openSubCategory(String title, List<Map<String, String>> subs) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => SubCategoryScreen(
          title: title,
          subCategories: subs,
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    _timer = Timer.periodic(const Duration(seconds: 3), (_) {
      if (!_scrollController.hasClients) return;

      double max = _scrollController.position.maxScrollExtent;
      double current = _scrollController.offset + 130;

      if (current >= max) current = 0;

      _scrollController.animateTo(
        current,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOut,
      );
    });

    bannerTimer = Timer.periodic(const Duration(seconds: 2), (_) {
      setState(() {
        currentIndex = (currentIndex + 1) % bannerImages.length;
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    bannerTimer?.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [

        const SizedBox(height: 20),

        const Text(
          "SHOP YOUR FAVOURITE LEAGUE",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),

        const SizedBox(height: 20),

        SizedBox(
          height: 140,
          child: ListView.builder(
            controller: _scrollController,
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            itemCount: categories.length,
            itemBuilder: (context, index) {

              String title = categories.keys.elementAt(index);
              String image = categories[title]!["image"];
              List<Map<String, String>> subs =
              List<Map<String, String>>.from(categories[title]!["sub"]);

              return GestureDetector(
                onTap: () => openSubCategory(title, subs),
                child: Container(
                  width: 110,
                  margin: const EdgeInsets.only(right: 20),
                  child: Column(
                    children: [

                      Container(
                        height: 90,
                        width: 90,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade300,
                              blurRadius: 8,
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Image.asset(image),
                        ),
                      ),

                      const SizedBox(height: 10),
                      Text(title),
                    ],
                  ),
                ),
              );
            },
          ),
        ),

        const SizedBox(height: 25),

        Container(
          height: 300,
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              child: Image.asset(
                bannerImages[currentIndex],
                key: ValueKey(currentIndex),
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
          ),
        ),
      ],
    );
  }
}