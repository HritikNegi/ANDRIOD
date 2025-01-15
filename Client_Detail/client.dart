import 'package:hive/hive.dart';

part 'client.g.dart'; 


@HiveType(typeId: 0)
class Client {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final int phoneNumber;

  @HiveField(2)
  final String email;

  @HiveField(3)
  final DateTime expirationDate;

  Client(this.name, this.phoneNumber, this.email, this.expirationDate);
}
