import 'package:billsplit_flutter/data/local/preferences/shared_prefs.dart';
import 'package:billsplit_flutter/data/remote/api_service.dart';
import 'package:billsplit_flutter/di/get_it.dart';

class GetExchangeRatesUseCase {
  final _apiService = getIt<ApiService>();
  final _prefs = getIt<SharedPrefs>();

  Future launch() async {
    final response = await _apiService.getExchangeRates();
    _prefs.latestExchangeRates = response;
  }
}
