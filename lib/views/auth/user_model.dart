class UserModel {
  final String uid;
  final String nome;
  final String email;
  final String role;

  UserModel({
    required this.uid,
    required this.nome,
    required this.email,
    required this.role,
  });

  factory UserModel.fromMap(String uid, Map<String, dynamic> data) {
    return UserModel(
      uid: uid,
      nome: data['nome'] ?? '',
      email: data['email'] ?? '',
      role: data['role'] ?? 'cliente',
    );
  }

  static empty() {}
}
