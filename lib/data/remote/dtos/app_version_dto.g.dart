// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_version_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppVersionDTO _$AppVersionDTOFromJson(Map<String, dynamic> json) =>
    AppVersionDTO(
      json['minVersion'] as num,
      json['latestVersion'] as num,
    );

Map<String, dynamic> _$AppVersionDTOToJson(AppVersionDTO instance) =>
    <String, dynamic>{
      'minVersion': instance.minVersion,
      'latestVersion': instance.latestVersion,
    };
