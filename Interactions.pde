// Flags para controle das teclas pressionadas
boolean upPressed = false;
boolean downPressed = false;
boolean leftPressed = false;
boolean rightPressed = false;

void keyPressed() {
  // Detecta pressionamento das teclas de direção
  if (key == CODED) {
    switch (keyCode) {
      case UP: upPressed = true; break;
      case DOWN: downPressed = true; break;
      case LEFT: leftPressed = true; break;
      case RIGHT: rightPressed = true; break;
    }
  } else if(key == ' ') {
    firePlayer(typeBulletPlayer); // Dispara balas ao pressionar a barra de espaço
  }
}

void keyReleased() {
  // Detecta liberação das teclas de direção
  if (key == CODED) {
    switch (keyCode) {
      case UP: upPressed = false; break;
      case DOWN: downPressed = false; break;
      case LEFT: leftPressed = false; break;
      case RIGHT: rightPressed = false; break;
    }
  }
}

// Função para verificar colisões
void checkCollisions() {
  // Verifica colisão das balas do jogador com o inimigo
  for (int i = 0; i < maxBulletsPlayer; i++) {
    if (playerBulletFired[i]) {
      if (dist(playerBullets[i].x, playerBullets[i].y, enemy.pos.x, enemy.pos.y) < size_enemy / 2) {
        enemy.isDeadFlag = true;
        playerBulletFired[i] = false; // Desativa a bala após a colisão
      }
    }
  }

  // Verifica colisão das balas do inimigo com o jogador
  for (int i = 0; i < maxBulletsEnemy; i++) {
    if (enemyBulletFired[i]) {
      if (dist(enemyBullets[i].x, enemyBullets[i].y, player.pos.x + size_player / 2, player.pos.y + size_player / 2) < size_player / 2) {
        player.isDeadFlag = true;
        enemyBulletFired[i] = false; // Desativa a bala após a colisão
      }
    }
  }

  // Verifica colisão entre jogador e inimigo
  if (dist(player.pos.x + size_player / 2, player.pos.y + size_player / 2, enemy.pos.x, enemy.pos.y) < (size_player + size_enemy) / 2) {
    player.isDeadFlag = true;
  }
}
