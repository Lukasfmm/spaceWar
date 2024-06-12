void gameplay() {
  background(backgroundImage); // Desenha o fundo do jogo
  
  if (score < 0) {
    score = 0;
  } // Prevenindo pontuação negativa

  rect(0, 0, width, 8*border);

  // Exibe contador de vida e pontuação
  pushMatrix();
  fill(0);
  textSize(30);
  textAlign(RIGHT, CENTER);
  text("Enemy Life: " + enemyLifeCount, width - border, 4 * border);
  textAlign(CENTER, CENTER);
  text("Score: " + score, width/2, 4 * border);
  textAlign(LEFT, CENTER);
  text("Player Life: " + playerLifeCount, border, 4 * border);
  popMatrix();

  fill(255);

  // Atualiza e desenha o jogador
  player.display();
  player.move();
  drawBulletsPlayer();

  if (player.isDead()) {
    if (playerLifeCount == 1) {
      image(gameOverImage, 0, 0, width, height);
      screenState=0;
    } else {
      playerLifeCount -= 1;
      score -= scoreShrinking;
    }
  } else {
    // Atualiza e desenha o inimigo
    enemy.display();
    enemy.move();
    drawBulletsEnemy();

    if (enemy.isDead()) {
      enemy.isDeadFlag = false; // "Revive" o inimigo sem reposicionar
      enemyLifeCount--;
      score += scoreIncrease;

      if (enemyLifeCount == 0) {
        image(victoryImage, 0, 0, width, height);
        screenState=0;
      } else {
        level += 1;
      }

      enemySpeed = baseEnemySpeed + (level - 1) * startSpeed; // Aumenta a velocidade do inimigo
    }
  }

  checkCollisions(); // Verifica colisões

  // Disparo automático do inimigo com intervalo
  if (millis() - lastFireTime >= fireInterval) {
    fireEnemy(typeBulletEnemy); // Dispara bala do inimigo
    lastFireTime = millis();
  }
}
