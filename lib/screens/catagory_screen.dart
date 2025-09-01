// ignore_for_file: use_super_parameters, deprecated_member_use, sort_child_properties_last, sized_box_for_whitespace, avoid_print

import 'package:flutter/material.dart';

// Screens of the bottom Navigation
import './home_screen.dart';
import './add_book_screen.dart';
import './cart_screen.dart';
import './profile_screen.dart';

// Specific Catagories Screens
import './history_catagory_screen.dart';
import './sci-fi_catagory_screen.dart';
import './mystery_catagory_screen.dart';
import './fiction_catagory_screen.dart';
import './romance_catagory_screen.dart';
import './biography_catagory_screen.dart';

class CatagoryScreen extends StatefulWidget {
  const CatagoryScreen({Key? key}) : super(key: key);

  @override
  State<CatagoryScreen> createState() => _CatagoryScreenState();
}

class _CatagoryScreenState extends State<CatagoryScreen>
    with TickerProviderStateMixin {
  int _selectedIndex = 1; // Categories tab selected
  AnimationController? _fadeController;
  Animation<double>? _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _fadeController!, curve: Curves.easeOut));

    _fadeController!.forward();
  }

  @override
  void dispose() {
    _fadeController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _buildBottomNavigation(),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: const Color(0xFFFDF0D5),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildHeaderSection(),
              _buildCategorySections(),
              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderSection() {
    return Container(
      height: 200,
      width: double.infinity,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF4C260B).withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
        image: DecorationImage(
          image: const AssetImage('assets/images/categoriesHeaderImage.png'),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Colors.white.withOpacity(0.5),
            BlendMode.modulate,
          ),
        ),
      ),
      child: Container(
        padding: const EdgeInsets.fromLTRB(20, 50, 20, 20),
        child: FadeTransition(
          opacity: _fadeAnimation ?? const AlwaysStoppedAnimation(1.0),
          child: Center(
            child: Text(
              'Categories',
              style: const TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.w800,
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
          ),
        ),
      ),
    );
  }

  Widget _buildCategorySections() {
    final categories = [
      {
        'name': 'Romance',
        'books': [
          {
            'image': 'assets/images/loveStory.png',
            'name': 'Love Story',
            'price': '12.5 DT',
            'description': 'A passionate love story in the city of lights.',
          },
          {
            'image': 'assets/images/heartsEntwined.png',
            'name': 'Hearts Entwined',
            'price': '10.0 DT',
            'description': 'Two souls destined to be together.',
          },
          {
            'image': 'assets/images/summerRomance.png',
            'name': 'Summer Romance',
            'price': '9.5 DT',
            'description': 'A perfect beach read for romance lovers.',
          },
        ],
      },
      {
        'name': 'Fiction',
        'books': [
          {
            'image': 'assets/images/theLostWorld.png',
            'name': 'The Lost World',
            'price': '15.0 DT',
            'description': 'An epic adventure in uncharted territories.',
          },
          {
            'image': 'assets/images/theGreatGatsby.png',
            'name': 'The Great Gatsby',
            'price': '13.5 DT',
            'description': 'A tale that examines themes of wealth,and love.',
          },
          {
            'image': 'assets/images/harryPotter.png',
            'name': 'Harry Potter and the sorcerer\'s \n stone',
            'price': '11.0 DT',
            'description': 'The first book in the beloved Harry Potter series.',
          },
        ],
      },
      {
        'name': 'Mystery',
        'books': [
          {
            'image': 'assets/images/theSilentWitness.png',
            'name': 'The Silent Witness',
            'price': '14.0 DT',
            'description': 'A gripping tale of secrets and deception.',
          },
          {
            'image': 'assets/images/darkAlley.png',
            'name': 'Dark Alley',
            'price': '12.0 DT',
            'description': 'Murder mystery that will keep you guessing.',
          },
          {
            'image': 'assets/images/theDetective.png',
            'name': 'The Detective',
            'price': '13.0 DT',
            'description': 'Classic detective work at its finest.',
          },
        ],
      },
      {
        'name': 'Sci-Fi',
        'books': [
          {
            'image': 'assets/images/galacticWars.png',
            'name': 'Galactic Wars',
            'price': '16.5 DT',
            'description': 'Epic space battles across the universe.',
          },
          {
            'image': 'assets/images/timeTraveler.png',
            'name': 'Time Traveler',
            'price': '14.5 DT',
            'description': 'Journey through time and dimensions.',
          },
        ],
      },
      {
        'name': 'Biography',
        'books': [
          {
            'image': 'assets/images/greatLeaders.png',
            'name': 'Great Leaders',
            'price': '18.0 DT',
            'description': 'Stories of those who changed the world.',
          },
          {
            'image': 'assets/images/artistJourney.png',
            'name': 'Artist\'s Journey',
            'price': '15.5 DT',
            'description': 'The life of a revolutionary painter.',
          },
        ],
      },
      {
        'name': 'History',
        'books': [
          {
            'image': 'assets/images/ancientCivilizations.png',
            'name': 'Ancient Civilizations',
            'price': '20.0 DT',
            'description': 'Exploring the mysteries of the past.',
          },
          {
            'image': 'assets/images/medievalTimes.png',
            'name': 'Medieval Times',
            'price': '19.0 DT',
            'description': 'Life in the age of knights and castles.',
          },
        ],
      },
    ];

    return Column(
      children: categories.map((category) {
        return _buildCategorySection(
          category['name'] as String,
          category['books'] as List<Map<String, String>>,
        );
      }).toList(),
    );
  }

  Widget _buildCategorySection(
    String categoryName,
    List<Map<String, String>> books,
  ) {
    // Map category names to their respective screens when clicking the button: "See More"
    final categoryScreens = {
      'Romance': const RomanceCategoryScreen(),
      'Fiction': const FictionCategoryScreen(),
      'Mystery': const MysteryCategoryScreen(),
      'Sci-Fi': const SciFiCategoryScreen(),
      'Biography': const BiographyCategoryScreen(),
      'History': const HistoryCategoryScreen(),
    };

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          Text(
            categoryName,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Color(0xFF4C260B),
              shadows: [
                Shadow(
                  offset: Offset(1, 1),
                  blurRadius: 2,
                  color: Colors.black26,
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Wrap(
              spacing: 16,
              runSpacing: 20,
              alignment: WrapAlignment.center,
              children: books.map((book) {
                return _buildBookCard(book);
              }).toList(),
            ),
          ),
          const SizedBox(height: 16),
          // The "See More" Button
          Container(
            width: 250,
            height: 45,
            margin: const EdgeInsets.symmetric(horizontal: 40),
            decoration: BoxDecoration(
              color: const Color(0xFF4C260B),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Color(0xFF99582a), width: 1),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF4C260B).withOpacity(0.3),
                  spreadRadius: 0,
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(16),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          categoryScreens[categoryName] ??
                          CategoryScreen(categoryName: categoryName),
                    ),
                  );
                },
                child: const Center(
                  child: Text(
                    'See More',
                    style: TextStyle(
                      color: Color.fromARGB(207, 255, 255, 255),
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),

          // The line divider between each catagory
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
            height: 2,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.transparent,
                  const Color(0xFF99582a).withOpacity(0.3),
                  Colors.transparent,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBookCard(Map<String, String> book) {
    return Container(
      width: 170,
      decoration: BoxDecoration(
        color: const Color.fromARGB(193, 255, 255, 255),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: const Color(0xFF99582a).withOpacity(0.3),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF4C260B).withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Image Container
          Container(
            height: 180,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
              image: DecorationImage(
                image: AssetImage(book['image']!),
                fit: BoxFit.cover,
                onError: (exception, stackTrace) {},
              ),
            ),
            child:
                book['image']!
                    .isNotEmpty // In case there is no image provided
                ? null
                : Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFF99582a).withOpacity(0.2),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12),
                      ),
                    ),
                    child: const Icon(
                      Icons.book,
                      size: 40,
                      color: Color(0xFF99582a),
                    ),
                  ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  book['name']!,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF4C260B),
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Text(
                  book['price']!,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF99582a),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  book['description']!,
                  style: TextStyle(
                    fontSize: 11,
                    color: const Color(0xFF4C260B).withOpacity(0.7),
                    height: 1.3,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),

                // The "Buy" button
                Container(
                  width: double.infinity,
                  height: 32,
                  decoration: BoxDecoration(
                    color: const Color(0xFF99582a),
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF4C260B).withOpacity(0.3),
                        spreadRadius: 0,
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(16),
                      child: const Center(
                        child: Text(
                          'Buy',
                          style: TextStyle(
                            color: Color.fromARGB(170, 255, 242, 226),
                            fontSize: 14,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                      onTap: () {
                        print('Buy ${book['name']}');
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
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
}

// This will appear in case there is not category (fallback catagory section)
class CategoryScreen extends StatelessWidget {
  final String categoryName;

  const CategoryScreen({Key? key, required this.categoryName})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          '$categoryName Category Page',
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color(0xFF4C260B),
          ),
        ),
      ),
    );
  }
}
