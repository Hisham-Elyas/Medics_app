// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'doctor_model.dart';

class AppointmentModel {
  final int count;
  final List<Appointment> appointment;
  AppointmentModel({
    required this.count,
    required this.appointment,
  });

  AppointmentModel copyWith({
    int? count,
    List<Appointment>? appointment,
  }) {
    return AppointmentModel(
      count: count ?? this.count,
      appointment: appointment ?? this.appointment,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'count': count,
      'appointment': appointment.map((x) => x.toMap()).toList(),
    };
  }

  factory AppointmentModel.fromMap(Map<String, dynamic> map) {
    return AppointmentModel(
      count: map['count'] as int,
      appointment: List<Appointment>.from(
        (map['appointment'] as List<dynamic>).map<Appointment>(
          (x) => Appointment.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory AppointmentModel.fromJson(String source) =>
      AppointmentModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'AppointmentModel(count: $count, appointment: $appointment)';

  @override
  bool operator ==(covariant AppointmentModel other) {
    if (identical(this, other)) return true;

    return other.count == count && listEquals(other.appointment, appointment);
  }

  @override
  int get hashCode => count.hashCode ^ appointment.hashCode;
}

class Appointment {
  final String? id;
  final String name;
  final String userId;
  final DateTime? bookDate;
  final DateTime? createdAt;
  final bool? isCompleted;
  final bool? isConfirmed;

  final DateTime? updatedAt;
  final Doctor doctor;
  Appointment({
    this.id,
    required this.name,
    required this.userId,
    required this.bookDate,
    this.isConfirmed,
    this.isCompleted,
    this.createdAt,
    this.updatedAt,
    required this.doctor,
  });

  Appointment copyWith({
    String? id,
    String? name,
    String? userId,
    DateTime? bookDate,
    DateTime? createdAt,
    bool? isCompleted,
    bool? isConfirmed,
    DateTime? updatedAt,
    Doctor? doctor,
  }) {
    return Appointment(
      id: id ?? this.id,
      name: name ?? this.name,
      userId: userId ?? this.userId,
      bookDate: bookDate ?? this.bookDate,
      createdAt: createdAt ?? this.createdAt,
      isCompleted: isCompleted ?? this.isCompleted,
      isConfirmed: isConfirmed ?? this.isConfirmed,
      updatedAt: updatedAt ?? this.updatedAt,
      doctor: doctor ?? this.doctor,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'userId': userId,
      'bookDate': bookDate?.toString(),
      'createdAt': createdAt?.toString(),
      'updatedAt': updatedAt?.toString(),
      'isCompleted': isCompleted,
      'isConfirmed': isConfirmed,
      'doctor': doctor.toMap(),
    };
  }

  factory Appointment.fromMap(Map<String, dynamic> map) {
    return Appointment(
      id: map['id'] != null ? map['id'] as String : null,
      name: map['name'] as String,
      userId: map['userId'] as String,
      bookDate: DateTime.tryParse(map['bookDate'] as String),
      createdAt: map['createdAt'] != null
          ? DateTime.tryParse(map['createdAt'] as String)
          : null,
      updatedAt: map['updatedAt'] != null
          ? DateTime.tryParse(map['updatedAt'] as String)
          : null,
      isCompleted:
          map['isCompleted'] != null ? map['isCompleted'] as bool : null,
      isConfirmed:
          map['isConfirmed'] != null ? map['isConfirmed'] as bool : null,
      doctor: Doctor.fromMap(map['doctor'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory Appointment.fromJson(String source) =>
      Appointment.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Appointment(id: $id, name: $name, userId: $userId, bookDate: $bookDate, createdAt: $createdAt, isCompleted: $isCompleted, isConfirmed: $isConfirmed, updatedAt: $updatedAt, doctor: $doctor)';
  }

  @override
  bool operator ==(covariant Appointment other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.userId == userId &&
        other.bookDate == bookDate &&
        other.createdAt == createdAt &&
        other.isCompleted == isCompleted &&
        other.isConfirmed == isConfirmed &&
        other.updatedAt == updatedAt &&
        other.doctor == doctor;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        userId.hashCode ^
        bookDate.hashCode ^
        createdAt.hashCode ^
        isCompleted.hashCode ^
        isConfirmed.hashCode ^
        updatedAt.hashCode ^
        doctor.hashCode;
  }
}
