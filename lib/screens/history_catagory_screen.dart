// ignore_for_file: use_super_parameters, deprecated_member_use, sort_child_properties_last, sized_box_for_whitespace, avoid_returning_null_for_void, avoid_print

import 'package:flutter/material.dart';

class HistoryCategoryScreen extends StatefulWidget {
  const HistoryCategoryScreen({Key? key}) : super(key: key);

  @override
  State<HistoryCategoryScreen> createState() => _HistoryCategoryScreenState();
}

class _HistoryCategoryScreenState extends State<HistoryCategoryScreen>
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
              // Header Section
              _buildHeaderSection(),

              const SizedBox(height: 10),
              // Search Bar Section
              _buildSearchBar(),

              // History Books Section
              _buildHistoryBooksSection(),

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
            hintText: 'Search for your fav history Books...',
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
            setState(() {});
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
          image: AssetImage('assets/images/historyHeaderImage.png'),
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
                    'History',
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
                Navigator.pop(context);
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

  Widget _buildHistoryBooksSection() {
    final historyBooks = [
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
      {
        'image': 'assets/images/1776.jpg',
        'name': '1776',
        'price': '17.0 DT',
        'description':
            'Intense tale of those who marched with General George Washington.',
      },
    ];

    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: historyBooks.map((book) {
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
          // Book Image Section
          Container(
            margin: const EdgeInsets.only(left: 12),
            width: 120,
            height: 160,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
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
          // Book Details Section
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
                  // "Buy Now" Button
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
                  color: Color(0xFF4C260B),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Added "$bookName" to cart!',
                      style: TextStyle(
                        color: Color.fromARGB(208, 255, 242, 226),
                        fontSize: 20,
                      ),
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
