// ignore_for_file: library_private_types_in_public_api, deprecated_member_use

import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _showPassword = false;

  void _handleLogin() {
    final email = _emailController.text;
    final password = _passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please Fill all the Fields'),
          backgroundColor: Color(0xFF99582a),
        ),
      );
      return;
    }

    final emailRegex = RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$');
    if (!emailRegex.hasMatch(email)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Invalid Email Format'),
          backgroundColor: Color(0xFF99582a),
        ),
      );
      return;
    }

    if (email == 'test@barchadills.com' && password == '123456') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Login Done Successfully! Welcome to Booki'),
          backgroundColor: Color.fromARGB(255, 113, 168, 136),
        ),
      );
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Email ou password Incorrect'),
          backgroundColor: Color(0xFF99582a),
        ),
      );
    }
  }

  void _toggleShowPassword() {
    setState(() {
      _showPassword = !_showPassword;
    });
  }

  void _navigateToRegister() {
    Navigator.pushNamed(context, '/register');
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFFDF0D5),
              Color(0xFFf2cc8f),
              Color.fromARGB(255, 205, 125, 68),
            ],
          ),
        ),
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: width * 0.08),
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: IntrinsicHeight(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
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
                          'Your gateway to the best book offers',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                            fontFamily: 'RobotoLight',
                            fontWeight: FontWeight.w900,
                            color: Color.fromARGB(255, 76, 38, 11),
                          ),
                        ),
                        const SizedBox(height: 32),
                        _buildLoginCard(width),
                        _buildRegisterLink(),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildLoginCard(double width) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(35),
      margin: const EdgeInsets.only(bottom: 24),
      decoration: BoxDecoration(
        color: const Color.fromARGB(192, 253, 240, 213),
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
              'Sign In',
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Color(0xFF99582a),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Center(
            child: const Text(
              'Login to Discover our Best Book Offres',
              style: TextStyle(
                fontSize: 17,
                fontFamily: 'RobotoLight',
                fontWeight: FontWeight.w900,
                color: Color.fromARGB(255, 76, 38, 11),
              ),
            ),
          ),
          const SizedBox(height: 32),
          _buildEmailField(),
          const SizedBox(height: 20),
          _buildPasswordField(),
          const SizedBox(height: 32),
          _buildLoginButton(width),
        ],
      ),
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
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
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
            fontSize: 18,
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
            ),
            suffixIcon: IconButton(
              icon: Icon(
                _showPassword ? Icons.visibility : Icons.visibility_off,
                color: const Color.fromARGB(255, 177, 140, 81),
              ),
              onPressed: _toggleShowPassword,
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
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

  Widget _buildLoginButton(double width) {
    return SizedBox(
      width: double.infinity,
      height: 60,
      child: ElevatedButton(
        onPressed: _handleLogin,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF99582a),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              'Login',
              style: TextStyle(
                fontSize: 25,
                color: Color.fromARGB(208, 255, 242, 226),
                fontFamily: 'RobotoLight',
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(width: 8),
            Icon(
              Icons.arrow_forward,
              color: Color.fromARGB(208, 255, 242, 226),
              size: 20,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRegisterLink() {
    return GestureDetector(
      onTap: _navigateToRegister,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              'Don\'t have an account? ',
              style: TextStyle(
                fontSize: 18,
                fontFamily: 'RobotoLight',
                fontWeight: FontWeight.w900,
                color: Color.fromARGB(212, 253, 240, 213),
              ),
            ),
            Text(
              'Register',
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

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
