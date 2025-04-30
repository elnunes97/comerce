import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ListarProdutosPage extends StatelessWidget {
  const ListarProdutosPage({Key? key}) : super(key: key);

  bool _isAssetImage(String path) {
    return path.startsWith('assets/');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Produtos'),
        backgroundColor: const Color.fromARGB(255, 53, 16, 16),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushNamed(context, '/home'); // Volta para a página anterior (HomePage)
          },
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('produtos')
            .orderBy('criado_em', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text('Erro ao carregar produtos.'),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final produtos = snapshot.data!.docs;

          if (produtos.isEmpty) {
            return const Center(
              child: Text('Nenhum produto encontrado.'),
            );
          }

          return ListView.builder(
            itemCount: produtos.length,
            itemBuilder: (context, index) {
              final produto = produtos[index];
              final nome = produto['nome'];
              final descricao = produto['descricao'];
              final preco = produto['preco'];
              final estoque = produto['estoque'];
              final imagem = produto['imagem'];

              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 4,
                child: ListTile(
                  leading: _isAssetImage(imagem)
                      ? Image.asset(
                          imagem,
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        )
                      : Image.network(
                          imagem,
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        ),
                  title: Text(
                    nome,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    '$descricao\nPreço: ${preco.toStringAsFixed(2)} USD\nEstoque: $estoque',
                  ),
                  isThreeLine: true,
                ),
              );
            },
          );
        },
      ),
    );
  }
}