import 'package:copy_with_extension/copy_with_extension.dart';

part 'achievement.g.dart';

@CopyWith()
class Achievement {
  final String id;
  final String title;
  final String description;
  final DateTime? startDate;
  final DateTime? endDate;

  Achievement({
    required this.id,
    required this.title,
    required this.description,
    required this.startDate,
    required this.endDate,
  });
}
