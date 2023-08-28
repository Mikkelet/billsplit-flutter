import 'package:billsplit_flutter/data/remote/api_service.dart';
import 'package:billsplit_flutter/di/get_it.dart';
import 'package:billsplit_flutter/domain/models/app_version.dart';
import 'package:package_info_plus/package_info_plus.dart';

class GetAppVersion {
  final _apiService = getIt<ApiService>();

  Future<AppVersion> launch() async {
    final packageInfo = await PackageInfo.fromPlatform();
    final appData = await _apiService.getAppVersion();
    final appVersion = num.parse(packageInfo.buildNumber);
    return AppVersion(
        minimumVersion: appData.minVersion,
        latestVersion: appData.latestVersion,
        currentVersion: appVersion);
  }
}
