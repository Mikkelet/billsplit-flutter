import 'package:billsplit_flutter/domain/models/group.dart';
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
        child: Builder(builder: (context) {
          if (group.coverImageUrlState.isEmpty) {
            return const Image(
              fit: BoxFit.fitWidth,
              image: AssetImage('assets/splitsby_logo.jpg'),
            );
          }
          return CachedNetworkImage(
            imageUrl: group.coverImageUrlState,
            fadeInDuration: Duration.zero,
            fit: BoxFit.cover,
          );
        }),
      ),
    );
  }
}
