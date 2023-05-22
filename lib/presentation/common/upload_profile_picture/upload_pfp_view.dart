import 'package:billsplit_flutter/presentation/base/bloc/base_state.dart';
import 'package:billsplit_flutter/presentation/common/base_bloc_builder.dart';
import 'package:billsplit_flutter/presentation/common/base_bloc_widget.dart';
import 'package:billsplit_flutter/presentation/common/pfp_view.dart';
import 'package:billsplit_flutter/presentation/common/upload_profile_picture/upload_pfp_cubit.dart';
import 'package:billsplit_flutter/presentation/utils/routing_utils.dart';
import 'package:flutter/material.dart';

class UploadProfilePictureView extends StatelessWidget {
  const UploadProfilePictureView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseBlocWidget(
      create: (context) => UploadProfilePictureCubit(),
      child: BaseBlocBuilder<UploadProfilePictureCubit>(
        builder: (cubit, state) => GestureDetector(
          onTap: () {
            cubit.updateProfilePicture();
          },
          child: Builder(
            builder: (context) {
              if (state is Loading) {
                return const SizedBox(
                    width: 120,
                    height: 120,
                    child: CircularProgressIndicator());
              }
              return ProfilePictureView(person: cubit.user, size: 120);
            },
          ),
        ),
      ),
    );
  }

  static Route getRoute() => slideLeftRoute(const UploadProfilePictureView());

}
