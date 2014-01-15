/** @file draw.pde
 * Define o laço principal do projeto.
 * 
 * @author Guilherme N. Ramos (gnramos@unb.br)
 */

BodyComponent b = randomBodyComponent();

void draw() {
  b.update();
  b.display();
}

