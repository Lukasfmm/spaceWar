// Definindo parâmetros de disparo e balas
int maxBulletsPlayer = 30; // Número máximo de balas do jogador
int maxBulletsEnemy = 10; // Número máximo de balas do inimigo
int fireInterval = 500; // Intervalo de disparo em milissegundos
int lastFireTime = 0; // Tempo do último disparo

float speed = 10.0; // Velocidade das balas
float bulletSize = 30.0; // Tamanho das balas

Bullet[] playerBullets = new Bullet[maxBulletsPlayer];
boolean[] playerBulletFired = new boolean[maxBulletsPlayer];

Bullet[] enemyBullets = new Bullet[maxBulletsEnemy];
boolean[] enemyBulletFired = new boolean[maxBulletsEnemy];

// Classe Bullet para gerenciar as balas
class Bullet {
  float x;
  float y;
  float size;
  PVector dir;

  Bullet(float size) {
    this.size = size;
    this.dir = new PVector(0, 1); // Direção padrão para baixo
  }

  void update(boolean typeUser) {
    if (typeUser) {
      y -= speed; // Move a bala para cima
    } else {
      x += dir.x * speed;
      y += dir.y * speed; // Move a bala de acordo com sua direção
    }
  }

  void display() {
    image(bulletImage, x, y - size, size, size); // Desenha a bala como imagem
  }
}

// Função para desenhar balas do jogador
void drawBulletsPlayer() {
  for (int i = 0; i < maxBulletsPlayer; i++) {
    if (playerBulletFired[i]) {
      playerBullets[i].update(true);
      playerBullets[i].display();
      if (playerBullets[i].y < 10 * border) playerBulletFired[i] = false; // Desativa a bala ao sair da tela
    }
  } 
}

// Função para disparar balas do jogador
void firePlayer(int typeBullet) {
  int bulletsToFire = typeBullet;
  
  for (int i = 0; i < maxBulletsPlayer && bulletsToFire > 0; i++) {
    if (!playerBulletFired[i]) {
      playerBullets[i].x = player.pos.x + size_player / 2;
      playerBullets[i].y = player.pos.y;

      // Ajusta a posição para disparos múltiplos
      if (typeBullet == 2) {
        playerBullets[i].x += (bulletsToFire == 2) ? -size_player / 2 : size_player / 2;
      } else if (typeBullet == 3) {
        if (bulletsToFire == 3) playerBullets[i].x -= size_player / 2;
        if (bulletsToFire == 1) playerBullets[i].x += size_player / 2;
      }

      playerBulletFired[i] = true;
      bulletsToFire--;
    }
  }
}

// Função para desenhar balas do inimigo
void drawBulletsEnemy() {
  for (int i = 0; i < maxBulletsEnemy; i++) {
    if (enemyBulletFired[i]) {
      enemyBullets[i].update(false);
      enemyBullets[i].display();
      if (enemyBullets[i].y > height) enemyBulletFired[i] = false; // Desativa a bala ao sair da tela
    }
  }
}

// Função para disparar balas do inimigo
void fireEnemy(int typeBullet) {
  int bulletsToFire = typeBullet;

  for (int i = 0; i < maxBulletsEnemy && bulletsToFire > 0; i++) {
    if (!enemyBulletFired[i]) {
      enemyBullets[i].x = enemy.pos.x;
      enemyBullets[i].y = enemy.pos.y + size_enemy / 2;
      enemyBullets[i].dir = new PVector(0, 1); // Direção reta para baixo

      // Ajusta a posição para disparos múltiplos
      if (typeBullet == 2) {
        enemyBullets[i].x += (bulletsToFire == 2) ? -size_enemy / 2 : size_enemy / 2;
      } else if (typeBullet == 3) {
        if (bulletsToFire == 3) enemyBullets[i].x -= size_enemy / 2;
        if (bulletsToFire == 1) enemyBullets[i].x += size_enemy / 2;
      }

      enemyBulletFired[i] = true;
      bulletsToFire--;
    }
  }
}
