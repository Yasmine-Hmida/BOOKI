// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'profile_screen.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDF0D5),
      // The "<- Edit Profile" in the top
      appBar: AppBar(
        backgroundColor: const Color(0xFFFDF0D5),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF4C260B)),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Edit Profile',
          style: TextStyle(
            color: Color(0xFF4C260B),
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            const SizedBox(height: 45),

            // Profile Picture + Edit Profile Image Icon
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                Container(
                  width: 150,
                  height: 150,
                  padding: const EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    color: const Color(0xFF4C260B),
                    shape: BoxShape.circle,
                  ),
                  child: CircleAvatar(
                    radius: 60,
                    backgroundColor: const Color(0xFF99582a).withOpacity(0.2),
                    child: ClipOval(
                      child: Image.asset(
                        'assets/images/profileImage.jpeg',
                        width: 150,
                        height: 150,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            const Icon(
                              Icons.person,
                              size: 60,
                              color: Color(0xFF99582a),
                            ),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    color: const Color(0xFF99582a),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: const Color.fromARGB(210, 76, 38, 11),
                      width: 1.5,
                    ),
                  ),
                  child: IconButton(
                    icon: const Icon(
                      Icons.edit,
                      size: 20,
                      color: Color.fromARGB(196, 255, 255, 255),
                    ),
                    onPressed: () {
                      // Change profile image function
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 90),
            // Name Field
            _buildTextField(
              'Name',
              'Melissa Cooper',
              prefixIcon: Icons.person,
              keyboardType: TextInputType.name,
            ),
            const SizedBox(height: 20),
            // Email Field
            _buildTextField(
              'Email Address',
              'melissa@booki.com',
              prefixIcon: Icons.email_outlined,
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 40),
            // Update Profile Button
            SizedBox(
              width: double.infinity,
              height: 58,
              child: ElevatedButton(
                onPressed: () {
                  // Navigate to ProfileScreen
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ProfileScreen(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF99582a),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Update Profile',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                    color: Color.fromARGB(170, 255, 242, 226),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(
    String label,
    String hint, {
    Widget? suffixIcon,
    IconData? prefixIcon,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 20,
            fontFamily: 'RobotoLight',
            fontWeight: FontWeight.w900,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 6),
        TextField(
          keyboardType: keyboardType,
          autocorrect: false,
          textCapitalization: TextCapitalization.none,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(
              color: Colors.black87,
              fontSize: 18,
              fontFamily: 'RobotoLight',
              fontWeight: FontWeight.w900,
            ),
            filled: true,
            fillColor: const Color.fromARGB(195, 239, 221, 184),
            suffixIcon: suffixIcon,
            prefixIcon: prefixIcon != null
                ? Icon(
                    prefixIcon,
                    color: const Color.fromARGB(255, 177, 140, 81),
                  )
                : null,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 18,
              vertical: 18,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: Color.fromARGB(201, 231, 111, 81),
                width: 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: Color.fromARGB(255, 76, 38, 11),
                width: 2,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
