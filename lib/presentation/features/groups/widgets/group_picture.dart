import 'package:billsplit_flutter/domain/models/group.dart';
import 'package:billsplit_flutter/presentation/mutable_state.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class GroupPictureView extends StatelessWidget {
  final Group group;

  const GroupPictureView({super.key, required this.group});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(10),
        ),
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(10),
        ),
        child: MutableValue(
          mutableValue: group.coverImageUrlState,
            builder: (context, coverImageUrl) {
          if (coverImageUrl.isEmpty) {
            return const Image(
              fit: BoxFit.fitWidth,
              image: AssetImage('assets/splitsby_logo.jpg'),
            );
          }
          return CachedNetworkImage(
            imageUrl: coverImageUrl,
            fadeInDuration: Duration.zero,
            fit: BoxFit.cover,
          );
        }),
      ),
    );
  }
}
