import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

// Definindo constantes e variáveis globais
float border = 10.0; // Margem da tela
float step = 5.0; // Passo de movimento do jogador
int level; // Nível atual do jogo
int score; // Pontuação do jogador
PImage backgroundImage, playerImage, bulletImage, enemyEasyImage, enemyMediumImage, enemyHardImage, gameOverImage, victoryImage; // Imagens usadas no jogo

PImage bgImage;
PImage newGameButton;
PImage newGameButtonHover;
PImage difficultiesButton;
PImage difficultiesButtonHover;
PImage creditsButton;
PImage creditsButtonHover;
PImage exitButton;
PImage Facil;
PImage facilHover;
PImage Medio;
PImage medioHover;
PImage Dificil;
PImage dificilHover;
PImage inimigoFacil;
PImage inimigoMedio;
PImage inimigoDificil;
PImage integrantes;
PImage historia;
PImage historiaHover;
PImage regras;
PImage regrasHover;
PImage controlestexto;
PImage textoHistoria;
PImage voltar;
PImage voltarHover;


Minim minim;
AudioPlayer bgMusic;
AudioPlayer menuClick;
AudioPlayer mouseHover;
AudioPlayer creditsTheme;
AudioPlayer gameStart;



int screenState = 0;
float volumebg = -15.0;
float volumeclick = -5.0;
float volumeHover = -15.0;
float volumeCredits = -20.0;
float volumeStart = -10.0;
float volumebg1 = 0.0;
boolean newGamehoverPlayed = false;
boolean dificultieshoverPlayed = false;
boolean creditshoverPlayed = false;
boolean historiahoverPlayed = false;
boolean regrashoverPlayed = false;
boolean facilhoverPlayed = false;
boolean mediohoverPlayed = false;
boolean dificilhoverPlayed = false;
int difficultyLevel = 1;
int lastClickTime = 0;

//Inicia o programa --------------------------------------------------------------------------------------------

void setup() {
  size(1024, 1024); // Tamanho da janela do jogo

  score = 0; // Inicializa a pontuação

  // Carregar imagens
  backgroundImage = loadImage("background.jpeg");
  playerImage = loadImage("Player.png");
  bulletImage = loadImage("tiroUnico.png");
  enemyEasyImage = loadImage("inimigoFacil.png");
  enemyMediumImage = loadImage("inimigoMedio.png");
  enemyHardImage = loadImage("inimigoDificil.png");
  gameOverImage = loadImage("gameOver1.jpeg");
  victoryImage = loadImage("victoryScreen.jpeg");

  level = 1; // Inicializa o nível

  // Criando o inimigo e o jogador
  enemy = new Enemy(border + size_enemy, 10 * border + size_enemy / 2, size_enemy);
  player = new Player(width / 2 - size_player / 2, height - border, size_player);

  // Inicializando balas do jogador
  for (int i = 0; i < maxBulletsPlayer; i++) {
    playerBullets[i] = new Bullet(bulletSize);
    playerBulletFired[i] = false;
  }

  // Inicializando balas do inimigo
  for (int i = 0; i < maxBulletsEnemy; i++) {
    enemyBullets[i] = new Bullet(bulletSize);
    enemyBulletFired[i] = false;
  }

  minim = new Minim(this);

  bgMusic = minim.loadFile("menuTheme.mp3");
  bgMusic.loop(); // Tocar a música em loop
  bgMusic.setGain(volumebg);

  menuClick = minim.loadFile("menuClick.mp3");
  menuClick.setGain(volumeclick);

  mouseHover = minim.loadFile("mouseHoverSound.mp3");
  mouseHover.setGain(volumeHover);

  gameStart = minim.loadFile("gameStart.mp3");

  // Carregar as imagens
  bgImage = loadImage("background.jpeg");
  newGameButton = loadImage("iniciarJogo.png");
  newGameButtonHover = loadImage("iniciarJogoHover.png");
  difficultiesButton = loadImage("Dificuldades.png");
  difficultiesButtonHover = loadImage("DificuldadesHover.png");
  creditsButton = loadImage("Creditos.png");
  creditsButtonHover = loadImage("CreditosHover.png");
  Facil = loadImage("Facil.png");
  facilHover = loadImage("facilHover.png");
  Medio = loadImage("Medio.png");
  medioHover = loadImage("medioHover.png");
  Dificil = loadImage("Dificil.png");
  dificilHover = loadImage("dificilHover.png");
  inimigoFacil = loadImage("inimigoFacil.png");
  inimigoMedio = loadImage("inimigoMedio.png");
  inimigoDificil = loadImage("inimigoDificil.png");
  integrantes = loadImage("Integrantes.png");
  historia = loadImage("Historia.png");
  historiaHover = loadImage("historiaHover.png");
  regras = loadImage("regras.png");
  regrasHover = loadImage("regrasHover.png");
  controlestexto = loadImage("controlestexto.png");
  textoHistoria = loadImage("textoHistoria.png");
  voltar = loadImage("voltar.png");
  voltarHover = loadImage("voltarHover.png");


  inimigoDificil.resize(100, 116);
  inimigoMedio.resize(100, 116);
  inimigoFacil.resize(100, 116);
  integrantes.resize(800, 215);
  newGameButton.resize(400, 64);
  newGameButtonHover.resize(400, 64);
  difficultiesButton.resize(450, 52);
  difficultiesButtonHover.resize(450, 52);
  creditsButton.resize(300, 57);
  creditsButtonHover.resize(300, 57);
  historia.resize(300, 59);
  historiaHover.resize(300, 59);
  regras.resize(660, 70);
  regrasHover.resize(660, 70);
  textoHistoria.resize(880, 155);
  controlestexto.resize(880, 303);
  voltar.resize(220, 52);
  voltarHover.resize(220, 52);

  // Verificar se todas as imagens foram carregadas corretamente
  if (bgImage == null) {
    println("Erro: imagem de fundo não foi carregada. Verifique o caminho.");
  }
  if (newGameButton == null) {
    println("Erro: imagem do botão Novo Jogo não foi carregada. Verifique o caminho.");
  }
  if (newGameButtonHover == null) {
    println("Erro: imagem do botão Novo Jogo (hover) não foi carregada. Verifique o caminho.");
  }
  if (difficultiesButton == null) {
    println("Erro: imagem do botão Dificuldades não foi carregada. Verifique o caminho.");
  }
  if (creditsButton == null) {
    println("Erro: imagem do botão Créditos não foi carregada. Verifique o caminho.");
  }
  if (exitButton == null) {
    println("Erro: imagem do botão Sair não foi carregada. Verifique o caminho.");
  }
}

//-------------------------------------------------------------------------------------------------------------

//Chama as telas baseado nos screenStates----------------------------------------------------------------------

void draw() {
  if (screenState == 0) {
    drawMainMenu();
  } else if (screenState == 1) {
    drawNewGameScreen();
  } else if (screenState == 2) {
    drawDifficultiesScreen();
  } else if (screenState == 3) {
    drawCreditsScreen();
  } else if (screenState == 4) {
    drawHistoriaScreen();
  } else if (screenState == 5) {
    drawRegrasScreen();
  }
}

//-------------------------------------------------------------------------------------------------------------

void drawMainMenu() {
  if (bgImage != null) {
    image(bgImage, 0, 0, width, height);
  }

  // Desenhar o botão "Novo Jogo" com estado hover
  if (newGameButton != null && newGameButtonHover != null) {
    if (mouseX > width/2 - newGameButton.width/2 && mouseX < width/2 + newGameButton.width/2 &&
      mouseY > height/2 - 150 && mouseY < height/2 - 150 + newGameButton.height) {
      image(newGameButtonHover, width/2 - newGameButton.width/2, height/2 - 150);
    } else {
      image(newGameButton, width/2 - newGameButton.width/2, height/2 - 150);
    }
  }

  // Desenhar o botão "Dificuldade" com estado hover
  if (difficultiesButton != null && difficultiesButtonHover != null) {
    if (mouseX > width/2 - difficultiesButton.width/2 && mouseX < width/2 + difficultiesButton.width/2 &&
      mouseY > height/2 -80  && mouseY < height/2 -80  + difficultiesButton.height) {
      image(difficultiesButtonHover, width/2 - difficultiesButton.width/2, height/2-80 );
    } else {
      image(difficultiesButton, width/2 - difficultiesButton.width/2, height/2 -80);
    }
  }

  // Desenhar o botão "Creditos" com estado hover
  if (creditsButton != null && creditsButtonHover != null) {
    if (mouseX > width/2 - creditsButton.width/2 && mouseX < width/2 + creditsButton.width/2 &&
      mouseY > height/2 -10  && mouseY < height/2 -10   + creditsButton.height) {
      image(creditsButtonHover, width/2 - creditsButton.width/2, height/2 -10  );
    } else {
      image(creditsButton, width/2 - creditsButton.width/2, height/2 -10 );
    }
  }
  // Desenhar o botão "Creditos" com estado hover
  if (creditsButton != null && creditsButtonHover != null) {
    if (mouseX > width/2 - creditsButton.width/2 && mouseX < width/2 + creditsButton.width/2 &&
      mouseY > height/2 -10  && mouseY < height/2 -10   + creditsButton.height) {
      image(creditsButtonHover, width/2 - creditsButton.width/2, height/2 -10  );
    } else {
      image(creditsButton, width/2 - creditsButton.width/2, height/2 -10 );
    }
  }
  // Desenhar o botão "Creditos" com estado hover
  if (historia != null && historiaHover != null) {
    if (mouseX > width/2 - historia.width/2 && mouseX < width/2 + historia.width/2 &&
      mouseY > height/2 +60 && mouseY < height/2 +60   + historia.height) {
      image(historiaHover, width/2 - historia.width/2, height/2 +60   );
    } else {
      image(historia, width/2 - historia.width/2, height/2 +60  );
    }
  }
  // Desenhar o botão "Creditos" com estado hover
  if (regras != null && regrasHover != null) {
    if (mouseX > width/2 - regras.width/2 && mouseX < width/2 + regras.width/2 &&
      mouseY > height/2 +130 && mouseY < height/2 +130   + historia.height) {
      image(regrasHover, width/2 - regras.width/2, height/2 +130  );
    } else {
      image(regras, width/2 - regras.width/2, height/2 +130  );
    }
  }
}
void drawNewGameScreen() {
  if (millis() - lastClickTime >= 8500) {
    if (bgImage != null) {
      gameplay();
     
    }
  }
}

void drawDifficultiesScreen() {
  if (bgImage != null) {
    image(bgImage, 0, 0, width, height);
  }
  // Desenhar o botão "Fácil" com estado hover
  if (Facil != null && facilHover != null) {
    if (mouseX > width/2 - Facil.width/2 && mouseX < width/2 + Facil.width/2 &&
      mouseY > height/2 -100  && mouseY < height/2 - 100 + Facil.height) {
      image(facilHover, width/2 - Facil.width/2, height/2 -100);
    } else {
      image(Facil, width/2 - Facil.width/2, height/2 -100);
    }
  }
  // Desenhar o botão "Médio" com estado hover
  if (Medio != null && medioHover != null) {
    if (mouseX > width/2 - Medio.width/2 && mouseX < width/2 + Medio.width/2 &&
      mouseY > height/2  && mouseY < height/2  + Medio.height) {
      image(medioHover, width/2 - Medio.width/2, height/2 );
    } else {
      image(Medio, width/2 - Medio.width/2, height/2);
    }
  }
  // Desenhar o botão "Difícil" com estado hover
  if (Dificil != null && dificilHover != null) {
    if (mouseX > width/2 - Dificil.width/2 && mouseX < width/2 + Dificil.width/2 &&
      mouseY > height/2 +100  && mouseY < height/2 + 100  + Dificil.height) {
      image(dificilHover, width/2 - Dificil.width/2, height/2 + 100 );
    } else {
      image(Dificil, width/2 - Dificil.width/2, height/2 + 100);
    }
  }
  //Desenhar o botão "Dificuldade"
  if (difficultiesButtonHover != null) {
    image(difficultiesButtonHover, width/2 - difficultiesButtonHover.width/2, height/2 - 250);
  }
  if (inimigoDificil != null) {
    image(inimigoDificil, width/2 - inimigoDificil.width/2 +250, height/2 +85);
  }
  if (inimigoMedio != null) {
    image(inimigoMedio, width/2 - inimigoMedio.width/2 +190, height/2 -10);
  }
  if (inimigoFacil != null) {
    image(inimigoFacil, width/2 - inimigoFacil.width/2 +180, height/2 -110);
  }
  if (voltar != null && voltarHover != null) {
    if (mouseX > width/2 -250 - voltar.width/2 && mouseX < width/2 -250 + voltar.width/2 &&
      mouseY > height/2 +230  && mouseY < height/2 +230 + voltar.height) {
      image(voltarHover, width/2 - voltar.width/2 -250, height/2 +230);
    } else {
      image(voltar, width/2 - voltar.width/2-250, height/2 +230);
    }
  }
}
void drawCreditsScreen() {
  if (bgImage != null) {
    image(bgImage, 0, 0, width, height);
  }
  if (integrantes != null) {
    image(integrantes, width/2 - integrantes .width/2, height/2 -80);
  }
  if (voltar != null && voltarHover != null) {
    if (mouseX > width/2 -250 - voltar.width/2 && mouseX < width/2 -250 + voltar.width/2 &&
      mouseY > height/2 +230  && mouseY < height/2 +230 + voltar.height) {
      image(voltarHover, width/2 - voltar.width/2 -250, height/2 +230);
    } else {
      image(voltar, width/2 - voltar.width/2-250, height/2 +230);
    }
  }
  if (creditsButtonHover != null) {
    image(creditsButtonHover, width/2 - creditsButtonHover .width/2, height/2 -210);
  }
}

void drawHistoriaScreen() {
  if (bgImage != null) {
    image(bgImage, 0, 0, width, height);
  }
  if (textoHistoria != null) {
    image(textoHistoria, width/2 - textoHistoria.width/2, height/2 -100 );
  }
  if (historiaHover != null) {
    image(historiaHover, width/2 - historia.width/2, height/2 -210   );
  }
  if (voltar != null && voltarHover != null) {
    if (mouseX > width/2 -250 - voltar.width/2 && mouseX < width/2 -250 + voltar.width/2 &&
      mouseY > height/2 +230  && mouseY < height/2 +230 + voltar.height) {
      image(voltarHover, width/2 - voltar.width/2 -250, height/2 +230);
    } else {
      image(voltar, width/2 - voltar.width/2-250, height/2 +230);
    }
  }
}

void drawRegrasScreen() {
  if (bgImage != null) {
    image(bgImage, 0, 0, width, height);
  }
  if (controlestexto != null) {
    image(controlestexto, width/2 - controlestexto.width/2, height/2 -130 );
  }
  if (regras != null) {
    image(regrasHover, width/2 - regrasHover.width/2, height/2 -210 );
  }
  if (voltar != null && voltarHover != null) {
    if (mouseX > width/2 -250 - voltar.width/2 && mouseX < width/2 -250 + voltar.width/2 &&
      mouseY > height/2 +230  && mouseY < height/2 +230 + voltar.height) {
      image(voltarHover, width/2 - voltar.width/2 -250, height/2 +230);
    } else {
      image(voltar, width/2 - voltar.width/2-250, height/2 +230);
    }
  }
}

void mousePressed() {
  if (screenState == 0) {
    // Verificar se o botão "Novo Jogo" foi clicado
    if (newGameButton != null && mouseX > width/2 - newGameButton.width/2 && mouseX < width/2 + newGameButton.width/2 &&
      mouseY > height/2 - 150 && mouseY < height/2 -150 + newGameButton.height) {
      println("Novo Jogo clicado");
      menuClick.rewind();
      menuClick.play();
      bgMusic.close();
      lastClickTime = millis();
      gameStart.setGain(volumeStart);
      gameStart.play();
      screenState = 1; // Mudar para a tela de Novo Jogo
    }

    // Verificar se o botão "Dificuldades" foi clicado
    if (difficultiesButton != null && mouseX > width/2 - difficultiesButton.width/2 && mouseX < width/2 + difficultiesButton.width/2 &&
      mouseY > height/2 -80 && mouseY < height/2 -80 + difficultiesButton.height) {
      println("Dificuldades clicado");
      menuClick.rewind();
      menuClick.play();
      screenState = 2; // Mudar para a tela de Dificuldades
    }

    // Verificar se o botão "Créditos" foi clicado
    if (creditsButton != null && mouseX > width/2 - creditsButton.width/2 && mouseX < width/2 + creditsButton.width/2 &&
      mouseY > height/2 -10 && mouseY < height/2 -10 + creditsButton.height) {
      println("Créditos clicado");
      menuClick.rewind();
      menuClick.play();
      bgMusic.pause();
      creditsTheme = minim.loadFile("creditsTheme.mp3");
      creditsTheme.play();
      creditsTheme.setGain(volumeCredits);
      screenState = 3; // Mudar para a tela de Créditos
    }

    // Verificar se o botão "Sair" foi clicado
    if (exitButton != null && mouseX > width/2 - exitButton.width/2 && mouseX < width/2 + exitButton.width/2 &&
      mouseY > height/2 + 200 && mouseY < height/2 + 200 + exitButton.height) {
      println("Sair clicado");
      menuClick.rewind();
      menuClick.play();
      exit(); // Fecha o programa
    }
    if (mouseX > width/2 - historia.width/2 && mouseX < width/2 + historia.width/2 &&
      mouseY > height/2 +60 && mouseY < height/2 +60   + historia.height) {
      menuClick.rewind();
      menuClick.play();
      screenState = 4;
    }
    if (mouseX > width/2 - historia.width/2 && mouseX < width/2 + historia.width/2 &&
      mouseY > height/2 +60 && mouseY < height/2 +60   + historia.height) {
      menuClick.rewind();
      menuClick.play();
    }
    if (mouseX > width/2 - regras.width/2 && mouseX < width/2 + regras.width/2 &&
      mouseY > height/2 +130 && mouseY < height/2 +130   + historia.height) {
      menuClick.rewind();
      menuClick.play();
      screenState = 5;
    }
  }
  
  if (screenState == 2) {
    if (Facil != null && mouseX > width/2 - Facil.width/2 && mouseX < width/2 + Facil.width/2 &&
      mouseY > height/2 - 100 && mouseY < height/2 - 100 + Facil.height) {
      println("Facil clicado");
      menuClick.rewind();
      menuClick.play();
      difficultyLevel = 1;
      println(difficultyLevel);
    }
    if (Medio != null && mouseX > width/2 - Medio.width/2 && mouseX < width/2 + Medio.width/2 &&
      mouseY > height/2  && mouseY < height/2  + Medio.height) {
      println("Medio clicado");
      menuClick.rewind();
      menuClick.play();
      difficultyLevel = 2;
      println(difficultyLevel);
    }
    if (Dificil != null && mouseX > width/2 - Dificil.width/2 && mouseX < width/2 + Dificil.width/2 &&
      mouseY > height/2 + 100 && mouseY < height/2 + 100 + Dificil.height) {
      println("Dificil clicado");
      menuClick.rewind();
      menuClick.play();
      difficultyLevel = 3;
      println(difficultyLevel);
    }

    // Definindo a dificuldade inicial
    choiceDifficultyLevel(difficultyLevel);

    if (voltar != null && mouseX > width/2 -250 - voltar.width/2 && mouseX < width/2 -250 + voltar.width/2 &&
      mouseY > height/2 +230 && mouseY < height/2 +230 + voltar.height) {
      menuClick.rewind();
      menuClick.play();
      screenState = 0;
    }
  }
  if (screenState == 3) {
    if (voltar != null && mouseX > width/2 -250 - voltar.width/2 && mouseX < width/2 -250 + voltar.width/2 &&
      mouseY > height/2 +230 && mouseY < height/2 +230 + voltar.height) {
      menuClick.rewind();
      menuClick.play();
      creditsTheme.pause();
      bgMusic = minim.loadFile("menuTheme.mp3");
      bgMusic.loop(); // Tocar a música em loop
      bgMusic.setGain(volumebg);
      screenState = 0;
    }
  }
  if (screenState == 4) {
    if (voltar != null && mouseX > width/2 -250 - voltar.width/2 && mouseX < width/2 -250 + voltar.width/2 &&
      mouseY > height/2 +230 && mouseY < height/2 +230 + voltar.height) {
      menuClick.rewind();
      menuClick.play();
      screenState = 0;
    }
  }
  if (screenState == 5) {
    if (voltar != null && mouseX > width/2 -250 - voltar.width/2 && mouseX < width/2 -250 + voltar.width/2 &&
      mouseY > height/2 +230 && mouseY < height/2 +230 + voltar.height) {
      menuClick.rewind();
      menuClick.play();
      screenState = 0;
    }
  }
}
void mouseMoved() {
  if (screenState == 0) {
    // Verificar se o mouse está sobre o botão Novo Jogo
    if (mouseX > width/2 - newGameButton.width/2 && mouseX < width/2 + newGameButton.width/2 &&
      mouseY > height/2 - 150 && mouseY < height/2 - 150 + newGameButton.height) {
      // Tocar o som de hover se ainda não foi tocado
      if (!newGamehoverPlayed) {
        mouseHover.play();
        mouseHover.rewind();
        newGamehoverPlayed = true; // Marcar como tocado
      }
    } else {
      newGamehoverPlayed = false; // Reiniciar o estado se o mouse sair da área do botão
    }
    // Verificar o botão Dificuldades
    if (mouseX > width/2 - difficultiesButton.width/2 && mouseX < width/2 + difficultiesButton.width/2 &&
      mouseY > height/2 -80 && mouseY < height/2 -80 + difficultiesButton.height) {
      if (!dificultieshoverPlayed) {
        mouseHover.play();
        mouseHover.rewind();
        dificultieshoverPlayed = true;
      }
    } else {
      dificultieshoverPlayed = false;
    }
    // Verificar o botão Créditos
    if (mouseX > width/2 - creditsButton.width/2 && mouseX < width/2 + creditsButton.width/2 &&
      mouseY > height/2 -10 && mouseY < height/2 -10 + creditsButton.height) {
      if (!creditshoverPlayed) {
        mouseHover.play();
        mouseHover.rewind();
        creditshoverPlayed = true;
      }
    } else {
      creditshoverPlayed = false;
    }
    if (mouseX > width/2 - historia.width/2 && mouseX < width/2 + historia.width/2 &&
      mouseY > height/2 +60 && mouseY < height/2 +60   + historia.height) {
      if (!historiahoverPlayed) {
        mouseHover.play();
        mouseHover.rewind();
        historiahoverPlayed = true;
      }
    } else {
      historiahoverPlayed = false;
    }
    if (mouseX > width/2 - regras.width/2 && mouseX < width/2 + regras.width/2 &&
      mouseY > height/2 +130 && mouseY < height/2 +130   + historia.height) {
      if (!regrashoverPlayed) {
        mouseHover.play();
        mouseHover.rewind();
        regrashoverPlayed = true;
      }
    } else {
      regrashoverPlayed = false;
    }
  }
  if (screenState == 2) {
    if (Facil != null && facilHover != null) {
      if (mouseX > width/2 - Facil.width/2 && mouseX < width/2 + Facil.width/2 &&
        mouseY > height/2 -100  && mouseY < height/2 - 100 + Facil.height) {
        if (!facilhoverPlayed ) {
          mouseHover.play();
          mouseHover.rewind();
          facilhoverPlayed = true;
        }
      } else {
        facilhoverPlayed = false;
      }
    }
    // Desenhar o botão "Médio" com estado hover
    if (Medio != null && medioHover != null) {
      if (mouseX > width/2 - Medio.width/2 && mouseX < width/2 + Medio.width/2 &&
        mouseY > height/2  && mouseY < height/2  + Medio.height) {
        if (!mediohoverPlayed ) {
          mouseHover.play();
          mouseHover.rewind();
          mediohoverPlayed = true;
        }
      } else {
        mediohoverPlayed = false;
      }
    }
    // Desenhar o botão "Difícil" com estado hover
    if (Dificil != null && dificilHover != null) {
      if (mouseX > width/2 - Dificil.width/2 && mouseX < width/2 + Dificil.width/2 &&
        mouseY > height/2 +100  && mouseY < height/2 + 100  + Dificil.height) {
        if (!dificilhoverPlayed ) {
          mouseHover.play();
          mouseHover.rewind();
          dificilhoverPlayed  = true;
        }
      } else {
        dificilhoverPlayed  = false;
      }
    }
  }
}
void stop() {
  bgMusic.close();
  mouseHover.close();
  menuClick.close();
  minim.stop();
  super.stop();
}
