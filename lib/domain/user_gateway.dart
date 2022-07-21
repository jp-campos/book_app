import 'package:prixz/domain/user.dart';

abstract class UserGateway {
  Future<void> signIn(User user);
  Future<User?> logedInUser();
  Future<void> logOut();
}
