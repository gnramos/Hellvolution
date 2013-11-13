/** @file Actions.pde
 * Define as ações possíveis.
 *
 * @author Guilherme N. Ramos (gnramos@unb.br)
 */

/** Define como utilizar uma ação. */
interface Action {
  /** Executa a ação. */
  void execute(Body owner);
}

/** Define a ação de movimento. */
class MoveAction implements Action {
  PVector acceleration;

  MoveAction(PVector acceleration) {
assert acceleration != null : 
    "Não é possível criar um movimento sem aceleração.";

    this.acceleration = acceleration;
  }

  void execute(Body owner) {
assert owner != null : 
    "Não é possível mover um corpo nulo.";

    owner.move.acceleration.add(this.acceleration);
    /** @todo só adicionar se não exceder um limiar X */
  }
}

/*
 class ChangeSize implements Action {
 }
 class ChangeColor implements Action {
 }
 class ChangeSound implements Action {
 }
 class ChangeEnergy implements Action {
 } 
 class Recombine implements Action {
 }*/
