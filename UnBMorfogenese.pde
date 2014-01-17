/** @file UnBMorfogenese.pde
 * Inicializa as configurações do projeto.
 *
 * @author Guilherme N. Ramos (gnramos@unb.br)
 */

/** Chamada no início da simulação, prepara o ambiente para execução. */
void setup() {
  setupColor(); 
  setupFrame();
  setupShapeAttributes();

  setupGlobalVariables();
}

void setupColor() {
  colorMode(Configs.Processing.Color.Mode, Configs.Processing.Color.Max);
}  

void setupFrameSize() {
  frame.setResizable(Configs.Processing.Environment.Frame.Resizable);

  int w = int(Configs.Processing.Environment.Frame.ToDisplayRatio*displayWidth);
  int h = int(Configs.Processing.Environment.Frame.ToDisplayRatio*displayHeight);

  if (Configs.Processing.Environment.UseOpenGL) size(w, h, OPENGL);
  else size(w, h);
}

void setupFrameRate() {
  frameRate(Configs.Processing.Environment.Frame.Rate);
  hint(Configs.Processing.Environment.Frame.Hint);
}

void setupFrame() {
  setupFrameSize();
  setupFrameRate();
}

void setupShapeAttributes() {
  smooth(Configs.Processing.Shape.Smooth);
  rectMode(Configs.Processing.Shape.RectMode);
  ellipseMode(Configs.Processing.Shape.EllipseMode);
}

/* Variáveis globais */
ArrayList<Unnamed> unnamedList;
PVector mouse;

void setupGlobalVariables() {
  mouse = new PVector();

  unnamedList = new ArrayList<Unnamed>();
  for (int i = 0; i <5; i++)
    unnamedList.add(randomUnnamed());
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
 * - Fazer algo que funcione, desempenho é uma preocupação posterior.
 * 
 * Definir uma personalidade - via Comportamento - conforme personagens conhecidas (ex: Saci, lobisomem, chapéuzinho, etc.) e avaliar a evolução das populações. Força um "motivo artistico". 
 */
