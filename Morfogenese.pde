/** @file newM.pde
 * Inicializa as configurações do projeto.
 *
 * @author Guilherme N. Ramos (gnramos@unb.br)
 */

/** Chamada no início da simulação, prepara o ambiente para execução. */
void setup() {
  setupProcessingColor();
  setupProcessingFrame();
  setupProcessingShape();
  
  setupVariables();
}


void setupProcessingColor() {
  colorMode(RGB, 255);
}  

void setupProcessingFrame() {
  int w = int(Configs.Processing.Environment.Frame.DisplayRatio*displayWidth);
  int h = int(Configs.Processing.Environment.Frame.DisplayRatio*displayHeight);

  if (Configs.Processing.Environment.OpenGL) size(w, h, OPENGL);
  else size(w, h);

  frame.setResizable(Configs.Processing.Environment.Frame.Resizable);
  frameRate(Configs.Processing.Environment.Frame.Rate);
  
  hint(Configs.Processing.Environment.Frame.Hint);
}

void setupProcessingShape() {
  smooth(Configs.Processing.Shape.Smooth);
  rectMode(Configs.Processing.Shape.Mode.Rect);
  ellipseMode(Configs.Processing.Shape.Mode.Ellipse);
}

/* Variáveis globais */
ArrayList<Updatable> updatables;
ArrayList<Displayable> displayables;

/** Inicializa as variáveis globais. */
void setupVariables() {
  updatables = new ArrayList<Updatable>();
  displayables = new ArrayList<Displayable> ();
  
  // Dummy setup
  Body b = new Body(20, 20, 10);
  displayables.add(b);
}


/** @mainpage
 * Código para uma obra de arte computacional. A ideia é verificar o comportamento 
 * emergente da interação dos bichos.
 *
 * @todo
 * - Separar em "módulos"
 *  1) Body
 *     1.1) Atributos: tamanho, forma, som, posição, energia
 *  2) Ações (lista? )
 *     2.1) uma para  alteração de cada atributo?
 *     2.2) percepção
 *     2.3) crossover
 *  3) Comportamento (lista? pesos?)
 *     3.1) movimento? (wander, breed, attack/flee, flock, forage)
 *     3.2) breed
 *  4) Ambiente (?)
 *     4.1) Tipo de terreno
 *     4.2) fonte de energia
 *  5) Cromossomo?
 *  6) Parasita/virus? (outro "bicho" que interage com o bicho original)
 * 
 * Definir uma personalidade - via Comportamento - conforme personagens conhecidas (ex: Saci, lobisomem, chapéuzinho, etc.) e avaliar a evolução das populações. Força um "motivo artistico". 
 */
