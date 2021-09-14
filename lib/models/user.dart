import 'package:equatable/equatable.dart';

class User extends Equatable {
  const User({
    this.id,
    this.email,
    this.name,
    this.photo,
    this.phoneNumber,
  });

  final String email;
  final String id;
  final String name;
  final String photo;
  final String phoneNumber;

  static const empty = User(id: '');

  bool get isEmpty => this == User.empty;

  bool get isNotEmpty => this != User.empty;

  @override
  List<Object> get props => [email, id, name, photo, phoneNumber];
}
