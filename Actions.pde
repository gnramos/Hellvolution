/** @file Actions.pde
 * Define as ações possíveis.
 *
 * @author Guilherme N. Ramos (gnramos@unb.br)
 */

class Move implements Action {
  Body owner;
  PVector velocity;     /**< Velocidade do componente. */
  PVector acceleration; /**< Aceleração do componente. */
  float   maxSpeed;     /**< Velocidade máxima permitida. */

  void execute() {
    acceleration.limit(Configs.Actions.Movement.MaxAcceleration);
    velocity.add(acceleration);
    velocity.limit(maxSpeed);
    owner.position2D.add(velocity);
    acceleration.mult(0);
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
