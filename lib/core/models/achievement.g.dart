// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'achievement.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AchievementImpl _$$AchievementImplFromJson(Map<String, dynamic> json) =>
    _$AchievementImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      icon: json['icon'] as String,
      earned: json['earned'] as bool,
      earnedDate: json['earnedDate'] == null
          ? null
          : DateTime.parse(json['earnedDate'] as String),
      xpReward: (json['xpReward'] as num).toInt(),
    );

Map<String, dynamic> _$$AchievementImplToJson(_$AchievementImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'icon': instance.icon,
      'earned': instance.earned,
      'earnedDate': instance.earnedDate?.toIso8601String(),
      'xpReward': instance.xpReward,
    };
