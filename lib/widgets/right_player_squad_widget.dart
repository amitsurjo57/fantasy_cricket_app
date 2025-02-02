import 'package:flutter/material.dart';

class RightPlayerSquadWidget extends StatelessWidget {
  final dynamic name;
  final dynamic form;
  final dynamic image;

  const RightPlayerSquadWidget({
    super.key,
    required this.name,
    required this.form,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 8,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              form,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                letterSpacing: 1.5,
                color: Colors.grey,
              ),
            ),
          ],
        ),
        CircleAvatar(
          radius: 24,
          backgroundImage: NetworkImage(image),
          backgroundColor: Colors.transparent,
        ),
      ],
    );
  }
}
