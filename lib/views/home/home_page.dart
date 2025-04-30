//import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:comerce/views/funcoes/logout.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  final List<Map<String, dynamic>> categories = const [
    {'name': 'Moda', 'icon': Icons.checkroom,},
    {'name': 'Eletrônicos', 'icon': Icons.phone_iphone},
    {'name': 'Casa', 'icon': Icons.chair},
    {'name': 'Esportes', 'icon': Icons.sports_soccer},
    {'name': 'Beleza', 'icon': Icons.brush},
    {'name': 'Livros', 'icon': Icons.book},
    {'name': 'Brinquedos', 'icon': Icons.toys},
    
  ];
 
  // Lista de produtos (exemplo)
  final List<Map<String, dynamic>> products = const [
    {'name': 'Camisa Vermelha', 'price': 59.99, 'image': 'https://via.placeholder.com/150'},
    {'name': 'iPhone 14', 'price': 4999.99, 'image': 'https://via.placeholder.com/150'},
    {'name': 'Sofá 2 lugares', 'price': 899.99, 'image': 'https://via.placeholder.com/150'},
    {'name': 'Bola Adidas', 'price': 99.99, 'image': 'assets/images/bola_adidas.png'},
    {'name': 'Tênis Nike', 'price': 399.99, 'image': 'https://via.placeholder.com/150'},
    {'name': 'Cadeira Gamer', 'price': 799.99, 'image': 'https://via.placeholder.com/150'},
    {'name': 'Relógio Smart', 'price': 299.99, 'image': 'https://via.placeholder.com/150'},
    {'name': 'Fone Bluetooth', 'price': 199.99, 'image': 'https://via.placeholder.com/150'},
    {'name': 'Camiseta Estampada', 'price': 49.99, 'image': 'https://via.placeholder.com/150'},
    
  ];
  


  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? Colors.black : Colors.white,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 53, 16, 16),
        title: const Text('MyShop', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        elevation: 0,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 53, 16, 16),
              ),
              child: Text('Menu', style: TextStyle(color: Colors.white, fontSize: 24)),
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('logout'),
              onTap: () {
                logout(context);
                // 
              },
            ),
            ListTile(
              leading: const Icon(Icons.shopping_bag),
              title: const Text('cadastrar produtos'),
              onTap: () {
                Navigator.pushReplacementNamed(context, '/cadastrar');
              },
              
            ),
            ListTile(
              leading: const Icon(Icons.list),
              title: const Text('Produtos'),
              onTap: () {
                Navigator.pushReplacementNamed(context, '/produtos');
              },
            ),
            
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // Banner
            Container(
              margin: const EdgeInsets.all(16),
              height: 330,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                image: const DecorationImage(
                  image: NetworkImage('https://buri.org.br/imagens/pagina_em.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),

            // Categorias
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text('Categorias',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 12),

            SizedBox(
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final category = categories[index];
                  return Container(
                    margin: const EdgeInsets.only(right: 16),
                    width: 80,
                    decoration: BoxDecoration(
                      color: Colors.redAccent.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(category['icon'], size: 32, color: Colors.redAccent),
                        const SizedBox(height: 8),
                        Text(
                          category['name'],
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 24),

            // Produtos
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text('Produtos em destaque',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 12),

            GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: products.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.7,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemBuilder: (context, index) {
                final product = products[index];
                return Container(
                  decoration: BoxDecoration(
                    color: isDark ? Colors.grey[900] : Colors.grey[100],
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                        child: Image.network(
                          product['image'],
                          height: 120,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          product['name'],
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          'R\$ ${product['price'].toStringAsFixed(2)}',
                          style: const TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
