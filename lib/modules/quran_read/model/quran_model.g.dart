// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quran_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class QuranModelAdapter extends TypeAdapter<QuranModel> {
  @override
  final int typeId = 1;

  @override
  QuranModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return QuranModel(
      tafser: fields[4] as String,
      audioFile: fields[3] as String,
      textAr: fields[0] as String,
      textEn: fields[1] as String,
      audio: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, QuranModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.textAr)
      ..writeByte(1)
      ..write(obj.textEn)
      ..writeByte(2)
      ..write(obj.audio)
      ..writeByte(3)
      ..write(obj.audioFile)
      ..writeByte(4)
      ..write(obj.tafser);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is QuranModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
