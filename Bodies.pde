/** @file Bodies.pde
 * Define as visualizações possíveis.
 *
 * @author Guilherme N. Ramos (gnramos@unb.br)
 */


class Bicho {
  Body body;
  //  int shape;
  //  int sound;
  //  float energy;
  //  int age;
}

/** Define uma forma. */
class Shape implements Displayable {
  float size; /** Tamanho da forma. */

  Shape(float size) {
    this.size = size;
  }

  /** Desenha a forma. */
  void display() {
    ellipse(0, 0, this.size, this.size);
  }
}

/** Define o corpo. */
class Body implements Displayable {
  Shape   shape;      /**< Forma do corpo. */
  PVector position2D; /**< Posição do corpo. */
  float   heading2D;  /**< Orientação do corpo. */
  
  Body(float x, float y, float size) {
    this.shape = new Shape(size);
    this.position2D = new PVector(x, y);
  }

  void display() {
    pushMatrix();    
    translate(this.position2D);
    rotate(this.heading2D);
    
    shape.display();
    
    popMatrix();
  }
}


abstract class Sensor {
  /** percebe o estado atual do ambiente. */
  abstract void read();
}

abstract class Agent implements Updatable {
  ArrayList<Sensor> sensors;
  ArrayList<Behavior> behaviors;

  /** Percebe o estado ambiente com seus sensores. */
  void perceive() {
    for (Sensor s : sensors) s.read();
  }

  /** Decide quais ações devem ser tomadas em função da percepção. */
  abstract ArrayList<Action> decideActions();

  // overload 
  void update() {
    perceive();
    for (Action action : decideActions()) action.execute();
  }
}

