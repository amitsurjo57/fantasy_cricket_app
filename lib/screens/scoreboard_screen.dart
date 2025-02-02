import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fantasy_cricket_app/model/score_model.dart';
import 'package:fantasy_cricket_app/utils/app_utils.dart';
import 'package:fantasy_cricket_app/widgets/batter_widget.dart';
import 'package:fantasy_cricket_app/widgets/bowler_widget.dart';
import 'package:flutter/material.dart';

class ScoreboardScreen extends StatelessWidget {
  final ScoreModel scoreModel;

  const ScoreboardScreen({super.key, required this.scoreModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance
              .collection('cricket')
              .doc(scoreModel.matchTitle)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            final scoreBoard = snapshot.data?.get('match')['Scoreboard'] ?? {};

            final firstInnings = scoreBoard['1st innings'] ?? [];

            final secondInnings = scoreBoard['2nd innings'] ?? [];

            return SingleChildScrollView(
              child: Column(
                children: [
                  _firstInningsTile(firstInnings),
                  Divider(
                    color: Colors.grey.shade300,
                    height: 20,
                    thickness: 20,
                  ),
                  _secondInningsTile(secondInnings),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  ExpansionTile _secondInningsTile(secondInnings) {
    return ExpansionTile(
      initiallyExpanded: true,
      title: const Text('2nd innings'),
      collapsedBackgroundColor: AppUtils.loaderColor,
      children: [
        _batterHeader(),
        for (int i = 0; i < secondInnings['Batsman'].length; i++)
          BatterWidget(
            name: secondInnings['Batsman'][i]['name'],
            run: secondInnings['Batsman'][i]['run'],
            ballPlayed: secondInnings['Batsman'][i]['ballPlayed'],
            four: secondInnings['Batsman'][i]['4s'],
            six: secondInnings['Batsman'][i]['6s'],
            bowler: secondInnings['Batsman'][i]['bowler'],
            out: secondInnings['Batsman'][i]['out'],
          ),
        _yetToBat(secondInnings['yet to bat']),
        _extraRun(secondInnings['extra']),
        _totalRun(
          run: secondInnings['battingTeam'] == scoreModel.teamOneName
              ? scoreModel.teamOneScore
              : scoreModel.teamTwoScore,
          over: scoreModel.over,
          wicket: secondInnings['battingTeam'] == scoreModel.teamOneName
              ? scoreModel.teamOneWickets
              : scoreModel.teamTwoWickets,
        ),
        _bowlerHeader(),
        for (int i = 0; i < secondInnings['Bowler'].length; i++)
          BowlerWidget(
            name: secondInnings['Bowler'][i]['name'],
            over: secondInnings['Bowler'][i]['over'],
            maiden: secondInnings['Bowler'][i]['maiden'],
            run: secondInnings['Bowler'][i]['run'],
            wicket: secondInnings['Bowler'][i]['wicket'],
            economy: secondInnings['Bowler'][i]['economy'],
          ),
      ],
    );
  }

  ExpansionTile _firstInningsTile(firstInnings) {
    return ExpansionTile(
      initiallyExpanded: true,
      title: const Text('1st innings'),
      collapsedBackgroundColor: AppUtils.loaderColor,
      children: [
        _batterHeader(),
        for (int i = 0; i < firstInnings['Batsman'].length; i++)
          BatterWidget(
            name: firstInnings['Batsman'][i]['name'],
            run: firstInnings['Batsman'][i]['run'],
            ballPlayed: firstInnings['Batsman'][i]['ballPlayed'],
            four: firstInnings['Batsman'][i]['4s'],
            six: firstInnings['Batsman'][i]['6s'],
            bowler: firstInnings['Batsman'][i]['bowler'],
            out: firstInnings['Batsman'][i]['out'],
          ),
        _yetToBat(firstInnings['yet to bat']),
        _extraRun(firstInnings['extra']),
        _totalRun(
          run: firstInnings['battingTeam'] == scoreModel.teamOneName
              ? scoreModel.teamOneScore
              : scoreModel.teamTwoScore,
          over: scoreModel.over,
          wicket: firstInnings['battingTeam'] == scoreModel.teamOneName
              ? scoreModel.teamOneWickets
              : scoreModel.teamTwoWickets,
        ),
        _bowlerHeader(),
        for (int i = 0; i < firstInnings['Bowler'].length; i++)
          BowlerWidget(
            name: firstInnings['Bowler'][i]['name'],
            over: firstInnings['Bowler'][i]['over'],
            maiden: firstInnings['Bowler'][i]['maiden'],
            run: firstInnings['Bowler'][i]['run'],
            wicket: firstInnings['Bowler'][i]['wicket'],
            economy: firstInnings['Bowler'][i]['economy'],
          ),
      ],
    );
  }

  Container _batterHeader() {
    return Container(
      color: Colors.blue.shade50,
      width: double.infinity,
      height: 60,
      alignment: Alignment.center,
      child: ListTile(
        leadingAndTrailingTextStyle: const TextStyle(
          fontSize: 16,
          color: Colors.black,
        ),
        leading: const Text('Batter'),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          spacing: 30,
          children: [
            Text('R'),
            Text('B'),
            Text('4s'),
            Text('6s'),
            Text('SR'),
          ],
        ),
      ),
    );
  }

  Container _bowlerHeader() {
    return Container(
      color: Colors.blue.shade50,
      width: double.infinity,
      height: 60,
      alignment: Alignment.center,
      child: ListTile(
        leadingAndTrailingTextStyle: const TextStyle(
          fontSize: 16,
          color: Colors.black,
        ),
        leading: const Text('Bowler'),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          spacing: 30,
          children: [
            Text('O'),
            Text('M'),
            Text('R'),
            Text('W'),
            Text('ER'),
          ],
        ),
      ),
    );
  }

  Widget _yetToBat(ytb) {
    return SizedBox(
      width: double.infinity,
      height: 60,
      child: ListTile(
        leadingAndTrailingTextStyle: const TextStyle(
          fontSize: 16,
          color: Colors.black,
          fontWeight: FontWeight.w900,
        ),
        leading: const Text("Yet to Bat"),
        title: Align(
          alignment: Alignment.centerRight,
          child: SizedBox(
            width: 200,
            child: SingleChildScrollView(
              child: Text("$ytb"),
            ),
          ),
        ),
      ),
    );
  }

  Widget _extraRun(extra) {
    return SizedBox(
      width: double.infinity,
      height: 60,
      child: ListTile(
        leadingAndTrailingTextStyle: const TextStyle(
          fontSize: 16,
          color: Colors.black,
          fontWeight: FontWeight.w900,
        ),
        leading: const Text("Extras"),
        title: Align(
          alignment: Alignment.centerRight,
          child: Text("$extra"),
        ),
      ),
    );
  }

  double _calculateCurrentRunRate(run, over) {
    double myOver = double.parse(over);
    var remainder = myOver % 10;
    var totalBall = (myOver - remainder) * 6 + remainder;
    var crr = (run / totalBall) * 6;

    return crr;
  }

  Widget _totalRun({required run, required wicket, required over}) {
    return SizedBox(
      width: double.infinity,
      height: 60,
      child: ListTile(
        leadingAndTrailingTextStyle: const TextStyle(
          fontSize: 16,
          color: Colors.black,
          fontWeight: FontWeight.w900,
        ),
        leading: const Text('Total'),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          spacing: 30,
          children: [
            Text("$run-$wicket ($over)"),
            Text(
                'CRR: ${_calculateCurrentRunRate(run, over).toStringAsFixed(1)}'),
          ],
        ),
      ),
    );
  }
}
