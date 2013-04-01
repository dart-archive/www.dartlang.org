class Player {
  
}

class PlayerFactory {
  CreatePlayer(){}
}

class Game {
  Player player;

  Game(PlayerFactory playerFactory) {
    player = playerFactory.CreatePlayer();
  }
}

void main() {}