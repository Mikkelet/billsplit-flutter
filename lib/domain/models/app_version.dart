class AppVersion {
  final num minimumVersion;
  final num latestVersion;
  final num currentVersion;

  AppVersion(
      {required this.minimumVersion,
      required this.latestVersion,
      required this.currentVersion});

  bool get mandatoryUpdateAvailable => currentVersion < minimumVersion;

  bool get optionalUpdateAvailable => currentVersion < latestVersion;
}
