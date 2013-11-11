/** @file Utils.pde
 * Define funções/classes auxiliares.
 *
 * @author Guilherme N. Ramos (gnramos@unb.br)
 */

/**************
 *   Funções  *
 **************/

/** Overload da função original com argumento PVector. */
void translate(PVector position) {
  translate(position.x, position.y);
}


/**************
 * Interfaces *
 **************/

/** Define como utilizar uma ação. */
interface Action {
  /** Executa a ação. */
  void execute();
}


/** Define como utilizar um comportamento. */
interface Behavior {
}

/** Define a interface para visualização. */
interface Displayable {
  void display();
}

/** Define a interface para atualização. */
interface Updatable {
  void update();
}
