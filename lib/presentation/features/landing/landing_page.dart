import 'package:billsplit_flutter/presentation/common/base_scaffold.dart';
import 'package:billsplit_flutter/presentation/common/page_view_title.dart';
import 'package:billsplit_flutter/presentation/features/landing/bloc/landing_cubit.dart';
import 'package:billsplit_flutter/presentation/features/landing/widgets/sign_in_view.dart';
import 'package:billsplit_flutter/presentation/features/landing/widgets/sign_up_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<LandingCubit>();
    return BaseScaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: Text(
          "Splitsby",
          style: Theme.of(context)
              .textTheme
              .displaySmall
              ?.copyWith(fontWeight: FontWeight.w600),
        ),
      ),
      body: Column(
        children: [
          PageViewTitle(
            pageController: cubit.pageController,
            titleOne: "Sign In",
            titleTwo: "Sign Up",
          ),
          Expanded(
            child: PageView(
              controller: cubit.pageController,
              children: const [
                SignInView(),
                SignUpView(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
