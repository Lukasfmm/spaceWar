// Instância do jogador
float size_player = 150.0; // Tamanho do jogador
Player player;

// Classe Player para gerenciar o jogador
class Player {
  PVector pos;
  float size_player;
  boolean isDeadFlag = false;

  Player(float x, float y, float size_player) {
    this.pos = new PVector(x, y);
    this.size_player = size_player;
  }

  void display() {
    image(playerImage, pos.x, pos.y, size_player - border, size_player - border);
  }

  void move() {
    PVector delta = new PVector(0, 0);

    if (upPressed) delta.y -= step;
    if (downPressed) delta.y += step;
    if (leftPressed) delta.x -= step;
    if (rightPressed) delta.x += step;

    pos.add(delta);
    pos.x = constrain(pos.x, border, width - size_player);
    pos.y = constrain(pos.y, border, height - size_player);

    // Limitar movimento do jogador até a linha 10*border
    if (pos.y < 10 * border) {
      pos.y = 10 * border;
    }
  }
  
  boolean isDead() {
    if (isDeadFlag) {
      isDeadFlag = false;
      return true;
    }
    return false;
  }
}
