import 'package:billsplit_flutter/extensions.dart';

class UpdateUserRequest {
  static Json updateFCMToken(String? fcmToken) => {"fcmToken": fcmToken};
}
