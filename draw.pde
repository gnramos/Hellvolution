/** @file draw.pde
 * Define o laço principal do projeto.
 * 
 * @author Guilherme N. Ramos (gnramos@unb.br)
 */

void draw() {
  drawBackground();
  
  for(Unnamed u : unnamedList) {
    u.update();
    u.display();
  }
}

void drawBackground() { 
  background(Configs.Processing.Environment.BackgroundColor);
}
