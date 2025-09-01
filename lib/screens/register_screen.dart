// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously, deprecated_member_use

import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  // Text Fields Controllers
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  // Control the Visibility of the passwords
  bool _showPassword = false;
  bool _showConfirmPassword = false;

  // Accept the terms variable
  bool _acceptTerms = false;

  // Manage the Sign Up
  void _handleRegister() {
    // Get the text fields values
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text;
    final confirmPassword = _confirmPasswordController.text;

    if (name.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty) {
      _showSnackBar('Please Fill all the Fields!', false);
      return;
    }

    // Username Length Validation
    if (name.length < 2) {
      _showSnackBar('The Username must contain at least 2 characters', false);
      return;
    }

    // Email format with regex Validation
    final emailRegex = RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$');
    if (!emailRegex.hasMatch(email)) {
      _showSnackBar('Invalid Email Format', false);
      return;
    }

    // Password Length Validation
    if (password.length < 6) {
      _showSnackBar('The Password mush contain at least 6 characters', false);
      return;
    }

    // Matching passwords validation
    if (password != confirmPassword) {
      _showSnackBar('Passwords do not match', false);
      return;
    }

    // Accepting the terms verification
    if (!_acceptTerms) {
      _showSnackBar('Accepting the terms is required', false);
      return;
    }

    // If all is valid, We pass to the login
    _showSnackBar('Account saved successfully! Welcome to BOOKI', true);

    // Delay Simulation + Redirection to the Login Page
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacementNamed(context, '/login');
    });
  }

  void _handleGoogleSignUp() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Google Sign Up',
          style: TextStyle(
            color: Color.fromARGB(208, 255, 242, 226),
            fontSize: 20,
          ),
        ),
        backgroundColor: Color(0xFF99582a),
      ),
    );
  }

  void _handleFacebookSignUp() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Facebook Sign Up',
          style: TextStyle(
            color: Color.fromARGB(208, 255, 242, 226),
            fontSize: 20,
          ),
        ),
        backgroundColor: Color(0xFF99582a),
      ),
    );
  }

  // Function to show the SnackBars under the conditions
  void _showSnackBar(String message, bool isSuccess) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(
            color: Color.fromARGB(208, 255, 242, 226),
            fontSize: 20,
          ),
        ),
        backgroundColor: isSuccess
            ? const Color.fromARGB(255, 113, 168, 136)
            : const Color(0xFF99582a),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  // Toggle the Password Visibility
  void _toggleShowPassword() {
    setState(() {
      _showPassword = !_showPassword;
    });
  }

  // Toggle the confirm password Visibility
  void _toggleShowConfirmPassword() {
    setState(() {
      _showConfirmPassword = !_showConfirmPassword;
    });
  }

  // Login Redirection
  void _navigateToLogin() {
    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    // Window Dimensions
    final size = MediaQuery.of(context).size;
    final width = size.width;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.fromARGB(255, 205, 125, 68),
              Color(0xFFf2cc8f),
              Color(0xFFFDF0D5),
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: width * 0.08),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      'assets/images/BOOKI_Icon.png',
                      width: 24,
                      height: 80,
                    ),

                    const Text(
                      'BO',
                      style: TextStyle(
                        fontSize: 70,
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
                        fontSize: 70,
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
                        fontSize: 70,
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

                const SizedBox(height: 4),
                const Text(
                  'Your Gateway to the Best Book Offers',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'RobotoLight',
                    fontWeight: FontWeight.w900,
                    color: Color.fromARGB(255, 76, 38, 11),
                  ),
                ),
                const SizedBox(height: 32),
                _buildRegisterCard(width),
                _buildSocialLoginSection(),
                _buildLoginLink(),
                SizedBox(
                  height: MediaQuery.of(context).viewInsets.bottom > 0 ? 20 : 0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Register Card Widget
  Widget _buildRegisterCard(double width) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(25),
      margin: const EdgeInsets.only(bottom: 20, left: 0, right: 0),
      decoration: BoxDecoration(
        color: const Color.fromARGB(129, 253, 240, 213),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(255, 231, 172, 78).withOpacity(0.1),
            blurRadius: 20,
            spreadRadius: 5,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: const Text(
              'Sign Up',
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.w800,
                color: Color(0xFF99582a),
              ),
            ),
          ),
          const SizedBox(height: 24),

          _buildNameField(),

          const SizedBox(height: 18),

          _buildEmailField(),

          const SizedBox(height: 18),

          _buildPasswordField(),

          const SizedBox(height: 18),

          _buildConfirmPasswordField(),

          const SizedBox(height: 24),

          _buildTermsCheckbox(),

          const SizedBox(height: 24),

          _buildRegisterButton(width),
        ],
      ),
    );
  }

  Widget _buildNameField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Username',
          style: TextStyle(
            fontSize: 20,
            fontFamily: 'RobotoLight',
            fontWeight: FontWeight.w900,
            color: Colors.black87,
          ),
        ),

        const SizedBox(height: 6),

        TextField(
          controller: _nameController,
          decoration: InputDecoration(
            hintText: 'Username',
            hintStyle: const TextStyle(
              color: Colors.black87,
              fontSize: 18,
              fontFamily: 'RobotoLight',
              fontWeight: FontWeight.w900,
            ),
            filled: true,
            fillColor: const Color.fromARGB(195, 239, 221, 184),
            prefixIcon: const Icon(
              Icons.person_outline,
              color: Color.fromARGB(255, 177, 140, 81),
              size: 28,
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: Color.fromARGB(201, 231, 111, 81),
                width: 2,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: Color.fromARGB(255, 76, 38, 11),
                width: 2,
              ),
            ),
          ),
          textCapitalization: TextCapitalization.words,
        ),
      ],
    );
  }

  Widget _buildEmailField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Email',
          style: TextStyle(
            fontSize: 20,
            fontFamily: 'RobotoLight',
            fontWeight: FontWeight.w900,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: _emailController,
          decoration: InputDecoration(
            hintText: 'Email',
            hintStyle: const TextStyle(
              color: Colors.black87,
              fontSize: 18,
              fontFamily: 'RobotoLight',
              fontWeight: FontWeight.w900,
            ),
            filled: true,
            fillColor: const Color.fromARGB(195, 239, 221, 184),
            prefixIcon: const Icon(
              Icons.email_outlined,
              color: Color.fromARGB(255, 177, 140, 81),
              size: 28,
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
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
          keyboardType: TextInputType.emailAddress,
          autocorrect: false,
          textCapitalization: TextCapitalization.none,
        ),
      ],
    );
  }

  Widget _buildPasswordField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Password',
          style: TextStyle(
            color: Colors.black87,
            fontSize: 20,
            fontFamily: 'RobotoLight',
            fontWeight: FontWeight.w900,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: _passwordController,
          decoration: InputDecoration(
            hintText: 'Password',
            hintStyle: const TextStyle(
              color: Colors.black87,
              fontSize: 18,
              fontFamily: 'RobotoLight',
              fontWeight: FontWeight.w900,
            ),
            filled: true,
            fillColor: const Color.fromARGB(195, 239, 221, 184),
            prefixIcon: const Icon(
              Icons.lock_outline,
              color: Color.fromARGB(255, 177, 140, 81),
              size: 28,
            ),
            suffixIcon: IconButton(
              icon: Icon(
                _showPassword ? Icons.visibility_off : Icons.visibility,
                color: const Color.fromARGB(255, 177, 140, 81),
              ),
              onPressed: _toggleShowPassword,
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFFE8E8E8), width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: Color.fromARGB(255, 76, 38, 11),
                width: 2,
              ),
            ),
          ),
          obscureText: !_showPassword,
          autocorrect: false,
        ),
      ],
    );
  }

  Widget _buildConfirmPasswordField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Confirm Password',
          style: TextStyle(
            color: Colors.black87,
            fontSize: 20,
            fontFamily: 'RobotoLight',
            fontWeight: FontWeight.w900,
          ),
        ),

        const SizedBox(height: 6),

        TextField(
          controller: _confirmPasswordController,
          decoration: InputDecoration(
            hintText: 'Confirm Password',
            hintStyle: const TextStyle(
              color: Colors.black87,
              fontSize: 18,
              fontFamily: 'RobotoLight',
              fontWeight: FontWeight.w900,
            ),
            filled: true,
            fillColor: const Color.fromARGB(195, 239, 221, 184),
            prefixIcon: const Icon(
              Icons.lock_outline,
              color: Color.fromARGB(255, 177, 140, 81),
            ),
            // Bouton pour afficher/masquer le mot de passe
            suffixIcon: IconButton(
              icon: Icon(
                _showConfirmPassword ? Icons.visibility_off : Icons.visibility,
                color: const Color.fromARGB(255, 177, 140, 81),
              ),
              onPressed: _toggleShowConfirmPassword,
            ),
            // Padding interne du champ
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
            // Bordure normale
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFFE8E8E8), width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: Color.fromARGB(255, 76, 38, 11),
                width: 2,
              ),
            ),
          ),
          obscureText: !_showConfirmPassword,
          autocorrect: false,
        ),
      ],
    );
  }

  Widget _buildTermsCheckbox() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Personalized Checkbox
        SizedBox(
          width: 28,
          height: 28,
          child: Checkbox(
            value: _acceptTerms,
            onChanged: (value) {
              setState(() {
                _acceptTerms =
                    value ??
                    false; // ?? : If value is not null, assign it to _acceptTerms and if value is null, assign false
              });
            },
            activeColor: Color.fromARGB(255, 76, 38, 11),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ),

        const SizedBox(width: 8),

        // Terms Label
        Expanded(
          child: GestureDetector(
            onTap: () {
              setState(() {
                _acceptTerms = !_acceptTerms;
              });
            },
            child: const Text(
              'I agree to all our Terms, Privacy Policy and Cookies Policy',
              style: TextStyle(
                fontSize: 15,
                color: Color.fromARGB(255, 76, 38, 11),
                height: 1.3,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRegisterButton(double width) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: ElevatedButton(
        onPressed: _handleRegister,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF99582a),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 0,
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Create Account',
              style: TextStyle(
                fontSize: 23,
                color: Color.fromARGB(208, 255, 242, 226),
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSocialLoginSection() {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      child: Column(
        children: [
          // "Or" divider
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 1,
                  color: const Color.fromARGB(150, 76, 38, 11),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'Or',
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'RobotoLight',
                    fontWeight: FontWeight.w900,
                    color: Color.fromARGB(255, 76, 38, 11),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  height: 1,
                  color: const Color.fromARGB(150, 76, 38, 11),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Social login text
          const Text(
            'Sign Up with Google or Facebook',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              fontFamily: 'RobotoLight',
              fontWeight: FontWeight.w900,
              color: Color.fromARGB(255, 76, 38, 11),
            ),
          ),
          const SizedBox(height: 20),

          // Social login buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Google button
              Container(
                margin: const EdgeInsets.only(right: 12),
                child: ElevatedButton(
                  onPressed: _handleGoogleSignUp,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(195, 239, 221, 184),
                    foregroundColor: const Color(0xFF99582a),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                      side: const BorderSide(
                        color: Color.fromARGB(255, 177, 140, 81),
                        width: 1,
                      ),
                    ),
                    elevation: 0,
                    padding: const EdgeInsets.all(16),
                    minimumSize: const Size(60, 60),
                  ),
                  child: const Icon(
                    Icons.g_mobiledata_rounded,
                    size: 32,
                    color: Color(0xFF99582a),
                  ),
                ),
              ),

              // Facebook button
              Container(
                margin: const EdgeInsets.only(left: 12),
                child: ElevatedButton(
                  onPressed: _handleFacebookSignUp,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(195, 239, 221, 184),
                    foregroundColor: const Color(0xFF99582a),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                      side: const BorderSide(
                        color: Color.fromARGB(255, 177, 140, 81),
                        width: 1,
                      ),
                    ),
                    elevation: 0,
                    padding: const EdgeInsets.all(16),
                    minimumSize: const Size(60, 60),
                  ),
                  child: const Icon(
                    Icons.facebook,
                    size: 32,
                    color: Color(0xFF99582a),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLoginLink() {
    return GestureDetector(
      onTap: _navigateToLogin,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Already have an account? ',
              style: TextStyle(
                fontSize: 18,
                fontFamily: 'RobotoLight',
                fontWeight: FontWeight.w900,
                color: Color.fromARGB(255, 177, 140, 81),
              ),
            ),
            Text(
              'Sign In',
              style: TextStyle(
                fontSize: 18,
                fontFamily: 'RobotoLight',
                fontWeight: FontWeight.w900,
                color: Color.fromARGB(255, 76, 38, 11),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Cleanup Function
  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
}
