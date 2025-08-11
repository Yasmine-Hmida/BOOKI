import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Contrôleurs pour les champs de texte email et mot de passe
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Variable pour contrôler la visibilité du mot de passe
  bool _showPassword = false;

  // Méthode pour gérer la connexion utilisateur
  void _handleLogin() {
    // Récupération des valeurs saisies
    final email = _emailController.text;
    final password = _passwordController.text;

    // Vérification que les champs ne sont pas vides
    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Veuillez remplir tous les champs'),
          backgroundColor: Color(0xFFE74C3C),
        ),
      );
      return;
    }

    // Validation du format email avec regex
    final emailRegex = RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$');
    if (!emailRegex.hasMatch(email)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Format email invalide'),
          backgroundColor: Color(0xFFE74C3C),
        ),
      );
      return;
    }

    // Vérification des identifiants (test simple)
    if (email == 'test@barchadills.com' && password == '123456') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Connexion réussie! Bienvenue sur BarchaDills 🛍️'),
          backgroundColor: Color(0xFF27AE60),
        ),
      );
      // Navigation vers l'écran d'accueil
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Email ou mot de passe incorrect'),
          backgroundColor: Color(0xFFE74C3C),
        ),
      );
    }
  }
 
  // Méthode pour basculer la visibilité du mot de passe
  void _toggleShowPassword() {
    setState(() {
      _showPassword = !_showPassword;
    });
  }

  // Navigation vers l'écran d'inscription
  void _navigateToRegister() {
    Navigator.pushNamed(context, '/register');
  }

  @override
  Widget build(BuildContext context) {
    // Récupération des dimensions de l'écran
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    return Scaffold(
      // Couleur de fond dégradée
      body: Container(
        width: double.infinity,
        height: double.infinity,
        // Dégradé de fond avec les couleurs du thème shopping
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFFF6B6B), // Rose corail
              Color(0xFFFF8E8E), // Rose plus clair
              Color(0xFFFFB8B8), // Rose très clair
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            // Padding global pour l'écran
            padding: EdgeInsets.symmetric(horizontal: width * 0.08),
            child: Column(
              children: [
                // Section du haut avec logo et titre
                _buildHeader(height),
               
                // Section du formulaire avec carte blanche
                _buildLoginCard(width),
               
                // Lien vers l'inscription
                _buildRegisterLink(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Construction de l'en-tête avec logo et titre
  Widget _buildHeader(double height) {
    return Container(
      // Espacement vertical adaptatif
      padding: EdgeInsets.symmetric(vertical: height * 0.06),
      child: Column(
        children: [
          // Logo de l'application (icône shopping bag)
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              // Ombre portée pour le logo
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 20,
                  spreadRadius: 5,
                ),
              ],
            ),
            child: const Icon(
              Icons.shopping_bag,
              size: 60,
              color: Color(0xFFFF6B6B),
            ),
          ),
         
          const SizedBox(height: 24),
         
          // Titre de l'application
          const Text(
            'BarchaDills',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              letterSpacing: 1.2,
            ),
          ),
         
          const SizedBox(height: 8),
         
          // Sous-titre
          const Text(
            'Votre destination shopping',
            style: TextStyle(
              fontSize: 16,
              color: Colors.white70,
              fontWeight: FontWeight.w300,
            ),
          ),
        ],
      ),
    );
  }

  // Construction de la carte de connexion
  Widget _buildLoginCard(double width) {
    return Container(
      width: double.infinity,
      // Padding interne de la carte
      padding: const EdgeInsets.all(32),
      margin: const EdgeInsets.only(bottom: 24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        // Ombre portée pour la carte
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            spreadRadius: 5,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Titre de la section connexion
          const Text(
            'Connexion',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2C3E50),
            ),
          ),
         
          const SizedBox(height: 8),
         
          // Message d'accueil
          const Text(
            'Connectez-vous pour découvrir nos meilleures offres',
            style: TextStyle(
              fontSize: 14,
              color: Color(0xFF7F8C8D),
            ),
          ),
         
          const SizedBox(height: 32),
         
          // Champ email
          _buildEmailField(),
         
          const SizedBox(height: 20),
         
          // Champ mot de passe
          _buildPasswordField(),
         
          const SizedBox(height: 32),
         
          // Bouton de connexion
          _buildLoginButton(width),
        ],
      ),
    );
  }

  // Construction du champ email
  Widget _buildEmailField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label du champ
        const Text(
          'Email',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Color(0xFF2C3E50),
          ),
        ),
       
        const SizedBox(height: 8),
       
        // Champ de saisie email
        TextField(
          controller: _emailController,
          decoration: InputDecoration(
            hintText: 'Entrez votre email',
            hintStyle: const TextStyle(color: Color(0xFFBDC3C7)),
            filled: true,
            fillColor: const Color(0xFFF8F9FA),
            // Icône email à gauche
            prefixIcon: const Icon(
              Icons.email_outlined,
              color: Color(0xFFFF6B6B),
            ),
            // Padding interne du champ
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
            // Bordure normale
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: Color(0xFFE8E8E8),
                width: 1,
              ),
            ),
            // Bordure en focus
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: Color(0xFFFF6B6B),
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
        // Label du champ
        const Text(
          'Mot de passe',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Color(0xFF2C3E50),
          ),
        ),
       
        const SizedBox(height: 8),
       
        // Champ de saisie mot de passe
        TextField(
          controller: _passwordController,
          decoration: InputDecoration(
            hintText: 'Entrez votre mot de passe',
            hintStyle: const TextStyle(color: Color(0xFFBDC3C7)),
            filled: true,
            fillColor: const Color(0xFFF8F9FA),
            // Icône cadenas à gauche
            prefixIcon: const Icon(
              Icons.lock_outline,
              color: Color(0xFFFF6B6B),
            ),
            // Bouton pour afficher/masquer le mot de passe
            suffixIcon: IconButton(
              icon: Icon(
                _showPassword ? Icons.visibility : Icons.visibility_off,
                color: const Color(0xFFBDC3C7),
              ),
              onPressed: _toggleShowPassword,
            ),
            // Padding interne du champ
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
            // Bordure normale
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: Color(0xFFE8E8E8),
                width: 1,
              ),
            ),
            // Bordure en focus
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: Color(0xFFFF6B6B),
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

  // Construction du bouton de connexion
  Widget _buildLoginButton(double width) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: _handleLogin,
        style: ElevatedButton.styleFrom(
          // Couleur de fond du bouton
          backgroundColor: const Color(0xFFFF6B6B),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Texte du bouton
            const Text(
              'Se connecter',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
           
            const SizedBox(width: 8),
           
            // Icône flèche
            const Icon(
              Icons.arrow_forward,
              color: Colors.white,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }

  // Construction du lien d'inscription
  Widget _buildRegisterLink() {
    return GestureDetector(
      onTap: _navigateToRegister,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Texte normal
            const Text(
              'Pas encore de compte? ',
              style: TextStyle(
                fontSize: 14,
                color: Colors.white70,
              ),
            ),
            // Texte cliquable pour l'inscription
            const Text(
              'Créer un compte',
              style: TextStyle(
                fontSize: 14,
                color: Colors.white,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline,
                decorationColor: Colors.white,
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
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}