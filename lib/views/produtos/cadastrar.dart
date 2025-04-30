import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CadastrarProdutoPage extends StatelessWidget {
  CadastrarProdutoPage({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController descricaoController = TextEditingController();
  final TextEditingController precoController = TextEditingController();
  final TextEditingController estoqueController = TextEditingController();
  final TextEditingController imagemController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastrar Produtos'),
        backgroundColor: const Color.fromARGB(255, 53, 16, 16),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushNamed(context, '/home'); // Volta para a página anterior (HomePage)
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: nomeController,
                decoration: const InputDecoration(
                  labelText: 'Nome do Produto',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o nome do produto';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: descricaoController,
                decoration: const InputDecoration(
                  labelText: 'Descrição',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira a descrição do produto';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: precoController,
                decoration: const InputDecoration(
                  labelText: 'Preço',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o preço do produto';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: estoqueController,
                decoration: const InputDecoration(
                  labelText: 'Estoque',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira a quantidade em estoque';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Por favor, insira um número válido para o estoque';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: imagemController,
                decoration: const InputDecoration(
                  labelText: 'URL da Imagem',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira a URL da imagem';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              Center(
                child: ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      try {
                        // Converte o estoque para int
                        final int estoque = int.parse(estoqueController.text);

                        // Salvar no Firestore
                        await FirebaseFirestore.instance.collection('produtos').add({
                          'nome': nomeController.text,
                          'descricao': descricaoController.text,
                          'preco': double.parse(precoController.text),
                          'estoque': estoque,
                          'imagem': imagemController.text,
                          'criado_em': Timestamp.now(),
                        });

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Produto cadastrado com sucesso!')),
                        );

                        // Limpar os campos após o cadastro
                        nomeController.clear();
                        descricaoController.clear();
                        precoController.clear();
                        estoqueController.clear();
                        imagemController.clear();
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Erro ao cadastrar produto: $e')),
                        );
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                  ),
                  child: const Text('Cadastrar Produto'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}