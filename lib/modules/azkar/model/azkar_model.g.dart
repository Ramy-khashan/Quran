// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'azkar_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AzkarModelAdapter extends TypeAdapter<AzkarModel> {
  @override
  final int typeId = 0;

  @override
  AzkarModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AzkarModel(
      iD: fields[0] as int?,
      aRABICTEXT: fields[1] as String?,
      lANGUAGEARABICTRANSLATEDTEXT: fields[2] as String?,
      tRANSLATEDTEXT: fields[3] as String?,
      rEPEAT: fields[4] as int?,
      text: fields[6] as String?,
      aUDIO: fields[5] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, AzkarModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.iD)
      ..writeByte(1)
      ..write(obj.aRABICTEXT)
      ..writeByte(2)
      ..write(obj.lANGUAGEARABICTRANSLATEDTEXT)
      ..writeByte(3)
      ..write(obj.tRANSLATEDTEXT)
      ..writeByte(4)
      ..write(obj.rEPEAT)
      ..writeByte(5)
      ..write(obj.aUDIO)
      ..writeByte(6)
      ..write(obj.text);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AzkarModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
