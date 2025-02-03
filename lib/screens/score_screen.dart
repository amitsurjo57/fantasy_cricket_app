import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fantasy_cricket_app/model/score_model.dart';
import 'package:fantasy_cricket_app/screens/match_details_screen.dart';
import 'package:fantasy_cricket_app/widgets/score_widget.dart';
import 'package:flutter/material.dart';

class ScoreScreen extends StatefulWidget {
  const ScoreScreen({super.key});

  @override
  State<ScoreScreen> createState() => _ScoreScreenState();
}

class _ScoreScreenState extends State<ScoreScreen> {
  final List<ScoreWidget> _listOfMatch = [];

  String? _currentValue = "All";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('cricket').snapshots(),
          builder: (context, snapshot) {
            _listOfMatch.clear();

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            if (_currentValue == "All") {
              _addAllMatch(snapshot);
            } else {
              _addSpecificMatch(snapshot);
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 16,
              children: [
                _header(),
                Expanded(
                  child: Visibility(
                    visible: _listOfMatch.isNotEmpty,
                    replacement: Center(
                      child: Text(
                        "No Live Matches",
                        style: TextStyle(fontSize: 24),
                      ),
                    ),
                    child: ListView.separated(
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 16),
                      itemCount: _listOfMatch.length,
                      itemBuilder: (context, index) => GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MatchDetailsScreen(
                                scoreModel: _listOfMatch[index].scoreModel,
                              ),
                            ),
                          );
                        },
                        child: _listOfMatch[index],
                      ),
                    ),
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }

  void _addSpecificMatch(AsyncSnapshot<QuerySnapshot<Object?>> snapshot) {
    for (DocumentSnapshot snap in snapshot.data?.docs ?? []) {
      if (snap.get('isMatchRunning') &&
          snap.get('matchType') == _currentValue) {
        _listOfMatch.add(
          ScoreWidget(
            scoreModel: ScoreModel(
              matchTitle: snap.id,
              matchType: snap.get('matchType'),
              teamOneLogo: snap.get('teamOneLogo'),
              teamTwoLogo: snap.get('teamTwoLogo'),
              teamOneShort: snap.get('teamOneShort'),
              teamTwoShort: snap.get('teamTwoShort'),
              teamOneName: snap.get('teamOneName'),
              teamTwoName: snap.get('teamTwoName'),
              teamOneScore: snap.get('teamOneScore'),
              teamTwoScore: snap.get('teamTwoScore'),
              teamOneWickets: snap.get('teamOneWickets'),
              teamTwoWickets: snap.get('teamTwoWickets'),
              sponsor: snap.get('sponsor'),
              location: snap.get('location'),
              prizeMoney: snap.get('prizeMoney'),
              innings: snap.get('innings'),
              over: snap.get('over'),
              battingTeam: snap.get('battingTeam'),
              isMatchRunning: snap.get('isMatchRunning'),
            ),
          ),
        );
      }
    }
  }

  void _addAllMatch(AsyncSnapshot<QuerySnapshot<Object?>> snapshot) {
    for (DocumentSnapshot snap in snapshot.data?.docs ?? []) {
      if (snap.get('isMatchRunning')) {
        _listOfMatch.add(
          ScoreWidget(
            scoreModel: ScoreModel(
              matchTitle: snap.id,
              matchType: snap.get('matchType'),
              teamOneLogo: snap.get('teamOneLogo'),
              teamTwoLogo: snap.get('teamTwoLogo'),
              teamOneShort: snap.get('teamOneShort'),
              teamTwoShort: snap.get('teamTwoShort'),
              teamOneName: snap.get('teamOneName'),
              teamTwoName: snap.get('teamTwoName'),
              teamOneScore: snap.get('teamOneScore'),
              teamTwoScore: snap.get('teamTwoScore'),
              teamOneWickets: snap.get('teamOneWickets'),
              teamTwoWickets: snap.get('teamTwoWickets'),
              sponsor: snap.get('sponsor'),
              location: snap.get('location'),
              prizeMoney: snap.get('prizeMoney'),
              innings: snap.get('innings'),
              over: snap.get('over'),
              battingTeam: snap.get('battingTeam'),
              isMatchRunning: snap.get('isMatchRunning'),
            ),
          ),
        );
      }
    }
  }

  Row _header() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "$_currentValue Matches",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        Card(
          elevation: 4,
          child: DropdownButton(
            value: _currentValue,
            alignment: Alignment.center,
            dropdownColor: Colors.grey.shade300,
            onChanged: (index) {
              setState(() {
                _currentValue = index;
              });
            },
            items: [
              DropdownMenuItem(
                value: 'All',
                child: Text("All"),
              ),
              DropdownMenuItem(
                value: 'One Day',
                child: Text("One Day"),
              ),
              DropdownMenuItem(
                value: 'T20',
                child: Text("T20"),
              ),
              DropdownMenuItem(
                value: 'Test',
                child: Text("Test"),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
