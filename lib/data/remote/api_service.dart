import 'package:billsplit_flutter/data/remote/dtos/app_version_dto.dart';
import 'package:billsplit_flutter/data/remote/dtos/event_dto.dart';
import 'package:billsplit_flutter/data/remote/dtos/friend_dto.dart';
import 'package:billsplit_flutter/data/remote/dtos/group_dto.dart';
import 'package:billsplit_flutter/data/remote/dtos/service_dto.dart';
import 'package:billsplit_flutter/data/remote/network_client.dart';
import 'package:billsplit_flutter/data/remote/requests/add_event_request.dart';
import 'package:billsplit_flutter/data/remote/requests/add_friend_request.dart';
import 'package:billsplit_flutter/data/remote/requests/add_group_request.dart';
import 'package:billsplit_flutter/data/remote/requests/add_service_request.dart';
import 'package:billsplit_flutter/data/remote/requests/get_events_request.dart';
import 'package:billsplit_flutter/data/remote/requests/get_exchange_rates_request.dart';
import 'package:billsplit_flutter/data/remote/requests/get_friends_request.dart';
import 'package:billsplit_flutter/data/remote/requests/get_group_invites_response.dart';
import 'package:billsplit_flutter/data/remote/requests/get_group_request.dart';
import 'package:billsplit_flutter/data/remote/requests/get_groups_response.dart';
import 'package:billsplit_flutter/data/remote/requests/invite_to_group_request.dart';
import 'package:billsplit_flutter/data/remote/requests/leave_group_request.dart';
import 'package:billsplit_flutter/data/remote/requests/respond_to_friend_request_request.dart';
import 'package:billsplit_flutter/data/remote/requests/respond_to_group_invite_request.dart';
import 'package:billsplit_flutter/data/remote/requests/update_user_request.dart';

class ApiService {
  final NetworkClient _client;

  ApiService(this._client);

  Future<GetGroupsResponse> getGroups() async {
    final body = await _client.get("groups");
    return GetGroupsResponse.fromJson(body);
  }

  Future<GetGroupResponse> getGroup(String groupId) async {
    final body = await _client.get("group/$groupId");
    return GetGroupResponse.fromJson(body);
  }

  Future<GetEventsResponse> getEvents(String groupId) async {
    final body = await _client.get("group/$groupId/events");
    return GetEventsResponse.fromJson(body);
  }

  Future<GetFriendsResponse> getFriends() async {
    final response = await _client.get("friends");
    return GetFriendsResponse.fromJson(response);
  }

  Future<AddEventResponse> addEvent(String groupId, EventDTO eventDTO) async {
    final request = AddEventRequest(groupId, eventDTO);
    final response = await _client.post("event", request.toJson());
    return AddEventResponse.fromJson(response!);
  }

  Future<ServiceDTO> addService(String groupId, ServiceDTO service) async {
    final data = AddServiceRequest(service);
    final response =
        await _client.post("group/$groupId/service", data.toJson());
    return AddServiceResponse.fromJson(response!).service;
  }

  Future updateService(String groupId, ServiceDTO service) async {
    final data = AddServiceRequest(service);
    await _client.put("group/$groupId/service", data.toJson());
  }

  Future deleteService(String groupId, String serviceId) async {
    await _client.delete("group/$groupId/service/$serviceId");
  }

  Future<GroupDTO> leaveGroup(String groupId) async {
    final response = await _client.get("leaveGroup/$groupId");
    return LeaveGroupRequest.fromJson(response).group;
  }

  Future<FriendDTO> addFriendEmail(String email) => _addFriend("email", email);

  Future<FriendDTO> addFriendPhone(String phoneNumber) =>
      _addFriend("phone", phoneNumber);

  Future<FriendDTO> addFriendUserId(String userId) =>
      _addFriend("userId", userId);

  Future<FriendDTO> _addFriend(String type, String value) async {
    final FriendRequestType requestType;
    switch (type) {
      case "email":
        requestType = RequestTypeEmail(value);
        break;
      case "phone":
        requestType = RequestTypePhone(value);
        break;
      default:
        requestType = RequestTypeUserId(value);
    }
    final response = await _client.post("friends", requestType.toJson());
    return AddFriendResponse.fromJson(response!).friend;
  }

  Future respondToFriendRequest({
    required String friendUid,
    required bool accept,
  }) async {
    final body = RespondToFriendRequestRequest(
        accept: accept, friendUid: friendUid, requestId: "");
    await _client.post("/friendRequest", body.toJson());
  }

  Future<GroupDTO> addGroup(GroupDTO group) async {
    final body = AddGroupRequest(group);
    final response = await _client.post("group", body.toJson());
    return AddGroupResponse.fromJson(response!).group;
  }

  Future updateFCMToken(String? fcmToken) async {
    final updateData = UpdateUserRequest.updateFCMToken(fcmToken);
    await _client.put("user", updateData);
  }

  Future deleteExpense(String groupId, String expenseId) async {
    await _client.delete("group/$groupId/events/$expenseId");
  }

  void onDestroy() {
    _client.onDestroy();
  }

  Future<Map<String, num>> getExchangeRates() async {
    final response = await _client.get("rates");
    return GetExchangeRatesRequest.fromJson(response).rates;
  }

  Future<AppVersionDTO> getAppVersion() async {
    final response = await _client.get("appVersion", authorized: false);
    return AppVersionDTO.fromJson(response);
  }

  Future<GetGroupInvitesResponse> getGroupInvites() async {
    final response = await _client.get("groupInvites");
    return GetGroupInvitesResponse.fromJson(response);
  }

  Future invitePersonToGroup(String groupId, String uid) async {
    final body = InviteToGroupRequest(groupId: groupId, userId: uid);
    await _client.post("group/invite", body.toJson());
  }

  Future respondToGroupInvite(String groupId, bool accept) async {
    final body = RespondToGroupInviteRequest(groupId, accept);
    await _client.post("group/invitation", body.toJson());
  }

  Future deleteUser() async {
    await _client.delete("user");
  }
}
