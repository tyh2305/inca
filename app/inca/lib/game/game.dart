import 'package:inca/model/gameModel.dart';
import 'dart:math';

Game inititalizeGame() {
  Curse curse = new Curse(
    curse: const [],
  );
  curse.initCurse(5);

  Game game = new Game(
    round: 1,
    curseList: curse,
  );

  return game;
}

List<Levels> generateLevels(
  Curse curselist,
  List<Artifact> artifactlist,
  int gemRooms,
  int round,
) {
  List<Levels> levels = [];
  int totalLevels = gemRooms + curselist.total;
  if (round > 3) {
    totalLevels += artifactlist.length;
  }

  for (int i = 0; i < totalLevels; i++) {
    int randomNumber = Random().nextInt(totalLevels);
    if (round > 3 && artifactlist.length > 0) {
      int flag = randomNumber % 3;
      switch (flag) {
        case 0:
          levels.add(Levels.gems);
          break;
        case 1:
          levels.add(Levels.curse);
          break;
        case 2:
          levels.add(Levels.artifact);
          break;
      }
    } else {
      int flag = randomNumber % 2;
      switch (flag) {
        case 0:
          levels.add(Levels.gems);
          break;
        case 1:
          levels.add(Levels.curse);
          break;
      }
    }
  }
  return levels;
}

int generateCurse(Curse curseList) {
  int curse = Random().nextInt(curseList.curse.length);
  while (curseList.curse[curse] < 1) {
    curse = Random().nextInt(curseList.curse.length);
  }
  return curse;
}

int generateGem() {
  List<int> gemList = [
    1,
    1,
    2,
    3,
    5,
    8,
    13,
    21,
  ];

  return gemList[Random().nextInt(gemList.length)];
}

int divideGem(int activeAdventurer, int gemsCount) {
  int gem = (gemsCount / activeAdventurer).floor();
  return gem;
}

bool isRoundOver(
  int activePlayer,
  Curse encounteredCurse,
  List<Levels> levels,
) {
  if (activePlayer == 0 || levels.isEmpty) {
    return true;
  }

  for (final curse in encounteredCurse.curse) {
    if (curse >= 2) {
      return true;
    }
  }

  return false;
}

String winner(List<Adventurer> playerList) {
  Adventurer winner = playerList[0];
  String returnText = "";
  for (Adventurer player in playerList) {
    int playerArtifacts = 0;
    for (Artifact artifact in player.artifact) {
      playerArtifacts += artifact.value;
    }

    int winnerArtifacts = 0;
    for (Artifact artifact in winner.artifact) {
      winnerArtifacts += artifact.value;
    }

    int playerScore = playerArtifacts + player.totalGems;
    int winnerScore = winnerArtifacts + winner.totalGems;

    if (playerScore > winnerScore) {
      winner = player;
    } else if (playerScore == winnerScore) {
      if (playerArtifacts > winnerArtifacts) {
        winner = player;
      } else if (playerArtifacts == winnerArtifacts) {
        returnText = "Tie:${player.userid}:${winner.userid}";
      }
    }
  }
  if(returnText != ""){
    return returnText;
  }
  return winner.userid;
}
