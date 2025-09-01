// ignore_for_file: use_super_parameters, deprecated_member_use, sort_child_properties_last, sized_box_for_whitespace, avoid_returning_null_for_void, avoid_print, unused_import, unnecessary_import

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Screens of the bottom Navigation
import 'package:booki/screens/home_screen.dart';
import 'package:booki/screens/catagory_screen.dart';
import 'package:booki/screens/cart_screen.dart';
import 'package:booki/screens/profile_screen.dart';

class AddBookScreen extends StatefulWidget {
  const AddBookScreen({Key? key}) : super(key: key);

  @override
  State<AddBookScreen> createState() => _AddBookScreenState();
}

class _AddBookScreenState extends State<AddBookScreen>
    with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _bookNameController = TextEditingController();
  final _authorController = TextEditingController();
  final _priceController = TextEditingController();
  final _descriptionController = TextEditingController();

  String? _selectedImagePath;
  bool _isSubmitting = false;

  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;
  int _selectedIndex = 2; // Add Book tab selected

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _fadeController, curve: Curves.easeOut));
    _fadeController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _bookNameController.dispose();
    _authorController.dispose();
    _priceController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _pickImage() {
    setState(() {
      _selectedImagePath =
          'assets/images/placeholderBook.jpeg'; // Book Cover Placeholder Image
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Image selected!',
          style: TextStyle(
            color: Color.fromARGB(208, 255, 242, 226),
            fontSize: 20,
          ),
        ),
        backgroundColor: Color(0xFF99582a),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isSubmitting = true);
      await Future.delayed(Duration(seconds: 4));
      setState(() => _isSubmitting = false);
      _showSuccessDialog();
    }
  }

  void _showSuccessDialog() {
    // Book Added Successfully Alert
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        backgroundColor: Color.fromARGB(255, 239, 221, 184),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: Color(0xFF99582a),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.check,
                color: Color.fromARGB(255, 239, 221, 184),
                size: 40,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Book Added Successfully!',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF4C260B),
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            Text(
              'Your book "${_bookNameController.text}" has been submitted for review.',
              style: TextStyle(fontSize: 14, color: Color(0xFF99582a)),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        actions: [
          // "Add another book" Button
          Container(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                _resetForm();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF99582a),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: EdgeInsets.symmetric(vertical: 12),
              ),
              child: Text(
                'Add Another Book',
                style: TextStyle(
                  color: Color.fromARGB(170, 255, 242, 226),
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _resetForm() {
    _formKey.currentState!.reset();
    _bookNameController.clear();
    _authorController.clear();
    _priceController.clear();
    _descriptionController.clear();
    setState(() => _selectedImagePath = null);
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
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: Column(
              children: [
                _buildHeaderSection(),
                _buildForm(),
                const SizedBox(height: 60),
              ],
            ),
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
          image: const AssetImage('assets/images/addHeaderImage.png'),
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
          opacity: _fadeAnimation,
          child: Center(
            child: Text(
              'Sell your Book',
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

  Widget _buildForm() {
    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Color(0xFFFDF0D5),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(255, 231, 172, 78).withOpacity(0.1),
            blurRadius: 20,
            spreadRadius: 5,
          ),
        ],
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Book cover Image Section
            _buildImageUploadSection(),

            SizedBox(height: 24),

            // Book Title Field
            _buildTextField(
              controller: _bookNameController,
              label: 'Book Title',
              hint: 'Book Title',
              icon: Icons.book,
              validator: (v) => v == null || v.isEmpty
                  ? 'Please enter book title'
                  : v.length < 2
                  ? 'Title must be at least 2 characters'
                  : null,
            ),

            SizedBox(height: 20),

            // Author name field
            _buildTextField(
              controller: _authorController,
              label: 'Author Name',
              hint: 'Author Name',
              icon: Icons.person,
              validator: (v) =>
                  v == null || v.isEmpty ? 'Please enter author name' : null,
            ),

            SizedBox(height: 20),

            // Price Field
            _buildTextField(
              controller: _priceController,
              label: 'Price (DT)',
              hint: 'Enter the Initial Price',
              icon: Icons.attach_money,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              validator: (v) {
                final price = double.tryParse(v ?? '');
                return (v == null || v.isEmpty)
                    ? 'Please enter price'
                    : (price == null || price <= 0)
                    ? 'Please enter a valid price'
                    : null;
              },
            ),

            SizedBox(height: 20),

            // Description Field
            _buildTextField(
              controller: _descriptionController,
              label: 'Description',
              hint: 'Tell us about your book...',
              icon: Icons.description,
              maxLines: 4,
              validator: (v) => v == null || v.isEmpty
                  ? 'Please enter book description'
                  : v.length < 10
                  ? 'Description must be at least 10 characters'
                  : null,
            ),

            SizedBox(height: 30),

            // Submit Button
            _buildSubmitButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildImageUploadSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Book Cover Image',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w900,
            color: Color(0xFF4C260B),
          ),
        ),
        SizedBox(height: 12),
        GestureDetector(
          onTap: _pickImage,
          child: Container(
            width: double.infinity,
            height: 200,
            decoration: BoxDecoration(
              color: Color(0xFF99582a).withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: Color(0xFF4C260B).withOpacity(0.3),
                width: 2,
              ),
            ),
            child: _selectedImagePath == null
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Color(0xFF99582a),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.cloud_upload,
                          color: const Color.fromARGB(195, 255, 255, 255),
                          size: 40,
                        ),
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Tap to upload book cover',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF99582a),
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'JPG, PNG up to 10MB',
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF99582a).withOpacity(0.7),
                        ),
                      ),
                    ],
                  )
                : Stack(
                    children: [
                      Container(
                        width: double.infinity,
                        height: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          image: DecorationImage(
                            image: AssetImage(_selectedImagePath!),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),

                      // The Edit Icon
                      Positioned(
                        top: 8,
                        right: 8,
                        child: Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Color(0xFF4C260B),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.edit,
                            color: Color.fromARGB(195, 255, 255, 255),
                            size: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ],
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    int maxLines = 1,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w900,
            color: Color(0xFF4C260B),
          ),
        ),
        SizedBox(height: 8),
        TextFormField(
          controller: controller,
          maxLines: maxLines,
          keyboardType: keyboardType,
          validator: validator,
          style: TextStyle(color: Color(0xFF4C260B), fontSize: 16),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: Color(0xFF99582a).withOpacity(0.6)),
            prefixIcon: Icon(icon, color: Color(0xFF99582a)),
            filled: true,
            fillColor: const Color.fromARGB(214, 239, 221, 184),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: Color.fromARGB(201, 231, 111, 81),
                width: 0.8,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: Color.fromARGB(255, 76, 38, 11),
                width: 2,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: const Color.fromARGB(255, 112, 7, 5),
                width: 1.5,
              ),
            ),
            errorStyle: TextStyle(
              color: const Color.fromARGB(255, 112, 7, 5), // Error text color
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: 16,
              vertical: maxLines > 1 ? 16 : 14,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSubmitButton() {
    return Container(
      width: double.infinity,
      height: 56,
      decoration: BoxDecoration(
        color: Color(0xFF99582a),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Color(0xFF4C260B).withOpacity(0.3),
            spreadRadius: 0,
            blurRadius: 12,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: _isSubmitting ? null : _submitForm,
          child: Center(
            child: _isSubmitting
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          color: Color.fromARGB(170, 255, 242, 226),
                          strokeWidth: 2,
                        ),
                      ),
                      SizedBox(width: 12),
                      Text(
                        'Submitting...',
                        style: TextStyle(
                          color: Color.fromARGB(170, 255, 242, 226),
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  )
                : Text(
                    'Sell My Book',
                    style: TextStyle(
                      color: Color.fromARGB(170, 255, 242, 226),
                      fontWeight: FontWeight.w800,
                      fontSize: 18,
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
