// ignore_for_file: use_super_parameters, deprecated_member_use, sort_child_properties_last, sized_box_for_whitespace, avoid_returning_null_for_void, avoid_print

import 'package:flutter/material.dart';
import './home_screen.dart';
import './profile_screen.dart';
import './catagory_screen.dart';
import './add_book_screen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> with TickerProviderStateMixin {
  int _selectedIndex = 3; // Cart tab selected
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

  // Sample cart items
  List<Map<String, dynamic>> cartItems = [
    {
      'id': 1,
      'image': 'assets/images/loveStory.png',
      'name': 'Love in Paris',
      'author': 'Marie Claire',
      'price': 12.5,
    },
    {
      'id': 2,
      'image': 'assets/images/heartsEntwined.png',
      'name': 'Hearts Entwined',
      'author': 'Sophie Laurent',
      'price': 10.0,
    },
  ];

  // Calculate total price
  double get totalPrice {
    return cartItems.fold(0.0, (sum, item) => sum + (item['price'] as double));
  }

  // Delete item from cart
  void _deleteItem(int id) {
    setState(() {
      cartItems.removeWhere((item) => item['id'] == id);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Item removed from cart'),
        backgroundColor: const Color(0xFF99582a),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  // Show checkout confirmation
  void _goToCheckout() {
    if (cartItems.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Your cart is empty'),
          backgroundColor: Colors.red[400],
          duration: const Duration(seconds: 2),
        ),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color.fromARGB(255, 239, 221, 184),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          title: const Text(
            'Checkout',
            style: TextStyle(
              color: Color(0xFF4C260B),
              fontWeight: FontWeight.w800,
            ),
          ),
          content: Text(
            'Proceed to checkout with total: ${totalPrice.toStringAsFixed(1)} DT?',
            style: const TextStyle(
              color: Color(0xFF99582a),
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
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
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Proceeding to checkout...',
                      style: TextStyle(fontSize: 18),
                    ),
                    backgroundColor: Color(0xFF99582a),
                    duration: Duration(seconds: 2),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF99582a),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'Checkout',
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _buildBottomNavigation(),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: const Color(0xFFFDF0D5),
        child: Column(
          children: [
            const SizedBox(height: 20),
            _buildHeader(),
            Expanded(
              child: cartItems.isEmpty
                  ? _buildEmptyCart()
                  : _buildCartContent(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 50, 20, 20),
      color: const Color(0xFFFDF0D5),
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
                  const Icon(Icons.book, size: 55, color: Color(0xFF4C260B)),
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

  Widget _buildEmptyCart() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.shopping_cart_outlined,
            size: 80,
            color: const Color(0xFF99582a).withOpacity(0.5),
          ),
          const SizedBox(height: 20),
          const Text(
            'Your cart is empty',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: Color(0xFF4C260B),
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'Add some books to get started!',
            style: TextStyle(fontSize: 16, color: Color(0xFF99582a)),
          ),
        ],
      ),
    );
  }

  Widget _buildCartContent() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                return _buildCartItem(cartItems[index]);
              },
            ),
          ),
          _buildTotalSection(),
          const SizedBox(height: 20),
          _buildCheckoutButton(),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildCartItem(Map<String, dynamic> item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color.fromARGB(193, 255, 255, 255),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: const Color(0xFF99582a).withOpacity(0.3),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF4C260B).withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              image: item['image'].isNotEmpty
                  ? DecorationImage(
                      image: AssetImage(item['image']),
                      fit: BoxFit.cover,
                    )
                  : null,
            ),
            child: item['image'].isEmpty
                ? Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFF99582a).withOpacity(0.2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(
                      Icons.book,
                      size: 30,
                      color: Color(0xFF99582a),
                    ),
                  )
                : null,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item['name'],
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF4C260B),
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  'by ${item['author']}',
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF99582a),
                  ),
                ),
              ],
            ),
          ),
          Text(
            '${(item['price'] as double).toStringAsFixed(1)} DT',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF99582a),
            ),
          ),
          const SizedBox(width: 12),
          GestureDetector(
            onTap: () => _deleteItem(item['id'] as int),
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Color(0xFF99582a),
                borderRadius: BorderRadius.circular(6),
              ),
              child: const Icon(
                Icons.delete_outline,
                color: Color.fromARGB(218, 255, 255, 255),
                size: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTotalSection() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      decoration: BoxDecoration(
        color: const Color(0xFF99582a).withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFF99582a).withOpacity(0.3),
          width: 1.5,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Total:',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF4C260B),
            ),
          ),
          Text(
            '${totalPrice.toStringAsFixed(1)} DT',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF99582a),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCheckoutButton() {
    return Container(
      width: double.infinity,
      height: 52,
      decoration: BoxDecoration(
        color: const Color(0xFF99582a),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF4C260B).withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: _goToCheckout,
          child: const Center(
            child: Text(
              'Go to Checkout',
              style: TextStyle(
                color: Color.fromARGB(208, 255, 242, 226),
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
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
}
