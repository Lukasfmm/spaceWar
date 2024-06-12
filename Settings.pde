// Variáveis para tipos de balas e configurações de dificuldade
int typeBulletPlayer;
int typeBulletEnemy;
float startSpeed;
int playerLifeCount;
int enemyLifeCount;
int scoreIncrease;
int scoreShrinking;

// Função para definir o nível de dificuldade
void choiceDifficultyLevel (int difficultyLevel) {
  switch (difficultyLevel) {
    case 1: 
      typeBulletPlayer = 3; 
      typeBulletEnemy = 1;
      startSpeed = 0.2;
      playerLifeCount = 5;
      enemyLifeCount = 20;
      scoreIncrease = enemyLifeCount;
      scoreShrinking = playerLifeCount;
      break;
    case 2: 
      typeBulletPlayer = 2; 
      typeBulletEnemy = 2; 
      startSpeed = 0.5;
      playerLifeCount = 5;
      enemyLifeCount = 15;
      scoreIncrease = enemyLifeCount;
      scoreShrinking = playerLifeCount;
      break;
    case 3: 
      typeBulletPlayer = 1; 
      typeBulletEnemy = 3; 
      startSpeed = 0.8;
      playerLifeCount = 5;
      enemyLifeCount = 10;
      scoreIncrease = enemyLifeCount;
      scoreShrinking = playerLifeCount;
      break;
  }   
}
