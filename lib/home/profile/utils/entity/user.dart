import 'package:equatable/equatable.dart';

class User extends Equatable {
  const User({
    required this.email,
    required this.name,
  });

  final String email;
  final String name;

  @override
  List<Object> get props => [email, name];
}
