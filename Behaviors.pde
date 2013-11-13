/** @file Behaviors.pde
 * Define os comportamentos possíveis.
 *
 * @author Guilherme N. Ramos (gnramos@unb.br)
 */

/** Define como utilizar um comportamento. */
abstract class Behavior {
  boolean enabled; /**< Indica se o comportamento está habilitado ou não. */
  Body    owner;   /**< Indica o dono do comportamento. */

  Behavior(Body owner) {
assert owner != null :
    "Não é possível criar um comportamento com body nulo.";

    this.enabled = true;
    this.owner = owner;
  }

  /** Decide quais ações devem ser tomadas em função da percepção. */
  abstract ArrayList<Action> whatToDo();
}

/** Define o comportamento para direcionar. */
abstract class SteeringBehavior extends Behavior {
  /** Construtor. */
  SteeringBehavior(Body owner) {
    super(owner);
  }

  /** Define a direção e intensidade do movimento. */
  abstract PVector steeringForce();

  // Overload
  ArrayList<Action> whatToDo() {
    ArrayList<Action> actions = new ArrayList<Action>();
    actions.add(new MoveAction(steeringForce()));
    return actions;
  }
}

//class Breed extends Behavior {
//  /** Construtor. */
//  Breed(Body owner) {
//    super(owner);
//  }
//}
//
//class Flock extends Behavior {
//  /** Construtor. */
//  Flock(Body owner) {
//    super(owner);
//  }
//}
//
//class Forage extends Behavior {
//  /** Construtor. */
//  Forage(Body owner) {
//    super(owner);
//  }
//}
//
//
//class Perceive extends Behavior {
//
//  /** Construtor. */
//  Perceive(Body owner) {
//    super(owner);
//  }
//  // Percepção
//  //for (Sensor sensor : sensors) sensor.read();
//}

/** Define o comportamento de caminhada aleatória. */
class WanderBehavior extends SteeringBehavior {
  /** Construtor. */
  WanderBehavior(Body owner) {
    super(owner);
  }

  // Overload
  PVector steeringForce() {
    return new PVector(random(-1, 1), random(-1, 1));
  }
}

/** Define um sensor. */
abstract class Sensor {
  boolean enabled; /**< Indica se o sensor está habilitado ou não. */
  
  /** Construtor. */
  Sensor() {
    this.enabled = true;
  }
  
  /** Faz a leitura do sensor. */
  abstract void read();
}

/** Define um sensor de proximidade. */
abstract class ProximitySensor extends Sensor {
  PVector obstacle; /**< Localização do obstáculo detectado em relação a localização do sensor. */
  PVector location; /**< Localização do sensor. */
  float   range;    /**< Alcance do sensor. */

  /** Construtor. */
  ProximitySensor(PVector location, /**< Localização do sensor. */ float range /**< Alcance do sensor. */) {
assert location != null: 
    "Localização não pode ser nula.";
assert range > 0 :
    "Não é possível criar um sensor de proximidade sem alcance.";

    this.location = location;
    this.obstacle = new PVector();
    this.range = range;
  }
}

/** Define um sensor para detecção de paredes. */
class WallSensor extends ProximitySensor {
  /** Construtor. */
  WallSensor(PVector location, float range) {
    super(location, range);
  }

  /** Encontra a coordenada da parede mais próxima a posição do sensor que está dentro do alcance do sensor. */
  float getObstacleCoord(float current /**< Coordenada atual. */, float max/**< Coordenada máxima aceita. */) {
    if (current < range) return -current;
    if (current > max - range) return max-current;
    return 0;
  }

  // overload
  void read() {
    if(!enabled) return;
    
    obstacle.x = getObstacleCoord(location.x, width);
    obstacle.y = getObstacleCoord(location.y, height);
  }
}


/** Define o comportamento de caminhada aleatória. */
class WallAvoidanceBehavior extends SteeringBehavior {
  WallSensor sensor;

  /** Construtor. */
  WallAvoidanceBehavior(Body owner, WallSensor sensor) {
    super(owner);

    this.sensor = sensor;
    this.enabled = (sensor != null && sensor.enabled);
  }

  // Overload
  PVector steeringForce() {
    if(!sensor.enabled) new PVector();
    
    sensor.read();

    PVector force = new PVector(sensor.obstacle.x, sensor.obstacle.y, sensor.obstacle.z);
    force.div(-sensor.range); // força deve ser proporcional na direção oposta ao obstáculo.
    force.mult(owner.move.currentSpeed());
    return force;
  }
}

