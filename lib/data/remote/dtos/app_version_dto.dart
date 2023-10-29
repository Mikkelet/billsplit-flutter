import 'package:billsplit_flutter/extensions.dart';
import 'package:json_annotation/json_annotation.dart';

part 'app_version_dto.g.dart';

@JsonSerializable()
class AppVersionDTO {
  final num minVersion;
  final num latestVersion;

  AppVersionDTO(this.minVersion, this.latestVersion);

  Json toJson() => _$AppVersionDTOToJson(this);

  factory AppVersionDTO.fromJson(Json json) => _$AppVersionDTOFromJson(json);
}
