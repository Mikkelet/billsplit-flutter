import 'package:billsplit_flutter/domain/models/person.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ProfilePictureView extends StatelessWidget {
  final Person person;
  final double size;

  const ProfilePictureView({Key? key, required this.person, this.size = 40.0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: CachedNetworkImage(
          imageUrl: person.pfpUrl,
          width: size,
          height: size,
          fit: BoxFit.cover),
    );
  }
}
