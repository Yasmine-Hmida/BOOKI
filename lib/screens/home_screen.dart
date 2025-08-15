// ignore_for_file: use_super_parameters, deprecated_member_use, sort_child_properties_last, sized_box_for_whitespace, avoid_print

import 'package:flutter/material.dart';
import './cart_screen.dart';
import './catagory_screen.dart';
import './profile_screen.dart';
import './add_book_screen.dart';

import './history_catagory_screen.dart';
import './sci-fi_catagory_screen.dart';
import './mystery_catagory_screen.dart';
import './fiction_catagory_screen.dart';
import './romance_catagory_screen.dart';
import './biography_catagory_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  AnimationController? _fadeController;
  AnimationController? _slideController;
  Animation<double>? _fadeAnimation;
  Animation<Offset>? _slideAnimation;
  int _selectedIndex = 0;

  // Search bar controller
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _fadeController!, curve: Curves.easeOut));
    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero).animate(
          CurvedAnimation(parent: _slideController!, curve: Curves.easeOut),
        );

    _fadeController!.forward();
    _slideController!.forward();
  }

  @override
  void dispose() {
    _fadeController?.dispose();
    _slideController?.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      bottomNavigationBar: _buildBottomNavigation(),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Color(0xFFFDF0D5),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Header Section
              const SizedBox(height: 20),
              _buildHeader(),
              // Search Bar
              _buildSearchBar(),
              const SizedBox(height: 10),
              // Hero Section
              _buildHeroSection(),
              // Circular Categories Section
              _buildCircularCategoriesSection(width),
              // Featured Books
              _buildFeaturedBooks(),
              // Special Offers
              const SizedBox(height: 20),
              _buildSpecialOffers(),
              // Bottom padding
              const SizedBox(height: 60),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Container(
        decoration: BoxDecoration(
          color: const Color.fromARGB(195, 239, 221, 184),
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              color: Color(0xFF4C260B).withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
          border: Border.all(color: Color.fromARGB(255, 76, 38, 11), width: 1),
        ),
        child: TextField(
          controller: _searchController,
          decoration: InputDecoration(
            hintText: 'Search for your Desired Books...',
            hintStyle: TextStyle(color: Colors.black87, fontSize: 16),
            prefixIcon: Icon(
              Icons.search,
              color: Color.fromARGB(255, 177, 140, 81),
              size: 24,
            ),
            suffixIcon: _searchController.text.isNotEmpty
                ? IconButton(
                    icon: Icon(Icons.clear, color: Color(0xFF99582a), size: 20),
                    onPressed: () {
                      setState(() {
                        _searchController.clear();
                      });
                    },
                  )
                : null,
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 15,
            ),
          ),
          style: TextStyle(color: Color(0xFF4C260B), fontSize: 16),
          onChanged: (value) {
            setState(() {}); // Rebuild to show/hide clear button
          },
          onSubmitted: (value) {
            // Handle search functionality here
            print('Searching for: $value');
          },
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 50, 20, 20),
      color: Color(0xFFFDF0D5),
      child: FadeTransition(
        opacity: _fadeAnimation ?? const AlwaysStoppedAnimation(1.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/BOOKI_Icon.png',
              width: 18,
              height: 55,
              errorBuilder: (context, error, stackTrace) =>
                  Icon(Icons.book, size: 55, color: Color(0xFF4C260B)),
            ),
            const Text(
              'BO',
              style: TextStyle(
                fontSize: 50,
                fontFamily: 'Rubik',
                color: Color(0xFF4C260B),
                shadows: [
                  Shadow(
                    offset: Offset(2, 2),
                    blurRadius: 4,
                    color: Colors.black26,
                  ),
                ],
              ),
            ),
            const Text(
              'OK',
              style: TextStyle(
                fontSize: 50,
                fontFamily: 'Rubik',
                color: Color(0xFF99582a),
                shadows: [
                  Shadow(
                    offset: Offset(2, 2),
                    blurRadius: 4,
                    color: Colors.black26,
                  ),
                ],
              ),
            ),
            const Text(
              'I',
              style: TextStyle(
                fontSize: 50,
                fontFamily: 'Rubik',
                color: Color(0xFF4C260B),
                shadows: [
                  Shadow(
                    offset: Offset(2, 2),
                    blurRadius: 4,
                    color: Colors.black26,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNavigation() {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: const Color.fromARGB(238, 153, 88, 42),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
        border: Border.all(color: Color(0xFF99582a), width: 2.0),
        boxShadow: [
          BoxShadow(
            color: Color(0xFF4C260B).withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildNavItem(Icons.home, 0, const HomeScreen()),
          _buildNavItem(Icons.search, 1, const CatagoryScreen()),
          _buildSpecialNavItem(Icons.add, 2),
          _buildNavItem(Icons.shopping_cart_outlined, 3, const CartScreen()),
          _buildNavItem(Icons.person_outline, 4, const ProfileScreen()),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, int index, Widget page) {
    bool isSelected = _selectedIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });
        Navigator.push(context, MaterialPageRoute(builder: (context) => page));
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color.fromARGB(208, 255, 242, 226)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Icon(
          icon,
          color: isSelected
              ? const Color.fromARGB(255, 76, 38, 11)
              : const Color.fromARGB(208, 255, 242, 226),
          size: 24,
        ),
      ),
    );
  }

  Widget _buildSpecialNavItem(IconData icon, int index) {
    bool isSelected = _selectedIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          if (_selectedIndex == index) {
            _selectedIndex = -1;
          } else {
            _selectedIndex = index;
          }
        });

        // Navigate to AddBookScreen when tapped
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const AddBookScreen()),
        );
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color.fromARGB(255, 76, 38, 11)
              : const Color(0xFFf2cc8f),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color:
                  (isSelected
                          ? const Color(0xFFB8860B)
                          : const Color.fromARGB(255, 205, 125, 68))
                      .withOpacity(0.4),
              spreadRadius: 0,
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Icon(
          icon,
          color: isSelected
              ? const Color.fromARGB(208, 255, 242, 226)
              : const Color.fromARGB(222, 76, 38, 11),
          size: 30,
        ),
      ),
    );
  }

  Widget _buildHeroSection() {
    return Container(
      height: 250,
      width: double.infinity,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Color(0xFF4C260B).withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
        image: DecorationImage(
          image: AssetImage('assets/images/heroSectionImage.png'),
          fit: BoxFit.contain,
          colorFilter: ColorFilter.mode(
            Colors.white.withOpacity(0.7), // Adjust opacity (0.0 to 1.0)
            BlendMode.modulate,
          ),
        ),
      ),
      child: SlideTransition(
        position: _slideAnimation ?? AlwaysStoppedAnimation(Offset.zero),
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Discover Your',
                style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.w800,
                  color: Color.fromARGB(244, 76, 38, 11),
                ),
              ),
              const Text(
                'Next Great Read',
                style: TextStyle(
                  fontSize: 28,
                  color: Color.fromARGB(221, 153, 88, 42),
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Find your perfect story today.',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF4C260B),
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCircularCategoriesSection(double width) {
    final categories = [
      {
        'name': 'Fiction',
        'icon': "assets/images/science-fiction.png",
        'color': const Color.fromARGB(255, 205, 125, 68),
        'page': const FictionCategoryScreen(),
      },
      {
        'name': 'Mystery',
        'icon': "assets/images/mystery.png",
        'color': const Color.fromARGB(255, 139, 69, 19),
        'page': const MysteryCategoryScreen(),
      },
      {
        'name': 'Romance',
        'icon': "assets/images/romance.png",
        'color': const Color(0xFFCD853F),
        'page': const RomanceCategoryScreen(),
      },
      {
        'name': 'Sci-Fi',
        'icon': "assets/images/sci-fi.png",
        'color': const Color(0xFFCD853F),
        'page': const SciFiCategoryScreen(),
      },
      {
        'name': "Biography",
        'icon': "assets/images/biography.png",
        'color': const Color(0xFFDEB887),
        'page': const BiographyCategoryScreen(),
      },
      {
        'name': 'History',
        'icon': "assets/images/history.png",
        'color': const Color.fromARGB(255, 139, 69, 19),
        'page': const HistoryCategoryScreen(),
      },
    ];

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Explore Categories',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 139, 69, 19),
            ),
          ),
          const SizedBox(height: 20),
          Wrap(
            spacing: 16,
            runSpacing: 16,
            alignment: WrapAlignment.center,
            children: categories.map((category) {
              return SizedBox(
                width: 105,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => category['page'] as Widget,
                          ),
                        );
                      },
                      child: Container(
                        width: 75,
                        height: 75,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: category['color'] as Color,
                          boxShadow: [
                            BoxShadow(
                              color: (category['color'] as Color).withOpacity(
                                0.3,
                              ),
                              spreadRadius: 1,
                              blurRadius: 6,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Center(
                          child: Image.asset(
                            category['icon'] as String,
                            color: Colors.white,
                            width: 38,
                            height: 38,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      category['name'] as String,
                      style: const TextStyle(
                        color: Color.fromARGB(255, 139, 69, 19),
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturedBooks() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Best Sellers',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 139, 69, 19),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 290,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 5,
              itemBuilder: (context, index) {
                return _buildBookCard(index);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBookCard(int index) {
    final titles = [
      'The Great Adventure',
      'Mystery of Time',
      'Love Stories',
      'Space Odyssey',
      'Life Chronicles',
    ];

    final authors = [
      'Janice Holt Giles',
      'S.A.L. Rachele',
      'Erich Segal',
      'Arthur C. Clarke',
      'Vernae Taylor',
    ];

    final images = [
      "assets/images/greatAdventure.png",
      "assets/images/mysteryTime.png",
      "assets/images/image.png",
      "assets/images/spaceOdyssey.png",
      "assets/images/lifeChronicals.png",
    ];

    final prices = ["8.5 DT", "10.5 DT", "9.5 DT", "7.5 DT", "11 DT"];

    return Container(
      width: 160,
      margin: const EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        color: const Color.fromARGB(193, 255, 255, 255),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          // Added border here
          color: Color(0xFF99582a),
          width: 0.5,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(255, 205, 125, 68).withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 190,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
              image: DecorationImage(
                image: AssetImage(images[index % images.length]),
                fit: BoxFit.cover,
                onError: (exception, stackTrace) =>
                    const Icon(Icons.book, size: 48, color: Colors.white),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  titles[index % titles.length],
                  style: const TextStyle(
                    color: Color.fromARGB(255, 139, 69, 19),
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  authors[index % authors.length],
                  style: TextStyle(
                    color: const Color.fromARGB(
                      255,
                      139,
                      69,
                      19,
                    ).withOpacity(0.6),
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  prices[index % prices.length],
                  style: const TextStyle(
                    color: Color.fromARGB(255, 76, 38, 11),
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSpecialOffers() {
    return Container(
      height: 250,
      width: double.infinity,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Color(0xFF4C260B).withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 3,
            offset: Offset(0, 1),
          ),
        ],
        image: DecorationImage(
          image: AssetImage('assets/images/specialOfferImage.png'),
          fit: BoxFit.contain,
          colorFilter: ColorFilter.mode(
            Colors.white.withOpacity(0.6), // Adjust opacity (0.0 to 1.0)
            BlendMode.modulate,
          ),
        ),
      ),
      child: SlideTransition(
        position: _slideAnimation ?? AlwaysStoppedAnimation(Offset.zero),
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 16),
                        const Text(
                          'Special Offers',
                          style: TextStyle(
                            fontSize: 35,
                            fontWeight: FontWeight.w800,
                            color: Color.fromARGB(244, 76, 38, 11),
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'Get to even 40% OFF !',
                          style: TextStyle(
                            fontSize: 28,
                            color: Color.fromARGB(214, 125, 61, 15),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'On our Best Sellers',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                            color: Color.fromARGB(244, 76, 38, 11),
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
