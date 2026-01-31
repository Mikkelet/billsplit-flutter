import 'package:billsplit_flutter/domain/models/person.dart';
import 'package:billsplit_flutter/presentation/common/circular_frame.dart';
import 'package:billsplit_flutter/presentation/common/pfp_view.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

class ProfilePictureStack extends StatelessWidget {
  final Iterable<Person> people;
  final double size;
  final int limit;

  const ProfilePictureStack({
    super.key,
    required this.people,
    this.size = 40,
    this.limit = 4,
  });

  @override
  Widget build(BuildContext context) {
    final paddingSize = size / 1.5;
    if (people.length <= limit) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 5.0),
        // to offset missing padding from stack's border
        child: Row(
          children: [
            ...people.map(
              (e) => Padding(
                padding: const EdgeInsets.only(right: 2.0),
                child: ProfilePictureView(
                  person: e,
                  size: size,
                ),
              ),
            )
          ],
        ),
      );
    }
    final remaining = people.length - limit;
    final peopleLimited = people.take(limit);
    return Stack(
      children: [
        ...peopleLimited.mapIndexed(
          (index, person) {
            return Padding(
              padding: EdgeInsets.only(left: (paddingSize * index).toDouble()),
              child: ProfilePictureView(
                showBorder: true,
                person: person,
                size: size,
              ),
            );
          },
        ),
        Padding(
          padding: EdgeInsets.only(
              left: (paddingSize * peopleLimited.length).toDouble()),
          child: CircularFrame(
            child: ClipOval(
              child: Container(
                alignment: Alignment.center,
                width: size,
                height: size,
                color: Theme.of(context).colorScheme.secondaryContainer,
                child: Text(
                  "+$remaining",
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontSize: (size / 2.5),
                      color:
                          Theme.of(context).colorScheme.onSecondaryContainer),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
