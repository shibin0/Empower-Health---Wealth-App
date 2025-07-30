import 'package:freezed_annotation/freezed_annotation.dart';

part 'achievement.freezed.dart';
part 'achievement.g.dart';

@freezed
class Achievement with _$Achievement {
  const factory Achievement({
    required String id,
    required String title,
    required String description,
    required String icon,
    required bool earned,
    DateTime? earnedDate,
    required int xpReward,
  }) = _Achievement;

  factory Achievement.fromJson(Map<String, dynamic> json) =>
      _$AchievementFromJson(json);
}