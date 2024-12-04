import 'package:achiever/domain/user/entities/user.dart';
import 'package:achiever/infrastructure/core/timestamp_converter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_dto.g.dart';

@JsonSerializable()
class UserDto {
  final String id;
  final String email;
  @JsonKey(name: 'created_at')
  @TimestampConverter()
  final DateTime createdAt;

  UserDto({
    required this.id,
    required this.email,
    required this.createdAt,
  });

  factory UserDto.fromJson(Map<String, dynamic> json) =>
      _$UserDtoFromJson(json);

  Map<String, dynamic> toJson() => _$UserDtoToJson(this);

  User toEntity() {
    return User(
      id: id,
      email: email,
      createdAt: createdAt,
    );
  }
}
