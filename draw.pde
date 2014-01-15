/** @file draw.pde
 * Define o laço principal do projeto.
 * 
 * @author Guilherme N. Ramos (gnramos@unb.br)
 */

Unnamed b = randomUnnamed();
void draw() {
  drawBackground();
  
  b.update();
  b.display();
}

void drawBackground() { 
  background(Configs.Processing.Environment.BackgroundColor);
}
