import 'package:billsplit_flutter/presentation/base/bloc/base_state.dart';

enum LandingPageNav { signIn, signUp }

class ShowLanding extends BaseState{
  final LandingPageNav nav;

  ShowLanding(this.nav);
}
