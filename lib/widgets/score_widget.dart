import 'package:fantasy_cricket_app/model/score_model.dart';
import 'package:flutter/material.dart';

class ScoreWidget extends StatelessWidget {
  final ScoreModel scoreModel;

  const ScoreWidget({super.key, required this.scoreModel});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 180,
      child: Card(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 40,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFFF3FBE7),
                    Colors.white,
                  ],
                ),
              ),
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    scoreModel.matchTitle,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    scoreModel.matchType,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: double.infinity,
              height: 90,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: Column(
                    spacing: 8,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        spacing: 16,
                        children: [
                          Row(
                            spacing: 4,
                            children: [
                              Image.network(
                                scoreModel.teamOneLogo,
                                height: 40,
                              ),
                              Text(
                                scoreModel.teamOneShort,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              const SizedBox(height: 12),
                              Row(
                                spacing: 16,
                                children: [
                                  Text(
                                    "${scoreModel.teamOneScore}/${scoreModel.teamOneWickets}",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w900,
                                      color: scoreModel.battingTeam ==
                                              scoreModel.teamOneName
                                          ? Colors.black
                                          : Colors.grey,
                                    ),
                                  ),
                                  Icon(Icons.remove, color: Colors.grey),
                                  Text(
                                    "${scoreModel.teamTwoScore}/${scoreModel.teamTwoWickets}",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w900,
                                      color: scoreModel.battingTeam ==
                                              scoreModel.teamTwoName
                                          ? Colors.black
                                          : Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                spacing: 12,
                                children: [
                                  Text("Over: ${scoreModel.over}"),
                                  Text(
                                    !scoreModel.isMatchRunning
                                        ? "Match Over"
                                        : "${scoreModel.innings}${scoreModel.innings == 1 ? 'st' : scoreModel.innings == 2 ? 'nd' : 'th'} innings",
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Row(
                            spacing: 4,
                            children: [
                              Text(
                                scoreModel.teamTwoShort,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              Image.network(
                                scoreModel.teamTwoLogo,
                                height: 40,
                              ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        spacing: 200,
                        children: [
                          Text(
                            scoreModel.sponsor,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                            ),
                          ),
                          Text(
                            scoreModel.location,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.fromBorderSide(
                    BorderSide(
                      width: 0.5,
                      color: Colors.grey,
                    ),
                  ),
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFFE8E6FB),
                      Colors.white,
                    ],
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      scoreModel.prizeMoney,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
