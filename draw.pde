/** @file draw.pde
 * Define o laço principal do projeto.
 * 
 * @author Guilherme N. Ramos (gnramos@unb.br)
 */

Unnamed b = randomUnnamed();
void draw() {
  background(Configs.Processing.Environment.BackgroundColor);
  
  b.update();
  b.display();
}

