// ignore_for_file: use_super_parameters, deprecated_member_use, sort_child_properties_last, sized_box_for_whitespace, avoid_print

import 'package:flutter/material.dart';

// Screens of the bottom Navigation
import './home_screen.dart';
import './catagory_screen.dart';
import './add_book_screen.dart';
import './cart_screen.dart';

// Navigation Links
import './login_screen.dart';
import './edit_profile_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with TickerProviderStateMixin {
  int _selectedIndex = 4; // Profile tab selected
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
        color: Color(0xFFFDF0D5),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),
              // Header Section
              _buildHeader(),
              const SizedBox(height: 30),
              // Profile Info Section
              _buildProfileInfo(),
              const SizedBox(height: 70),
              // Menu Options
              _buildMenuOptions(),
              // Bottom padding for navigation
              const SizedBox(height: 80),
            ],
          ),
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

  Widget _buildProfileInfo() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: const EdgeInsets.all(0),
      child: Row(
        children: [
          const SizedBox(width: 10),
          // Profile Image
          Container(
            width: 150,
            height: 150,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFF99582a).withOpacity(0.2),
              border: Border.all(
                color: Color.fromARGB(210, 76, 38, 11),
                width: 2,
              ),
              boxShadow: [
                BoxShadow(
                  color: Color(0xFF4C260B).withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: ClipOval(
              child: Image.asset(
                'assets/images/profileImage.jpeg',
                width: 80,
                height: 80,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    Icon(Icons.person, size: 40, color: Color(0xFF99582a)),
              ),
            ),
          ),
          const SizedBox(width: 18),
          // User Info + Edit Button
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Melissa Cooper',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF4C260B),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'melissa@booki.com',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFF99582a),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 12),
                // Edit Profile Button
                Align(
                  alignment: Alignment.center,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditProfileScreen(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF99582a),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Edit Profile',
                      style: TextStyle(
                        color: Color.fromARGB(208, 255, 242, 226),
                        fontWeight: FontWeight.w800,
                        fontSize: 16,
                      ),
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

  Widget _buildMenuOptions() {
    final menuItems = [
      {
        'title': 'Cart History',
        'icon': Icons.history,
        'onTap': () {
          // Navigate to cart history
          print('Navigate to Cart History');
        },
      },
      {
        'title': 'Languages',
        'icon': Icons.language,
        'onTap': () {
          // Navigate to Languages
          print('Navigate to Languages');
        },
      },
      {
        'title': 'Coupons',
        'icon': Icons.local_offer,
        'onTap': () {
          // Navigate to coupons
          print('Navigate to Coupons');
        },
      },
      {
        'title': 'Logout',
        'icon': Icons.logout,
        'onTap': () {
          _showLogoutDialog();
        },
      },
    ];

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: menuItems.map((item) {
          return Container(
            margin: const EdgeInsets.only(bottom: 15),
            decoration: BoxDecoration(
              color: Color.fromARGB(195, 239, 221, 184),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: const Color.fromARGB(138, 76, 38, 11),
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: Color(0xFF4C260B).withOpacity(0.08),
                  spreadRadius: 1,
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: ListTile( // A widget that makes it easy to build rows in a list like in settings menus
              onTap: item['onTap'] as VoidCallback,
              leading: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: item['title'] == 'Logout'
                      ? const Color.fromARGB(154, 244, 67, 54).withOpacity(0.1)
                      : Color(0xFF99582a).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  item['icon'] as IconData,
                  color: item['title'] == 'Logout'
                      ? const Color.fromARGB(212, 229, 56, 53)
                      : Color(0xFF99582a),
                  size: 22,
                ),
              ),
              title: Text(
                item['title'] as String,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: item['title'] == 'Logout'
                      ? Colors.red.shade600
                      : Color(0xFF4C260B),
                ),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: item['title'] == 'Logout'
                    ? Colors.red.shade600
                    : Color(0xFF99582a).withOpacity(0.6),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color.fromARGB(252, 239, 221, 184),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          title: Text(
            'Logout',
            style: TextStyle(
              color: Color(0xFF4C260B),
              fontWeight: FontWeight.w800,
            ),
          ),
          content: Text(
            'Are you sure you want to logout?',
            style: TextStyle(
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
                // Navigate to login screen
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF99582a),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                'Logout',
                style: TextStyle(
                  color: Color.fromARGB(208, 255, 242, 226),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        );
      },
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
