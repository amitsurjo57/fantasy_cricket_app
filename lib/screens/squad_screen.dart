import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fantasy_cricket_app/model/score_model.dart';
import 'package:fantasy_cricket_app/widgets/left_player_squad_widget.dart';
import 'package:fantasy_cricket_app/widgets/right_player_squad_widget.dart';
import 'package:flutter/material.dart';

class SquadScreen extends StatelessWidget {
  final ScoreModel scoreModel;

  const SquadScreen({super.key, required this.scoreModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<DocumentSnapshot>(
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

          final squads = snapshot.data?.get('match')['Squads'] ?? {};

          final team1 = squads['team1'] ?? [];
          final team2 = squads['team2'] ?? [];

          return Column(
            children: [
              _header(),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 2,
                      child: ListView.separated(
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 16),
                        itemCount: team1.length,
                        itemBuilder: (context, index) {
                          return LeftPlayerSquadWidget(
                            image: team1[index]['image'],
                            name: team1[index]['name'],
                            form: team1[index]['form'],
                          );
                        },
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: ListView.separated(
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 16),
                        itemCount: team2.length,
                        itemBuilder: (context, index) {
                          return RightPlayerSquadWidget(
                            image: team2[index]['image'],
                            name: team2[index]['name'],
                            form: team2[index]['form'],
                          );
                        },
                      ),
                    ),
                  ],
                ),
              )
            ],
          );
        },
      ),
    );
  }

  Container _header() {
    return Container(
      color: Colors.blue.shade50,
      width: double.infinity,
      height: 60,
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            spacing: 8,
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
          Row(
            spacing: 8,
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
    );
  }
}
