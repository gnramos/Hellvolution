/** @file Components.pde
 * Define componentes (seguindo a ideia de Component-based Software Engineering).
 *
 * @author Guilherme N. Ramos (gnramos@unb.br)
 */

abstract class Component {
}

class Movement2DComponent extends Component implements Updatable {
  PVector velocity;
  PVector acceleration;

  Movement2DComponent(PVector velocity, PVector acceleration) {
assert velocity != null: 
    "Velocidade não pode ser nula.";
assert acceleration != null: 
    "Aceleração não pode ser nula.";

    this.velocity = velocity;
    this.acceleration = acceleration;
  }

  void update() {
    velocity.add(acceleration);
  }

  float currentSpeed() {
    return velocity.mag();
  }
}

class PositionComponent extends Component {
  PVector location;
  float   headingAngle;

  PositionComponent(float x, float y, float z, float headingAngle) { 
    this.location = new PVector(x, y, z);
    this.headingAngle = headingAngle;
  }
}

abstract class ShapeComponent extends Component implements Displayable {
  float size;

  ShapeComponent(float size) {
assert size > 0 : 
    "Tamanho \"" + size + "\" inválido.";

    this.size = size;
  }
}

class StyleComponent extends Component {
  color fillColor;
  color strokeColor;
  float strokeWeight;

  StyleComponent(color fillColor, color strokeColor, float strokeWeight) {
    this.fillColor = fillColor;
    this.strokeColor = strokeColor;
    this.strokeWeight = strokeWeight;
  }

  /** Implementa o estilo. */
  void push() {
    fill(this.fillColor);
    stroke(this.strokeColor);
    strokeWeight(this.strokeWeight);
  }

  /** Implementa o estilo trocando as cores. */
  void pushInverse() {    
    fill(this.strokeColor);
    stroke(this.fillColor);
    strokeWeight(this.strokeWeight);
  }
}


/*************************
 * Componentes compostos *
 *************************/
 
class Physics2DComponent extends Component implements Updatable {
  float mass;
  Movement2DComponent movement;
  PositionComponent position;

  Physics2DComponent(float mass, Movement2DComponent movement, PositionComponent position) {
assert mass >= 0: 
    "Massa não pode ser negativa.";
assert movement != null: 
    "Movement2DComponent não pode ser nulo.";
assert position != null: 
    "PositionComponent não pode ser nulo.";
    
    this.mass = mass;
    this.movement = movement;
    this.position = position;
  }

  void update() {
    movement.acceleration.div(mass);
    movement.update();
    position.location.add(movement.velocity);
  }
}

class BodyComponent extends Component implements Displayable, Updatable {
  ShapeComponent    shape;
  StyleComponent    style;
  Physics2DComponent physics2D;

  BodyComponent(ShapeComponent shape, StyleComponent style, Physics2DComponent physics2D) {
assert shape != null : 
    "Não é possível criar um corpo com ShapeComponent nulo.";
assert style != null : 
    "Não é possível criar um corpo com StyleComponent nulo.";
assert physics2D != null : 
    "Não é possível criar um corpo com Physics2DComponent nulo.";

    this.shape = shape;
    this.style = style;
    this.physics2D = physics2D;
  }

  void display() {
    pushMatrix();

    translate(physics2D);
    rotate(physics2D);    

    style.push();
    shape.display();

    popMatrix();
  }

  void update() {
    physics2D.update();
  }
}

class Unnamed {
  BodyComponent body;
  SteeringBehavior behavior;
  
  Unnamed(BodyComponent body, SteeringBehavior behavior) {
    this.body = body;
    this.behavior = behavior;
  }
  
  void update() {
    body.physics2D.movement.acceleration.add(behavior.steeringForce());
    body.update();
    body.physics2D.movement.acceleration.mult(0);
  }
  void display() {
    body.display();
  }
}

