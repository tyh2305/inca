import "dart:ui";

// Multiplayer module

class Player {
  String userid;

  Player({
    required this.userid,
  });

  String? get username {
    // Get name using userid
    for (final explorer in ExplorersId.values) {
      if (userid == explorer.toString()) {
        return Explorers.values[getExplorerIndex(explorer.toString())]
            .toString();
      }
    }
  }

  bool get isReady {
    // Get player is ready
    for (final explorer in ExplorersId.values) {
      if (userid == explorer.toString()) {
        return true;
      }
    }

    return false;
  }
}

enum Explorers { Albert, Zemo, Jones }
enum ExplorersId { A123, Z321, J654 }

int getExplorerIndex(String explorer) {
  for (int i = 0; i < Explorers.values.length; i++) {
    if (explorer == Explorers.values[i].toString()) {
      return i;
    }
  }
  return -1;
}

class Room {
  // List of players
  List<Player> players;

  // Host of the room
  Player host;

  // isPublic boolean flag
  bool isPublic;

  // 4 digit numbers
  Color roomId;

  // Initialize ready list
  List<Map<Player, bool>> get initReadyList {
    List<Map<Player, bool>> readyList = [];
    for (final player in players) {
      Map<Player, bool> readyMap = new Map();

      readyMap = {
        player: player.isReady,
      };

      readyList[playerIndex(player)] = readyMap;
    }
    return readyList;
  }

  Room({
    required this.host,
    required this.roomId,
    required this.players,
    this.isPublic = true,
  });

  int playerIndex(
    Player player,
  ) {
    return players.indexOf(player);
  }

  // Future approach:
  // Type of room, numbers of player, sharable link
  Room? initRoom(Player player) {
    List<Player> list = [player];

    // generate id from service
    Color roomId = Color(123456);

    Room room = new Room(
      roomId: roomId,
      players: list,
      host: player,
    );

    return room;
  }

  void endRoom() {
    // Send info to service handler
  }

  void isEmpty() {
    // If host left or room is empty execute end room
    if (this.players.length < 0 || this.players.indexOf(this.host) == -1) {
      endRoom();
    }
  }

  void addExplorer(List<int> difficulty) {
    for (int i = 0; i < difficulty.length; i++) {
      switch (difficulty[i]) {
        case 1:
          this.players.add(new Player(userid: ExplorersId.A123.toString()));
          break;
        case 2:
          this.players.add(new Player(userid: ExplorersId.Z321.toString()));
          break;
        case 3:
          this.players.add(new Player(userid: ExplorersId.J654.toString()));
          break;
      }
    }
  }
}

// Game module

class Curse {
  List<int> curse;

  Curse({
    required this.curse,
  });

  int get total {
    return curse.length;
  }

  void initCurse(int quantity) {
    for (int i = 0; i < quantity; i++) {
      curse.add(3);
    }
  }
}

class Artifact {
  int value;
  String label;

  Artifact({
    required this.value,
    required this.label,
  });
}

class Game {
  int round;
  Curse curseList;
  List<Artifact> artifactList;
  int gemRooms;

  Game({
    required this.round,
    required this.curseList,
    this.artifactList = const [],
    this.gemRooms = 15,
  });
}

class Round {
  int gems;
  Curse curse;
  List<Artifact> artifactList;
  int remainingGem;
  int roundId;

  Round({
    required this.roundId,
    required this.gems,
    required this.curse,
    required this.artifactList,
    required this.remainingGem,
  });
}

enum Levels {
  gems,
  curse,
  artifact,
}

class Adventurer {
  String userid;
  int totalGems;
  int onHandGems;
  List<Artifact> artifact;
  Map<int, bool> decision;
  bool returned;

  Adventurer({
    required this.userid,
    this.totalGems = 0,
    this.onHandGems = 0,
    this.artifact = const [],
    this.decision = const {},
    this.returned = false,
  });
}
