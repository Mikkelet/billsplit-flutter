import 'package:billsplit_flutter/data/remote/requests/get_groups_response.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part '../../_generated/data/remote/splitsby_service.g.dart';

@RestApi()
abstract class SplitsbyService {
  factory SplitsbyService(Dio dio, {String baseUrl}) = _SplitsbyService;

  @GET("/groups")
  Future<GetGroupsResponse> getGroups();
}