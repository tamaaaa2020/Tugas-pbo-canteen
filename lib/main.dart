import 'package:flutter/material.dart';
import 'splash_screen.dart';
import 'cart.dart';
import 'data.dart';
import 'cart_data.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.black,
      ),
      home: const SplashScreen(), // Set SplashScreen as the home
    );
  }
}

class FoodDeliveryScreen extends StatelessWidget {
  const FoodDeliveryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 75, 75, 75),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // App Bar
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.grey[900],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child:
                        const Icon(Icons.menu, color: Colors.white, size: 20),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.grey[900],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(Icons.person_outline,
                        color: Colors.white, size: 20),
                  ),
                ],
              ),
            ),

            const Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 100.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CategoryItem(
                      icon: Icons.fastfood,
                      label: 'All',
                      isSelected: true,
                    ),
                    const SizedBox(width: 16),
                    CategoryItem(
                      icon: Icons.lunch_dining,
                      label: 'Makanan',
                    ),
                    const SizedBox(width: 16),
                    CategoryItem(
                      icon: Icons.local_drink,
                      label: 'Minuman',
                    ),
                  ],
                ),
              ),
            ),

            const Padding(
              padding: EdgeInsets.all(24.0),
              child: Text(
                'All Food',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),

            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: GridView.count(
                  crossAxisCount: 2,
                  childAspectRatio: 0.75,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  children: const [
                    FoodItem(
                      title: 'Burger',
                      price: 'Rp. 35.000,00',
                      imagePath: 'assets/burger_icon.jpg',
                      category: 'Food',
                    ),
                    FoodItem(
                      title: 'Burger',
                      price: 'Rp. 65.000,00',
                      imagePath: 'assets/burger_icon.jpg',
                      category: 'Food',
                    ),
                    FoodItem(
                      title: 'Burger',
                      price: 'Rp. 20.000,00',
                      imagePath: 'assets/burger_icon.jpg',
                      category: 'Food',
                    ),
                    FoodItem(
                      title: 'Teh Botol',
                      price: 'Rp. 4.000,00',
                      imagePath: 'assets/teh_botol.jpg',
                      category: 'Drink',
                    ),
                  ],
                ),
              ),
            ),

            Container(
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const NavBarIcon(icon: Icons.home, isSelected: true),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const CartPage()),
                      );
                    },
                    child: Stack(
                      children: [
                        const NavBarIcon(icon: Icons.shopping_cart),
                        Positioned(
                          right: 0,
                          top: 0,
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: const BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                            ),
                            child: const Text(
                              '1',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const DataPage()),
                      );
                    },
                    child: const NavBarIcon(icon: Icons.receipt_long),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CategoryItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;

  const CategoryItem({
    Key? key,
    required this.icon,
    required this.label,
    this.isSelected = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            color: isSelected ? Colors.white : Colors.grey[900],
            borderRadius: BorderRadius.circular(16),
          ),
          child: Icon(
            icon,
            color: isSelected ? Colors.black : Colors.white,
            size: 24,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.white,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }
}

class FoodItem extends StatelessWidget {
  final String title;
  final String price;
  final String imagePath;
  final String category;

  const FoodItem({
    Key? key,
    required this.title,
    required this.price,
    required this.imagePath,
    required this.category,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        price,
                        style: TextStyle(
                          color: Colors.grey[400],
                          fontSize: 12,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          // Parse price from string to double
                          double parsedPrice = double.parse(price.replaceAll(RegExp(r'[^0-9]'), ''));
                          CartData.cartItems.add(CartItem(
                            image: imagePath,
                            title: title,
                            price: parsedPrice,
                            count: 1,
                          ));
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('$title added to cart')),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.add,
                            color: Colors.black,
                            size: 16,
                          ),
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
}

class NavBarIcon extends StatelessWidget {
  final IconData icon;
  final bool isSelected;

  const NavBarIcon({
    Key? key,
    required this.icon,
    this.isSelected = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Icon(
      icon,
      color: isSelected ? Colors.white : Colors.white,
      size: 24,
    );
  }
}
