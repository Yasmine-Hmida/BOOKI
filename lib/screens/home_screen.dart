// ignore_for_file: library_private_types_in_public_api, deprecated_member_use

import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Index de l'onglet sélectionné dans la bottom navigation
  int _selectedIndex = 0;

  // Contrôleur pour le champ de recherche
  final TextEditingController _searchController = TextEditingController();

  // Liste des catégories populaires
  final List<Map<String, dynamic>> _categories = [
    {'name': 'Mode', 'icon': Icons.checkroom, 'color': Color(0xFFFF6B6B)},
    {'name': 'Tech', 'icon': Icons.phone_android, 'color': Color(0xFF4ECDC4)},
    {'name': 'Maison', 'icon': Icons.home, 'color': Color(0xFFFFE66D)},
    {'name': 'Sport', 'icon': Icons.sports_soccer, 'color': Color(0xFF95E1D3)},
    {'name': 'Beauté', 'icon': Icons.spa, 'color': Color(0xFFFFB3BA)},
    {'name': 'Plus', 'icon': Icons.more_horiz, 'color': Color(0xFFBAE1FF)},
  ];

  // Liste des produits en promotion (données simulées)
  final List<Map<String, dynamic>> _featuredProducts = [
    {
      'name': 'Smartphone Galaxy',
      'price': '899 TND',
      'originalPrice': '1200 TND',
      'discount': '-25%',
      'rating': 4.5,
      'image': Icons.smartphone,
      'isFavorite': false,
    },
    {
      'name': 'Sneakers Nike Air',
      'price': '320 TND',
      'originalPrice': '450 TND',
      'discount': '-30%',
      'rating': 4.8,
      'image': Icons.sports_basketball,
      'isFavorite': true,
    },
    {
      'name': 'Parfum Elite',
      'price': '180 TND',
      'originalPrice': '250 TND',
      'discount': '-28%',
      'rating': 4.3,
      'image': Icons.local_florist,
      'isFavorite': false,
    },
    {
      'name': 'MacBook Pro',
      'price': '2500 TND',
      'originalPrice': '3200 TND',
      'discount': '-22%',
      'rating': 4.9,
      'image': Icons.laptop_mac,
      'isFavorite': true,
    },
  ];

  // Méthode pour gérer le changement d'onglet dans la bottom navigation
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // Méthode pour basculer le statut favori d'un produit
  void _toggleFavorite(int index) {
    setState(() {
      _featuredProducts[index]['isFavorite'] = !_featuredProducts[index]['isFavorite'];
    });
  }

  // Méthode pour gérer la recherche
  void _handleSearch() {
    final query = _searchController.text.trim();
    if (query.isNotEmpty) {
      // Affichage d'un message de recherche (simulation)
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Recherche en cours: "$query"'),
          backgroundColor: const Color(0xFF4ECDC4),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Récupération des dimensions de l'écran
    final size = MediaQuery.of(context).size;
    final width = size.width;

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      // Barre d'applications personnalisée
      appBar: _buildAppBar(),
     
      // Corps principal de l'écran
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section de recherche
            _buildSearchSection(width),
           
            // Bannière de bienvenue
            _buildWelcomeBanner(width),
           
            // Section des catégories
            _buildCategoriesSection(),
           
            // Section des promotions
            _buildPromotionsSection(),
           
            // Section des produits en vedette
            _buildFeaturedProductsSection(),
           
            // Espacement final
            const SizedBox(height: 100),
          ],
        ),
      ),
     
      // Barre de navigation inférieure
      bottomNavigationBar: _buildBottomNavigation(),
    );
  }

  // Construction de la barre d'applications
  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: const Color(0xFFFF6B6B),
      elevation: 0,
      title: Row(
        children: [
          // Logo de l'application
          Container(
            width: 35,
            height: 35,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.shopping_bag,
              color: Color(0xFFFF6B6B),
              size: 20,
            ),
          ),
         
          const SizedBox(width: 12),
         
          // Nom de l'application et message d'accueil
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'BarchaDills',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Bonjour! 👋',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ],
      ),
      actions: [
        // Bouton de notifications
        IconButton(
          icon: Stack(
            children: [
              const Icon(Icons.notifications_outlined, color: Colors.white),
              // Badge de notification
              Positioned(
                right: 0,
                top: 0,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: Colors.yellow,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
          onPressed: () {
            // Action pour les notifications
          },
        ),
       
        // Bouton de profil
        IconButton(
          icon: const Icon(Icons.account_circle_outlined, color: Colors.white),
          onPressed: () {
            // Action pour le profil
          },
        ),
      ],
    );
  }

  // Construction de la section de recherche
  Widget _buildSearchSection(double width) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          hintText: 'Rechercher des produits...',
          hintStyle: const TextStyle(color: Color(0xFFBDC3C7)),
          filled: true,
          fillColor: Colors.white,
          // Icône de recherche à gauche
          prefixIcon: const Icon(
            Icons.search,
            color: Color(0xFFFF6B6B),
          ),
          // Bouton de recherche à droite
          suffixIcon: IconButton(
            icon: const Icon(
              Icons.tune,
              color: Color(0xFF7F8C8D),
            ),
            onPressed: () {
              // Action pour les filtres
            },
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          // Bordure arrondie
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
        ),
        onSubmitted: (value) => _handleSearch(),
      ),
    );
  }

  // Construction de la bannière de bienvenue
  Widget _buildWelcomeBanner(double width) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: const EdgeInsets.all(20),
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFFFF6B6B),
            Color(0xFFFF8E8E),
          ],
        ),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFFF6B6B).withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          // Texte de la bannière
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Promotions',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Jusqu\'à -70% sur une sélection',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 12),
                // Bouton de la bannière
                ElevatedButton(
                  onPressed: () {
                    // Action pour voir les promotions
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: const Color(0xFFFF6B6B),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text(
                    'Découvrir',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),
         
          // Icône de la bannière
          const Icon(
            Icons.local_offer,
            size: 50,
            color: Colors.white70,
          ),
        ],
      ),
    );
  }

  // Construction de la section des catégories
  Widget _buildCategoriesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Titre de la section
        const Padding(
          padding: EdgeInsets.all(20),
          child: Text(
            'Catégories',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2C3E50),
            ),
          ),
        ),
       
        // Grille des catégories
        SizedBox(
          height: 120,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            itemCount: _categories.length,
            itemBuilder: (context, index) {
              final category = _categories[index];
              return Container(
                width: 80,
                margin: const EdgeInsets.only(right: 15),
                child: Column(
                  children: [
                    // Icône de la catégorie
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: category['color'].withOpacity(0.2),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        category['icon'],
                        color: category['color'],
                        size: 28,
                      ),
                    ),
                   
                    const SizedBox(height: 8),
                   
                    // Nom de la catégorie
                    Text(
                      category['name'],
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF2C3E50),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  // Construction de la section des promotions
  Widget _buildPromotionsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Titre avec bouton "Voir tout"
        Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Offres Spéciales',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2C3E50),
                ),
              ),
              TextButton(
                onPressed: () {
                  // Action pour voir toutes les promotions
                },
                child: const Text(
                  'Voir tout',
                  style: TextStyle(
                    color: Color(0xFFFF6B6B),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
       
        // Liste horizontale des promotions
        SizedBox(
          height: 120,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            itemCount: 3,
            itemBuilder: (context, index) {
              final promos = ['Flash Sale', 'Livraison Gratuite', 'Nouveau Client'];
              final colors = [Color(0xFFE74C3C), Color(0xFF27AE60), Color(0xFF3498DB)];
             
              return Container(
                width: 200,
                margin: const EdgeInsets.only(right: 15),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: colors[index],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      promos[index],
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Conditions spéciales',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  // Construction de la section des produits en vedette
  Widget _buildFeaturedProductsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Titre de la section
        Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Produits Populaires',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2C3E50),
                ),
              ),
              TextButton(
                onPressed: () {
                  // Action pour voir tous les produits
                },
                child: const Text(
                  'Voir tout',
                  style: TextStyle(
                    color: Color(0xFFFF6B6B),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
       
        // Grille des produits
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.75,
            crossAxisSpacing: 15,
            mainAxisSpacing: 15,
          ),
          itemCount: _featuredProducts.length,
          itemBuilder: (context, index) {
            final product = _featuredProducts[index];
            return _buildProductCard(product, index);
          },
        ),
      ],
    );
  }

  // Construction d'une carte produit
  Widget _buildProductCard(Map<String, dynamic> product, int index) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image du produit et bouton favori
          Expanded(
            flex: 3,
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Color(0xFFF8F9FA),
                borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
              ),
              child: Stack(
                children: [
                  // Icône représentant le produit
                  Center(
                    child: Icon(
                      product['image'],
                      size: 50,
                      color: const Color(0xFFFF6B6B),
                    ),
                  ),
                 
                  // Badge de promotion
                  Positioned(
                    top: 8,
                    left: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE74C3C),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        product['discount'],
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                 
                  // Bouton favori
                  Positioned(
                    top: 8,
                    right: 8,
                    child: GestureDetector(
                      onTap: () => _toggleFavorite(index),
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 4,
                            ),
                          ],
                        ),
                        child: Icon(
                          product['isFavorite'] ? Icons.favorite : Icons.favorite_border,
                          color: product['isFavorite'] ? Colors.red : Colors.grey,
                          size: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
         
          // Informations du produit
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Nom du produit
                  Text(
                    product['name'],
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF2C3E50),
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                 
                  const SizedBox(height: 4),
                 
                  // Étoiles de notation
                  Row(
                    children: [
                      ...List.generate(5, (starIndex) {
                        return Icon(
                          starIndex < product['rating'].floor()
                              ? Icons.star
                              : Icons.star_border,
                          size: 12,
                          color: Colors.amber,
                        );
                      }),
                      const SizedBox(width: 4),
                      Text(
                        '(${product['rating']})',
                        style: const TextStyle(
                          fontSize: 10,
                          color: Color(0xFF7F8C8D),
                        ),
                      ),
                    ],
                  ),
                 
                  const Spacer(),
                 
                  // Prix du produit
                  Row(
                    children: [
                      // Prix actuel
                      Text(
                        product['price'],
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFFF6B6B),
                        ),
                      ),
                     
                      const SizedBox(width: 6),
                     
                      // Prix barré
                      Text(
                        product['originalPrice'],
                        style: const TextStyle(
                          fontSize: 11,
                          color: Color(0xFF7F8C8D),
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Construction de la barre de navigation inférieure
  Widget _buildBottomNavigation() {
    return BottomNavigationBar(
      currentIndex: _selectedIndex,
      onTap: _onItemTapped,
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.white,
      selectedItemColor: const Color(0xFFFF6B6B),
      unselectedItemColor: const Color(0xFF7F8C8D),
      selectedFontSize: 12,
      unselectedFontSize: 12,
      items: const [
        // Onglet Accueil
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Accueil',
        ),
        // Onglet Catégories
        BottomNavigationBarItem(
          icon: Icon(Icons.grid_view),
          label: 'Catégories',
        ),
        // Onglet Panier
        BottomNavigationBarItem(
          icon: Icon(Icons.shopping_cart),
          label: 'Panier',
        ),
        // Onglet Favoris
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite),
          label: 'Favoris',
        ),
        // Onglet Profil
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profil',
        ),
      ],
    );
  }

  // Nettoyage des ressources lors de la destruction du widget
  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}