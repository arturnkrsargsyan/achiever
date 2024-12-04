import 'package:achiever/domain/achievement/entities/achievement.dart';
import 'package:achiever/infrastructure/core/timestamp_converter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'achievement_dto.g.dart';

@JsonSerializable()
class AchievementDto {
  final String id;
  final String title;
  final String description;
  @JsonKey(name: 'start_date')
  @TimestampConverter()
  final DateTime? startDate;
  @JsonKey(name: 'end_date')
  @TimestampConverter()
  final DateTime? endDate;

  AchievementDto({
    required this.id,
    required this.title,
    required this.description,
    required this.startDate,
    required this.endDate,
  });

  factory AchievementDto.fromJson(Map<String, dynamic> json) =>
      _$AchievementDtoFromJson(json);

  Map<String, dynamic> toJson() => _$AchievementDtoToJson(this);

  factory AchievementDto.fromEntity(Achievement achievement) {
    return AchievementDto(
      id: achievement.id,
      title: achievement.title,
      description: achievement.description,
      startDate: achievement.startDate,
      endDate: achievement.endDate,
    );
  }

  Achievement toEntity() {
    return Achievement(
      id: id,
      title: title,
      description: description,
      startDate: startDate,
      endDate: endDate,
    );
  }
}
