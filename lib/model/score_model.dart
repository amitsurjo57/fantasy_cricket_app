class ScoreModel {
  final String matchTitle;
  final String matchType;
  final String teamOneLogo;
  final String teamTwoLogo;
  final String teamOneShort;
  final String teamTwoShort;
  final String teamOneName;
  final String teamTwoName;
  final int teamOneScore;
  final int teamTwoScore;
  final int teamOneWickets;
  final int teamTwoWickets;
  final String sponsor;
  final String location;
  final String prizeMoney;
  final int innings;
  final String over;
  final String battingTeam;
  final bool isMatchRunning;

  ScoreModel({
    required this.matchTitle,
    required this.matchType,
    required this.teamOneLogo,
    required this.teamTwoLogo,
    required this.teamOneShort,
    required this.teamTwoShort,
    required this.teamOneName,
    required this.teamTwoName,
    required this.teamOneScore,
    required this.teamTwoScore,
    required this.teamOneWickets,
    required this.teamTwoWickets,
    required this.sponsor,
    required this.location,
    required this.prizeMoney,
    required this.innings,
    required this.over,
    required this.battingTeam,
    required this.isMatchRunning,
  });
}
