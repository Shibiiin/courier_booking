// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'courier_booking_modal.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CourierBookingModalAdapter extends TypeAdapter<CourierBookingModal> {
  @override
  final int typeId = 0;

  @override
  CourierBookingModal read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CourierBookingModal(
      id: fields[0] as String,
      senderName: fields[1] as String,
      senderPhone: fields[2] as String,
      senderAddress: fields[3] as String,
      receiverName: fields[4] as String,
      receiverPhone: fields[5] as String,
      receiverAddress: fields[6] as String,
      packageWeight: fields[7] as double,
      pickupDateTime: fields[8] as DateTime,
      price: fields[9] as double,
      trackingNumber: fields[10] as String,
      status: fields[11] as String,
    );
  }

  @override
  void write(BinaryWriter writer, CourierBookingModal obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.senderName)
      ..writeByte(2)
      ..write(obj.senderPhone)
      ..writeByte(3)
      ..write(obj.senderAddress)
      ..writeByte(4)
      ..write(obj.receiverName)
      ..writeByte(5)
      ..write(obj.receiverPhone)
      ..writeByte(6)
      ..write(obj.receiverAddress)
      ..writeByte(7)
      ..write(obj.packageWeight)
      ..writeByte(8)
      ..write(obj.pickupDateTime)
      ..writeByte(9)
      ..write(obj.price)
      ..writeByte(10)
      ..write(obj.trackingNumber)
      ..writeByte(11)
      ..write(obj.status);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CourierBookingModalAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
