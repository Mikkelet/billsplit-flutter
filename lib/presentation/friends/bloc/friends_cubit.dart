import 'package:billsplit_flutter/domain/models/friend.dart';
import 'package:billsplit_flutter/domain/use_cases/get_friends_usecase.dart';
import 'package:billsplit_flutter/domain/use_cases/observe_friends_usecase.dart';
import 'package:billsplit_flutter/presentation/base/bloc/base_cubit.dart';

class FriendsCubit extends BaseCubit {
  final _getFriendsUseCase = GetFriendsUseCase();
  final _observeFriendsUseCase = ObserveFriendsUseCase();

  Stream<Iterable<Friend>> friendsStream() => _observeFriendsUseCase.observe();

  void getFriends() {
    _getFriendsUseCase.launch().onError((error, stackTrace) => showError(error));
  }
}
