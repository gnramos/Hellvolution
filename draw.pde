/** @file draw.pde
 * Define o laço principal do projeto.
 * 
 * @author Guilherme N. Ramos (gnramos@unb.br)
 */

/** Função chamada no laço principal da simulação. */
void draw() {
  for (Updatable current : updatables) current.update();
  for (Displayable current : displayables) current.display();
}

