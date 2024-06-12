// Instância do inimigo
float size_enemy = 150.0; // Tamanho do inimigo
float baseEnemySpeed = 2.0; // Velocidade base do movimento do inimigo
float enemySpeed = baseEnemySpeed; // Velocidade do inimigo ajustada pelo nível
Enemy enemy;

// Classe Enemy para gerenciar o inimigo
class Enemy {
  PVector pos;
  float size_enemy;
  boolean isDeadFlag = false;

  Enemy(float x, float y, float size_enemy) {
    this.pos = new PVector(x, y);
    this.size_enemy = size_enemy;
  }

  void display() {
    // Desenha o inimigo com base no nível de dificuldade
    switch (difficultyLevel) {
      case 1:
        image(enemyEasyImage, pos.x - size_enemy / 2, pos.y - size_enemy / 2, size_enemy, size_enemy);
        break;
      case 2:
        image(enemyMediumImage, pos.x - size_enemy / 2, pos.y - size_enemy / 2, size_enemy, size_enemy);
        break;
      case 3:
        image(enemyHardImage, pos.x - size_enemy / 2, pos.y - size_enemy / 2, size_enemy, size_enemy);
        break;
    }
  }

  void move() {
    pos.x += enemySpeed;
    if (pos.x < size_enemy || pos.x > width - size_enemy) {
      enemySpeed *= -1; // Inverte a direção ao atingir a borda
    }
  }
  
  boolean isDead() {
    return isDeadFlag;
  }
}
