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

/** Define o corpo. */
class Body implements Displayable, Updatable {
  ShapeComponent    shape;    /**< Forma do corpo. */
  StyleComponent    style;    /**< Estilo do corpo. */
  PositionComponent position; /**< Posição do corpo. */
  MoveComponent     move;     /**< Movimentação do corpo. */
  ArrayList<Sensor> sensors;

  Body(ShapeComponent shape, StyleComponent style, PositionComponent position, float maxSpeed) {
assert shape != null : 
    "Não é possível criar um corpo com shape nulo.";
assert style != null : 
    "Não é possível criar um corpo com style nulo.";
assert position != null : 
    "Não é possível criar um corpo com position nulo.";

    this.move = new MoveComponent(maxSpeed, position);
    this.position = position;
    this.sensors = new ArrayList<Sensor>();
    this.shape = shape;
    this.style = style;
  }

  void display() {
    pushMatrix();    

    translate(this.position);
    rotate(this.position);    

    this.style.push();
    shape.display();
    
    // Debug
    strokeWeight(3);
    stroke(#FF0000);
    line(0,0,move.velocity.x*10, move.velocity.y*10);

    popMatrix();
  }
  
  void update() {
    move.acceleration.div(shape.size);
    move.update();
  }
}

class Agent implements Updatable {
  ArrayList<Behavior> behaviors;
  Body body;

  /** Construtor. */
  Agent(Body body) {
assert body != null: 
    "Não é possível criar um agente com body nulo.";

    behaviors = new ArrayList<Behavior>();
    this.body = body;
    
    behaviors.add(new WanderBehavior(body));
    behaviors.add(new WallAvoidanceBehavior(body, new WallSensor(body.position.location, 2*body.shape.size)));
  }

  // overload 
  void update() {    
    ArrayList<Action> actions = new ArrayList<Action>();
    
    // Decisão
    for(Behavior behavior : behaviors) if(behavior.enabled) actions.addAll(behavior.whatToDo());
    // Preparação
    for (Action action : actions) action.execute(body);
    // Execução
    body.update();
    /** @todo essa nomenclatura soa estranha */
  }
}

