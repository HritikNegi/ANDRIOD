// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'client.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************


class ClientAdapter extends TypeAdapter<Client> {
  @override
  final int typeId = 0;

  @override
  Client read(BinaryReader reader) {
    final name = reader.read() as String;
    final phoneNumber = reader.read() as int;
    final email = reader.read() as String;
    final expirationDate = reader.read() as DateTime;
    return Client(name, phoneNumber, email, expirationDate);
  }

  @override
  void write(BinaryWriter writer, Client obj) {
    writer.write(obj.name);
    writer.write(obj.phoneNumber);
    writer.write(obj.email);
    writer.write(obj.expirationDate);
  }
}
