class Curse {
  Curse({
    this.curse1 = 0,
    this.curse2 = 0,
    this.curse3 = 0,
    this.curse4 = 0,
    this.curse5 = 0,
  });

  int curse1;
  int curse2;
  int curse3;
  int curse4;
  int curse5;

  int total() {
    return curse1 + curse2 + curse3 + curse4 + curse5;
  }
}

class Game {
  Game({
    this.round = 0,
    this.newList,
    this.artifactX = 0,
    this.artifactY = 0,
  });

  int round;
  Curse? newList;
  int artifactX;
  int artifactY;
}

class Round {
  Round({
    this.gems = 0,
    this.curse,
    this.artifactX = 0,
    this.artifactY = 0,
    this.remainGem = 0,
  });
  int gems;
  Curse? curse;
  int artifactX;
  int artifactY;
  int remainGem;
}

enum Room {
  gems,
  curse1,
  curse2,
  curse3,
  curse4,
  curse5,
  artifactX,
  artifactY,
}

class Player {
  Player({
    required this.id,
    required this.name,
    this.onHandGems = 0,
    this.totalGems = 0,
    this.artifactX = 0,
    this.artifactY = 0,
    required this.decisions,
  });

  String id;
  String name;
  int onHandGems;
  int totalGems;
  int artifactX;
  int artifactY;
  List<bool> decisions;
}
