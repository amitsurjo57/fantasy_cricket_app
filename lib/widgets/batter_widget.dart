import 'package:flutter/material.dart';

class BatterWidget extends StatelessWidget {
  final dynamic name;
  final dynamic run;
  final dynamic ballPlayed;
  final dynamic four;
  final dynamic six;
  final dynamic bowler;
  final dynamic out;

  const BatterWidget({
    super.key,
    required this.name,
    required this.run,
    required this.ballPlayed,
    required this.four,
    required this.six,
    required this.bowler,
    required this.out,
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
        leading: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(name),
            Text(
              "$out $bowler",
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
          ],
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          spacing: 12,
          children: [
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
                child: Text(ballPlayed),
              ),
            ),
            SizedBox(
              width: 30,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(four),
              ),
            ),
            SizedBox(
              width: 30,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(six),
              ),
            ),
            SizedBox(
              width: 30,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  _calculateStrikeRate().toStringAsFixed(2),
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  double _calculateStrikeRate() {
    int batterBall = int.tryParse(ballPlayed) ?? 1;
    int batterRun = int.tryParse(run) ?? 0;

    return (batterRun / batterBall) * 100;
  }
}
