// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously, deprecated_member_use

import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  // Contrôleurs pour tous les champs de saisie
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  // Variables pour contrôler la visibilité des mots de passe
  bool _showPassword = false;
  bool _showConfirmPassword = false;

  // Variable pour l'acceptation des conditions d'utilisation
  bool _acceptTerms = false;

  // Méthode pour gérer l'inscription utilisateur
  void _handleRegister() {
    // Récupération des valeurs saisies
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final phone = _phoneController.text.trim();
    final password = _passwordController.text;
    final confirmPassword = _confirmPasswordController.text;

    // Vérification que tous les champs obligatoires sont remplis
    if (name.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty) {
      _showSnackBar('Please Fill all the Fields!', false);
      return;
    }

    // Validation de la longueur du nom
    if (name.length < 2) {
      _showSnackBar('The Username must contain at least 2 characters', false);
      return;
    }

    // Validation du format email avec regex
    final emailRegex = RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$');
    if (!emailRegex.hasMatch(email)) {
      _showSnackBar('Invalid Email Format', false);
      return;
    }

    // Validation du numéro de téléphone (optionnel mais si rempli, doit être valide)
    if (phone.isNotEmpty) {
      final phoneRegex = RegExp(r'^\+?[0-9]{8,15}$');
      if (!phoneRegex.hasMatch(phone)) {
        _showSnackBar('Invalid Phone Number', false);
        return;
      }
    }

    // Validation de la longueur du mot de passe
    if (password.length < 6) {
      _showSnackBar('The Password mush contain at least 6 characters', false);
      return;
    }

    // Vérification que les mots de passe correspondent
    if (password != confirmPassword) {
      _showSnackBar('Passwords do not match', false);
      return;
    }

    // Vérification de l'acceptation des conditions
    if (!_acceptTerms) {
      _showSnackBar('Accepting the terms is required', false);
      return;
    }

    // Si toutes les validations passent, inscription réussie
    _showSnackBar('Account saved successfully! Welcome to BOOKI', true);

    // Simulation d'un délai puis navigation vers l'écran de connexion
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacementNamed(context, '/login');
    });
  }

  // Méthode utilitaire pour afficher les messages
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

  // Méthode pour basculer la visibilité du mot de passe
  void _toggleShowPassword() {
    setState(() {
      _showPassword = !_showPassword;
    });
  }

  // Méthode pour basculer la visibilité de la confirmation du mot de passe
  void _toggleShowConfirmPassword() {
    setState(() {
      _showConfirmPassword = !_showConfirmPassword;
    });
  }

  // Navigation vers l'écran de connexion
  void _navigateToLogin() {
    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    // Récupération des dimensions de l'écran
    final size = MediaQuery.of(context).size;
    final width = size.width;

    return Scaffold(
      // Couleur de fond avec dégradé identique au login
      body: Container(
        width: double.infinity,
        height: double.infinity,
        // Même dégradé que l'écran de connexion
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

                        _buildRegisterCard(width),

                        _buildLoginLink(),
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

  // Construction de la carte d'inscription
  Widget _buildRegisterCard(double width) {
    return Container(
      width: double.infinity,
      // Padding interne de la carte
      padding: const EdgeInsets.all(30),
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: const Color.fromARGB(192, 253, 240, 213),
        borderRadius: BorderRadius.circular(15),
        // Ombre portée pour la carte
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
          // Titre de la section inscription
          Center(
            child: const Text(
              'Sign Up',
              style: TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.bold,
                color: Color(0xFF99582a),
              ),
            ),
          ),

          const SizedBox(height: 6),

          // Message d'accueil
          Center(
            child: const Text(
              'Create your account to benefit from our offres',
              style: TextStyle(
                fontSize: 15,
                fontFamily: 'RobotoLight',
                fontWeight: FontWeight.w900,
                color: Color.fromARGB(255, 76, 38, 11),
              ),
            ),
          ),

          const SizedBox(height: 24),

          // Champ nom complet
          _buildNameField(),

          const SizedBox(height: 18),

          // Champ email
          _buildEmailField(),

          const SizedBox(height: 18),

          // Champ mot de passe
          _buildPasswordField(),

          const SizedBox(height: 18),

          // Champ confirmation mot de passe
          _buildConfirmPasswordField(),

          const SizedBox(height: 20),

          // Case à cocher pour les conditions
          _buildTermsCheckbox(),

          const SizedBox(height: 24),

          // Bouton d'inscription
          _buildRegisterButton(width),
        ],
      ),
    );
  }

  // Construction du champ nom complet
  Widget _buildNameField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label du champ
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

        // Champ de saisie nom
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

            // Icône personne à gauche
            prefixIcon: const Icon(
              Icons.person_outline,
              color: Color.fromARGB(255, 177, 140, 81),
              size: 28,
            ),
            // Padding interne du champ réduit
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
            // Bordure normale
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: Color.fromARGB(201, 231, 111, 81),
                width: 2,
              ),
            ),
            // Bordure en focus
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

  // Construction du champ email
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

  // Construction du champ mot de passe
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
              size: 28,
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

  // Construction du champ confirmation mot de passe
  Widget _buildConfirmPasswordField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label du champ
        const Text(
          'Confirm Password',
          style: TextStyle(
            color: Colors.black87,
            fontSize: 18,
            fontFamily: 'RobotoLight',
            fontWeight: FontWeight.w900,
          ),
        ),

        const SizedBox(height: 6),

        // Champ de confirmation mot de passe
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
                _showPassword ? Icons.visibility : Icons.visibility_off,
                color: const Color.fromARGB(255, 177, 140, 81),
              ),
              onPressed: _toggleShowConfirmPassword,
            ),
            // Padding interne du champ
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
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

  // Construction de la case à cocher pour les conditions
  Widget _buildTermsCheckbox() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Case à cocher personnalisée
        SizedBox(
          width: 28,
          height: 28,
          child: Checkbox(
            value: _acceptTerms,
            onChanged: (value) {
              setState(() {
                _acceptTerms = value ?? false;
              });
            },
            activeColor: Color.fromARGB(255, 76, 38, 11),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ),

        const SizedBox(width: 8),

        // Texte des conditions
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

  // Construction du bouton d'inscription
  Widget _buildRegisterButton(double width) {
    return SizedBox(
      width: double.infinity,
      height: 60,
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
            // Texte du bouton
            Text(
              'Create Account',
              style: TextStyle(
                fontSize: 23,
                color: Color.fromARGB(208, 255, 242, 226),
                fontFamily: 'RobotoLight',
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Construction du lien de connexion
  Widget _buildLoginLink() {
    return GestureDetector(
      onTap: _navigateToLogin,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Texte normal
            Text(
              'Already have an account? ',
              style: TextStyle(
                fontSize: 18,
                fontFamily: 'RobotoLight',
                fontWeight: FontWeight.w900,
                color: Color.fromARGB(255, 177, 140, 81),
              ),
            ),
            // Texte cliquable pour la connexion
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

  // Nettoyage des ressources lors de la destruction du widget
  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
}
