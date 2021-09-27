import 'data.dart';
import 'dart:math';

void initiateGame() {
  int players = 4;
  print("The game with start with $players players.");

  Game game = new Game(
    round: 1,
  );
  Curse curse = Curse(
    curse1: 3,
    curse2: 3,
    curse3: 3,
    curse4: 3,
    curse5: 3,
  );
  game.newList = curse;
  Round round = new Round(curse: curse);
  List<Player> playerList = [];
  for (int i = 0; i < players; i++) {
    playerList
        .add(new Player(id: i.toString(), name: "Player $i", decisions: []));
  }
  Map<Round, List<Player>> roundMap = {round: playerList};

  for (int i = 1; i < 6; i++) {
    roundMap = initiateRound(
      i,
      round.artifactX,
      round.artifactY,
      round.curse!,
      players,
      playerList,
    );
    round = roundMap.keys.first;
    playerList = roundMap.values.first;
  }
}

List<Room> shuffle(List<Room> items) {
  var random = new Random();

  // Go through all elements.
  for (var i = items.length - 1; i > 0; i--) {
    // Pick a pseudorandom number according to the list length
    var n = random.nextInt(i + 1);

    var temp = items[i];
    items[i] = items[n];
    items[n] = temp;
  }

  return items;
}

int gems() {
  Random random = new Random();
  return random.nextInt(16) + 1;
}

List<bool> actions() {
  Random random = new Random();
  List<bool> action = [];
  for (int i = 0; i < 35; i++) {
    int bool = random.nextInt(1);
    if (bool == 0) {
      action.add(false);
    } else {
      action.add(true);
    }
  }
  return action;
}

Map<Round, List<Player>> initiateRound(
  int roundCount,
  int artifactX,
  int artifactY,
  Curse curse,
  int players,
  List<Player> playersList,
) {
  print('Round $roundCount!');
  List<Room> room = [];
  Round round = new Round();
  Curse roundCurse = new Curse();
  int remainCurse = curse.total();
  int count = 15 + remainCurse + artifactX + artifactY;
  for (int i = 0; i < 15; i++) {
    room.add(Room.gems);
  }

  for (int i = 0; i < remainCurse; i++) {
    for (int i = 0; i < curse.curse1; i++) {
      room.add(Room.curse1);
    }
    for (int i = 0; i < curse.curse2; i++) {
      room.add(Room.curse2);
    }
    for (int i = 0; i < curse.curse3; i++) {
      room.add(Room.curse3);
    }
    for (int i = 0; i < curse.curse4; i++) {
      room.add(Room.curse4);
    }
    for (int i = 0; i < curse.curse5; i++) {
      room.add(Room.curse5);
    }
  }

  for (int i = 0; i < artifactX; i++) {
    room.add(Room.artifactX);
  }

  for (int i = 0; i < artifactY; i++) {
    room.add(Room.artifactY);
  }

  if (roundCount > 0 && roundCount < 4) {
    room.add(Room.artifactX);
  } else if (roundCount == 4 || roundCount == 5) {
    room.add(Room.artifactY);
  }

  //Shuffle the room
  room = shuffle(room);

  //Shuffle the actions
  for (int i = 0; i < players; i++) {
    playersList[i].decisions = actions();
  }

  //Print the room
  print("The room is: ");
  int remainingPlayer = players;
  List<int> remainingPlayerList = [];
  for (int i = 0; i < players; i++) {
    remainingPlayerList.add(i);
  }

  for (int i = 0; i < count; i++) {
    int quitPlayer = 0;
    List<int> quitPlayerList = [];

    for (int i = 0; i < players; i++) {
      if (playersList[remainingPlayerList[i]].decisions == true) {
        remainingPlayer++;
        remainingPlayerList.add(i);
      } else {
        quitPlayer++;
        quitPlayerList.add(i);
        print("Player $i quitted");
      }
    }

    for (int i = 0; i < quitPlayer; i++) {
      playersList[i].totalGems +=
          (round.remainGem / quitPlayer).floor() + playersList[i].onHandGems;
    }

    round.remainGem -= (round.remainGem / quitPlayer).floor();

    switch (room[i]) {
      case Room.gems:
        round.gems += 1;
        int gem = gems();
        int remainGem = gem % remainingPlayer;
        round.remainGem += remainGem;
        print("There are $gem gems");
        print("Each player get ${(gem / remainingPlayer).floor()}");
        remainingPlayerList.forEach((element) {
          playersList[element].onHandGems += (gem / remainingPlayer).floor();
        });
        print("Remains ${remainGem} gems");
        break;
      case Room.curse1:
        roundCurse.curse1 += 1;
        break;
      case Room.curse2:
        roundCurse.curse2 += 1;
        break;
      case Room.curse3:
        roundCurse.curse3 += 1;
        break;
      case Room.curse4:
        roundCurse.curse4 += 1;
        break;
      case Room.curse5:
        roundCurse.curse5 += 1;
        break;
      case Room.artifactX:
        round.artifactX += 1;
        break;
      case Room.artifactY:
        round.artifactY += 1;
        break;
    }
    print(room[i]);
    round.curse = roundCurse;
    if (roundCurse.curse1 >= 2) {
      print("End by curse1");
      break;
    }
    if (roundCurse.curse2 >= 2) {
      print("End by curse2");
      break;
    }
    if (roundCurse.curse3 >= 2) {
      print("End by curse3");
      break;
    }
    if (roundCurse.curse4 >= 2) {
      print("End by curse4");
      break;
    }
    if (roundCurse.curse5 >= 2) {
      print("End by curse5");
      break;
    }
  }
  print(
      "There are ${round.remainGem} gems left and ${round.artifactX} Artifact X and ${round.artifactY} Artifact Y");
  for (int i = 0; i < players; i++) {
    print("Player ${i + 1} has ${playersList[i].totalGems} gems");
  }
  Map<Round, List<Player>> roundMap = {round: playersList};
  return roundMap;
}

int main() {
  initiateGame();
  return 0;
}
