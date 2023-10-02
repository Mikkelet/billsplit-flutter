import 'package:billsplit_flutter/presentation/common/clickable_list_item.dart';
import 'package:billsplit_flutter/presentation/features/group/bloc/group_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum ListButtonAction {
  updateImage,
  deleteImage;
}

class GroupPictureButton extends StatefulWidget {
  const GroupPictureButton({super.key});

  @override
  State<GroupPictureButton> createState() => _GroupPictureButtonState();
}

class _GroupPictureButtonState extends State<GroupPictureButton> {
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<GroupBloc>();
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
                  _listButton("Update image", ListButtonAction.updateImage),
                  const SizedBox(height: 16),
                  _listButton("Delete image", ListButtonAction.deleteImage),
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
      child: Builder(
        builder: (context) {
          if (cubit.group.coverImageUrlState.isNotEmpty) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: CachedNetworkImage(
                width: double.infinity,
                imageUrl: cubit.group.coverImageUrlState,
                fit: BoxFit.cover,
              ),
            );
          }
          return Text("Upload group picture",
              style: Theme.of(context).textTheme.labelLarge);
        },
      ),
    );
  }

  Widget _listButton(String text, ListButtonAction action) {
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
