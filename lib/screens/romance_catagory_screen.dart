// ignore_for_file: use_super_parameters, deprecated_member_use, sort_child_properties_last, sized_box_for_whitespace, avoid_returning_null_for_void, avoid_print

import 'package:flutter/material.dart';
import './home_screen.dart';

class RomanceCategoryScreen extends StatefulWidget {
  const RomanceCategoryScreen({Key? key}) : super(key: key);

  @override
  State<RomanceCategoryScreen> createState() => _RomanceCategoryScreenState();
}

class _RomanceCategoryScreenState extends State<RomanceCategoryScreen>
    with TickerProviderStateMixin {
  AnimationController? _fadeController;
  Animation<double>? _fadeAnimation;

  // Search bar controller
  final TextEditingController _searchController = TextEditingController();

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
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Color(0xFFFDF0D5),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Header Section with Background Image and Back Button
              _buildHeaderSection(),
              const SizedBox(height: 10),
              _buildSearchBar(),
              // Romance Books Section
              _buildRomanceBooksSection(),
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
            hintText: 'Search for your fav Romance Books...',
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

  Widget _buildHeaderSection() {
    return Container(
      height: 200,
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
          image: AssetImage('assets/images/romanceHeaderImage.png'),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Colors.white.withOpacity(0.6),
            BlendMode.modulate,
          ),
        ),
      ),
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(20, 50, 20, 20),
            child: FadeTransition(
              opacity: _fadeAnimation ?? const AlwaysStoppedAnimation(1.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Romance',
                    style: TextStyle(
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
                ],
              ),
            ),
          ),
          Positioned(
            top: 40,
            left: 16,
            child: GestureDetector(
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()),
                );
              },
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color.fromARGB(133, 253, 240, 213),
                ),
                child: Icon(
                  Icons.arrow_back,
                  color: Color(0xFF4C260B),
                  size: 30,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRomanceBooksSection() {
    final romanceBooks = [
      {
        'image': 'assets/images/loveStory.png',
        'name': 'Love Story',
        'price': '12.5 DT',
        'description':
            'A passionate love story in the city of lights that will capture your heart.',
      },
      {
        'image': 'assets/images/heartsEntwined.png',
        'name': 'Hearts Entwined',
        'price': '10.0 DT',
        'description': 'Two souls destined to be together against all odds.',
      },
      {
        'image': 'assets/images/summerRomance.png',
        'name': 'Summer Romance',
        'price': '9.5 DT',
        'description': 'A perfect beach read for romance lovers everywhere.',
      },
      {
        'image': 'assets/images/midnightKiss.png',
        'name': 'Midnight Kiss',
        'price': '11.5 DT',
        'description': 'When love strikes at the stroke of midnight.',
      },
      {
        'image': 'assets/images/enchantedGarden.png',
        'name': 'Enchanted Garden',
        'price': '13.0 DT',
        'description': 'Love blooms in the most unexpected places.',
      },
      {
        'image': 'assets/images/foreverYours.png',
        'name': 'Forever Yours',
        'price': '14.5 DT',
        'description': 'A timeless tale of eternal love and devotion.',
      },
      {
        'image': 'assets/images/secretAdmirer.png',
        'name': 'Secret Admirer',
        'price': '10.5 DT',
        'description': 'Mystery meets romance in this thrilling love story.',
      },
      {
        'image': 'assets/images/seasidePromises.png',
        'name': 'Seaside Promise',
        'price': '12.0 DT',
        'description': 'Ocean waves carry promises of undying love.',
      },
    ];

    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: romanceBooks.map((book) {
          return _buildHorizontalBookCard(book);
        }).toList(),
      ),
    );
  }

  Widget _buildHorizontalBookCard(Map<String, String> book) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: const Color.fromARGB(195, 255, 255, 255),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Color(0xFF99582a).withOpacity(0.3),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Color(0xFF4C260B).withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          // Book Image Section (Left) with added padding
          Container(
            margin: const EdgeInsets.only(left: 12),
            width: 120,
            height: 160,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                bottomLeft: Radius.circular(12),
                topRight: Radius.circular(12),
                bottomRight: Radius.circular(12),
              ),
              image: DecorationImage(
                image: AssetImage(book['image']!),
                fit: BoxFit.cover,
                onError: (exception, stackTrace) => null,
              ),
            ),
            child: book['image']!.isNotEmpty
                ? null
                : Container(
                    decoration: BoxDecoration(
                      color: Color(0xFF99582a).withOpacity(0.2),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(15),
                        bottomLeft: Radius.circular(15),
                      ),
                    ),
                    child: Icon(Icons.book, size: 40, color: Color(0xFF99582a)),
                  ),
          ),
          // Book Details Section (Right)
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Book Name
                  Text(
                    book['name']!,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF4C260B),
                      height: 1.2,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  // Price
                  Text(
                    book['price']!,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF99582a),
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Description
                  Text(
                    book['description']!,
                    style: TextStyle(
                      fontSize: 13,
                      color: Color(0xFF4C260B).withOpacity(0.7),
                      height: 1.4,
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 12),
                  // Buy Now Button
                  Container(
                    width: double.infinity,
                    height: 36,
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
                        onTap: () {
                          _showPurchaseDialog(book['name']!);
                        },
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
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showPurchaseDialog(String bookName) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color.fromARGB(255, 239, 221, 184),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          title: Text(
            'Purchase Book',
            style: TextStyle(
              color: Color(0xFF4C260B),
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            'Do you want to buy "$bookName"?',
            style: TextStyle(
              color: Color(0xFF99582a),
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Cancel',
                style: TextStyle(
                  color: Color(0xFF99582a),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                // Handle purchase logic here
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Added "$bookName" to cart!',
                      style: TextStyle(fontSize: 18),
                    ),
                    backgroundColor: Color(0xFF99582a),
                    duration: Duration(seconds: 2),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF99582a),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                'Buy Now',
                style: TextStyle(
                  color: Color.fromARGB(170, 255, 242, 226),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
