import 'package:billsplit_flutter/presentation/common/clickable_list_item.dart';
import 'package:billsplit_flutter/presentation/common/loading_view.dart';
import 'package:billsplit_flutter/presentation/features/group_settings/bloc/group_settings_cubit.dart';
import 'package:billsplit_flutter/presentation/features/group_settings/bloc/group_settings_state.dart';
import 'package:billsplit_flutter/presentation/mutable_state.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum ListButtonAction {
  updateImage,
  deleteImage;
}

class GroupPictureButton extends StatelessWidget {
  const GroupPictureButton({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<GroupSettingsCubit>();
    return ClickableListItem(
      height: 64,
      padding: EdgeInsets.zero,
      onClick: () async {
        final response = await showModalBottomSheet(
            context: context,
            builder: (context) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 16),
                  _listButton(context, "Upload image", ListButtonAction.updateImage),
                  const SizedBox(height: 16),
                  _listButton(context, "Delete image", ListButtonAction.deleteImage),
                  const SizedBox(height: 16),
                ],
              );
            });
        switch (response) {
          case ListButtonAction.updateImage:
            cubit.uploadGroupPicture();
            break;
          case ListButtonAction.deleteImage:
            cubit.deleteGroupPicture();
            break;
        }
      },
      child: LoadingView(
        isLoading: cubit.state is GroupPictureUploading,
        child: MutableValue(
          mutableValue: cubit.group.coverImageUrlState,
          builder: (context, coverImageUrl) {
            if (coverImageUrl.isNotEmpty) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CachedNetworkImage(
                  width: double.infinity,
                  imageUrl: coverImageUrl,
                  fit: BoxFit.cover,
                ),
              );
            }
            return Text("Upload group picture",
                style: Theme.of(context).textTheme.labelLarge);
          },
        ),
      ),
    );
  }

  Widget _listButton(BuildContext context, String text, ListButtonAction action) {
    return TextButton(
      onPressed: () {
        Navigator.of(context).pop(action);
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(text),
        ],
      ),
    );
  }
}
