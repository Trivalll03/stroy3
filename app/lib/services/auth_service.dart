import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final Dio dio;
  final FirebaseAuth auth = FirebaseAuth.instance;

  AuthService(this.dio);

  Future<void> register(String email, String password, String name) async {
    await auth.createUserWithEmailAndPassword(email: email, password: password);
    await dio.post("/users/register", data: {
      "email": email,
      "name": name
    });
  }
}