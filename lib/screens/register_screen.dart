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
  final TextEditingController _confirmPasswordController = TextEditingController();

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
    if (name.isEmpty || email.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
      _showSnackBar('Veuillez remplir tous les champs obligatoires', false);
      return;
    }

    // Validation de la longueur du nom
    if (name.length < 2) {
      _showSnackBar('Le nom doit contenir au moins 2 caractères', false);
      return;
    }

    // Validation du format email avec regex
    final emailRegex = RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$');
    if (!emailRegex.hasMatch(email)) {
      _showSnackBar('Format email invalide', false);
      return;
    }

    // Validation du numéro de téléphone (optionnel mais si rempli, doit être valide)
    if (phone.isNotEmpty) {
      final phoneRegex = RegExp(r'^\+?[0-9]{8,15}$');
      if (!phoneRegex.hasMatch(phone)) {
        _showSnackBar('Format de téléphone invalide', false);
        return;
      }
    }

    // Validation de la longueur du mot de passe
    if (password.length < 6) {
      _showSnackBar('Le mot de passe doit contenir au moins 6 caractères', false);
      return;
    }

    // Vérification que les mots de passe correspondent
    if (password != confirmPassword) {
      _showSnackBar('Les mots de passe ne correspondent pas', false);
      return;
    }

    // Vérification de l'acceptation des conditions
    if (!_acceptTerms) {
      _showSnackBar('Veuillez accepter les conditions d\'utilisation', false);
      return;
    }

    // Si toutes les validations passent, inscription réussie
    _showSnackBar('Inscription réussie! Bienvenue sur BarchaDills 🎉', true);
   
    // Simulation d'un délai puis navigation vers l'écran de connexion
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacementNamed(context, '/login');
    });
  }

  // Méthode utilitaire pour afficher les messages
  void _showSnackBar(String message, bool isSuccess) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isSuccess ? const Color(0xFF27AE60) : const Color(0xFFE74C3C),
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
    final height = size.height;

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
                _buildRegisterCard(width),
               
                // Lien vers la connexion
                _buildLoginLink(),
               
                // Espacement pour éviter que le contenu soit coupé
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Construction de l'en-tête avec logo et titre (identique au login)
  Widget _buildHeader(double height) {
    return Container(
      // Espacement vertical plus petit pour l'inscription (plus de contenu)
      padding: EdgeInsets.symmetric(vertical: height * 0.04),
      child: Column(
        children: [
          // Logo de l'application (icône shopping bag)
          Container(
            width: 100,
            height: 100,
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
              size: 50,
              color: Color(0xFFFF6B6B),
            ),
          ),
         
          const SizedBox(height: 20),
         
          // Titre de l'application
          const Text(
            'BarchaDills',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              letterSpacing: 1.2,
            ),
          ),
         
          const SizedBox(height: 6),
         
          // Sous-titre pour l'inscription
          const Text(
            'Rejoignez notre communauté shopping',
            style: TextStyle(
              fontSize: 14,
              color: Colors.white70,
              fontWeight: FontWeight.w300,
            ),
          ),
        ],
      ),
    );
  }

  // Construction de la carte d'inscription
  Widget _buildRegisterCard(double width) {
    return Container(
      width: double.infinity,
      // Padding interne de la carte
      padding: const EdgeInsets.all(28),
      margin: const EdgeInsets.only(bottom: 20),
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
          // Titre de la section inscription
          const Text(
            'Inscription',
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2C3E50),
            ),
          ),
         
          const SizedBox(height: 6),
         
          // Message d'accueil
          const Text(
            'Créez votre compte pour profiter de toutes nos offres',
            style: TextStyle(
              fontSize: 13,
              color: Color(0xFF7F8C8D),
            ),
          ),
         
          const SizedBox(height: 24),
         
          // Champ nom complet
          _buildNameField(),
         
          const SizedBox(height: 16),
         
          // Champ email
          _buildEmailField(),
         
          const SizedBox(height: 16),
         
          // Champ téléphone (optionnel)
          _buildPhoneField(),
         
          const SizedBox(height: 16),
         
          // Champ mot de passe
          _buildPasswordField(),
         
          const SizedBox(height: 16),
         
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
          'Nom complet',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: Color(0xFF2C3E50),
          ),
        ),
       
        const SizedBox(height: 6),
       
        // Champ de saisie nom
        TextField(
          controller: _nameController,
          decoration: InputDecoration(
            hintText: 'Entrez votre nom complet',
            hintStyle: const TextStyle(color: Color(0xFFBDC3C7), fontSize: 14),
            filled: true,
            fillColor: const Color(0xFFF8F9FA),
            // Icône personne à gauche
            prefixIcon: const Icon(
              Icons.person_outline,
              color: Color(0xFFFF6B6B),
              size: 20,
            ),
            // Padding interne du champ réduit
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
            // Bordure normale
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: Color(0xFFE8E8E8),
                width: 1,
              ),
            ),
            // Bordure en focus
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: Color(0xFFFF6B6B),
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
        // Label du champ
        const Text(
          'Email',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: Color(0xFF2C3E50),
          ),
        ),
       
        const SizedBox(height: 6),
       
        // Champ de saisie email
        TextField(
          controller: _emailController,
          decoration: InputDecoration(
            hintText: 'Entrez votre email',
            hintStyle: const TextStyle(color: Color(0xFFBDC3C7), fontSize: 14),
            filled: true,
            fillColor: const Color(0xFFF8F9FA),
            // Icône email à gauche
            prefixIcon: const Icon(
              Icons.email_outlined,
              color: Color(0xFFFF6B6B),
              size: 20,
            ),
            // Padding interne du champ
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
            // Bordure normale
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: Color(0xFFE8E8E8),
                width: 1,
              ),
            ),
            // Bordure en focus
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
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

  // Construction du champ téléphone
  Widget _buildPhoneField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label du champ avec indication optionnel
        const Row(
          children: [
            Text(
              'Téléphone',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Color(0xFF2C3E50),
              ),
            ),
            SizedBox(width: 4),
            Text(
              '(optionnel)',
              style: TextStyle(
                fontSize: 11,
                color: Color(0xFF7F8C8D),
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
       
        const SizedBox(height: 6),
       
        // Champ de saisie téléphone
        TextField(
          controller: _phoneController,
          decoration: InputDecoration(
            hintText: '+216 XX XXX XXX',
            hintStyle: const TextStyle(color: Color(0xFFBDC3C7), fontSize: 14),
            filled: true,
            fillColor: const Color(0xFFF8F9FA),
            // Icône téléphone à gauche
            prefixIcon: const Icon(
              Icons.phone_outlined,
              color: Color(0xFFFF6B6B),
              size: 20,
            ),
            // Padding interne du champ
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
            // Bordure normale
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: Color(0xFFE8E8E8),
                width: 1,
              ),
            ),
            // Bordure en focus
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: Color(0xFFFF6B6B),
                width: 2,
              ),
            ),
          ),
          keyboardType: TextInputType.phone,
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
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: Color(0xFF2C3E50),
          ),
        ),
       
        const SizedBox(height: 6),
       
        // Champ de saisie mot de passe
        TextField(
          controller: _passwordController,
          decoration: InputDecoration(
            hintText: 'Choisissez un mot de passe',
            hintStyle: const TextStyle(color: Color(0xFFBDC3C7), fontSize: 14),
            filled: true,
            fillColor: const Color(0xFFF8F9FA),
            // Icône cadenas à gauche
            prefixIcon: const Icon(
              Icons.lock_outline,
              color: Color(0xFFFF6B6B),
              size: 20,
            ),
            // Bouton pour afficher/masquer le mot de passe
            suffixIcon: IconButton(
              icon: Icon(
                _showPassword ? Icons.visibility : Icons.visibility_off,
                color: const Color(0xFFBDC3C7),
                size: 20,
              ),
              onPressed: _toggleShowPassword,
            ),
            // Padding interne du champ
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
            // Bordure normale
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: Color(0xFFE8E8E8),
                width: 1,
              ),
            ),
            // Bordure en focus
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
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

  // Construction du champ confirmation mot de passe
  Widget _buildConfirmPasswordField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label du champ
        const Text(
          'Confirmer le mot de passe',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: Color(0xFF2C3E50),
          ),
        ),
       
        const SizedBox(height: 6),
       
        // Champ de confirmation mot de passe
        TextField(
          controller: _confirmPasswordController,
          decoration: InputDecoration(
            hintText: 'Confirmez votre mot de passe',
            hintStyle: const TextStyle(color: Color(0xFFBDC3C7), fontSize: 14),
            filled: true,
            fillColor: const Color(0xFFF8F9FA),
            // Icône cadenas à gauche
            prefixIcon: const Icon(
              Icons.lock_outline,
              color: Color(0xFFFF6B6B),
              size: 20,
            ),
            // Bouton pour afficher/masquer le mot de passe
            suffixIcon: IconButton(
              icon: Icon(
                _showConfirmPassword ? Icons.visibility : Icons.visibility_off,
                color: const Color(0xFFBDC3C7),
                size: 20,
              ),
              onPressed: _toggleShowConfirmPassword,
            ),
            // Padding interne du champ
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
            // Bordure normale
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: Color(0xFFE8E8E8),
                width: 1,
              ),
            ),
            // Bordure en focus
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: Color(0xFFFF6B6B),
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
          width: 24,
          height: 24,
          child: Checkbox(
            value: _acceptTerms,
            onChanged: (value) {
              setState(() {
                _acceptTerms = value ?? false;
              });
            },
            activeColor: const Color(0xFFFF6B6B),
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
              'J\'accepte les conditions d\'utilisation et la politique de confidentialité',
              style: TextStyle(
                fontSize: 12,
                color: Color(0xFF7F8C8D),
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
      height: 52,
      child: ElevatedButton(
        onPressed: _handleRegister,
        style: ElevatedButton.styleFrom(
          // Couleur de fond du bouton
          backgroundColor: const Color(0xFFFF6B6B),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 0,
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Texte du bouton
            Text(
              'Créer mon compte',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
           
            SizedBox(width: 8),
           
            // Icône utilisateur
            Icon(
              Icons.person_add,
              color: Colors.white,
              size: 18,
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
              'Déjà un compte? ',
              style: TextStyle(
                fontSize: 14,
                color: Colors.white70,
              ),
            ),
            // Texte cliquable pour la connexion
            Text(
              'Se connecter',
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
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
}