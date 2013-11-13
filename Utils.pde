/** @file Utils.pde
 * Define funções/classes auxiliares.
 *
 * @author Guilherme N. Ramos (gnramos@unb.br)
 */

/**************
 *   Funções  *
 **************/

/** Overload da função original com argumento PositionComponent. */
void translate(PositionComponent position) {
  translate(position.location.x, position.location.y);
}

/** Overload da função original com argumento PositionComponent. */
void rotate(PositionComponent position) {
  rotate(position.angle);
}

/**************
 * Interfaces *
 **************/


/** Define a interface para visualização. */
interface Displayable {
  void display();
}

/** Define a interface para atualização. */
interface Updatable {
  void update();
}
