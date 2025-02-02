import 'package:flutter/material.dart';

class BowlerWidget extends StatelessWidget {
  final dynamic name;
  final dynamic over;
  final dynamic maiden;
  final dynamic run;
  final dynamic wicket;
  final dynamic economy;

  const BowlerWidget({
    super.key,
    required this.name,
    required this.over,
    required this.maiden,
    required this.run,
    required this.wicket,
    required this.economy,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 60,
      child: ListTile(
        leadingAndTrailingTextStyle: const TextStyle(
          fontSize: 16,
          color: Colors.black,
        ),
        leading: Text(name),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          spacing: 12,
          children: [
            SizedBox(
              width: 30,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(over),
              ),
            ),
            SizedBox(
              width: 30,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(maiden),
              ),
            ),
            SizedBox(
              width: 30,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(run),
              ),
            ),
            SizedBox(
              width: 30,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(wicket),
              ),
            ),
            SizedBox(
              width: 30,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(economy),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
