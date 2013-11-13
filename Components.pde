/** @file Components.pde
 * Define componentes (seguindo a ideia de Component-based Software Engineering).
 *
 * @author Guilherme N. Ramos (gnramos@unb.br)
 */

/** Classe base para componentes. */
abstract class Component {
}

/** Define uma forma. */
class ShapeComponent extends Component implements Displayable {
  float size; /** Tamanho da forma. */

  /** Construtor. */
  ShapeComponent(float size) {
assert size > 0 : 
    "Tamanho \"" + size + "\" inválido.";

    this.size = size;
  }

  /** Desenha a forma. */
  void display() {
    ellipse(0, 0, this.size, this.size);
  }
}

/** Define uma posição. */
class PositionComponent extends Component {
  PVector location; /**< Localização. */
  float   angle;    /**< Orientação. */

  /** Construtor. */
  PositionComponent(float x, /**< Coordenada X. */ 
  float y, /**< Coordenada Y. */
  float z, /**< Coordenada Z. */
  float angle /**< Orientação. */
  ) { 
    this.location = new PVector(x, y, z);
    this.angle = angle;
  }
}

/** Define o estilo de coloração. */
class StyleComponent extends Component {
  color fill;         /**< Cor do preenchimento. */
  color stroke;       /**< Cor da linha. */
  float strokeWeight; /**< Espessura da linha. */

  /** Construtor. */
  StyleComponent(color fill, color stroke, float strokeWeight) {
    this.fill = fill;
    this.stroke = stroke;
    this.strokeWeight = strokeWeight;
  }

  /** Define o estilo. */
  void push() {
    fill(this.fill);
    stroke(this.stroke);
    strokeWeight(this.strokeWeight);
  }
  
  /** Define o estilo trocando as cores. */
  void pushInverse() {    
    fill(this.stroke);
    stroke(this.fill);
    strokeWeight(this.strokeWeight);
  }
}

/** Define a movimentação. */
class MoveComponent extends Component implements Updatable {
  PVector location;     /**< Localização. */
  PVector velocity;     /**< Velocidade do componente. */
  PVector acceleration; /**< Aceleração do componente. */
  float   maxSpeed;     /**< Velocidade máxima permitida. */

  /** Construtor. */
  MoveComponent(float maxSpeed, /**< Velocidade máxima permitida. */ 
  PositionComponent positioning /**< Componente que define a posição. */) {
assert maxSpeed >= 0: 
    "Velocidade máxima não pode ser negativa.";
assert positioning != null: 
    "Localização não pode ser nula.";

    this.location = positioning.location;
    this.velocity = new PVector();
    this.acceleration = new PVector();
    this.maxSpeed = maxSpeed;
  }

  // Overload
  void update() {
    acceleration.limit(Configs.Actions.Movement.MaxAcceleration);
    velocity.add(acceleration);
    velocity.limit(maxSpeed);
    location.add(velocity);
    acceleration.mult(0);
  }
  
  /** Retorna a magnitude da velocidade atual. */
  float currentSpeed() {
    return velocity.mag();
  }
}
