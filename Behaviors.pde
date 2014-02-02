/** @file Behaviors.pde
 * Define os comportamentos possíveis.
 *
 * @author Guilherme N. Ramos (gnramos@unb.br)
 */

abstract class Behavior {
  boolean enabled;

  Behavior() {
    this.enabled = true;
  }
}

abstract class SteeringBehavior extends Behavior {
  Specimen owner;
  float weight;

  SteeringBehavior(Specimen owner, float weight) {
assert owner != null :
    "Não é possível criar SteeringBehavior sem owner.";
assert weight != 0 :
    "Não é possível criar SteeringBehavior com weight = 0.";

    this.owner = owner;
    this.weight = weight;
  }

  abstract PVector steeringForce();
}

static PVector computeSeekingForce(Physics2DComponent physics2D, PVector target) {
  if (target == null || physics2D == null) return new PVector();

  PVector force = PVector.sub(target, physics2D.position.location);
  force.normalize();
  force.mult(physics2D.maxSpeed());
  force.sub(physics2D.movement.velocity);
  return force;
}

static PVector computeFleeingForce(Physics2DComponent physics2D, PVector target) {
  PVector force = computeSeekingForce(physics2D, target);
  force.mult(-1);
  return force;
}

class FleeBehavior extends SteeringBehavior {
  PVector target;

  FleeBehavior(Specimen owner, PVector target) {
    super(owner, Configs.Behavior.Steering.Weight.Flee);

    this.target = target;
  }

  PVector steeringForce() {
    if (!enabled) return new PVector();

    return computeFleeingForce(owner.body.physics2D, target);
  }
}

class FlockBehavior extends SteeringBehavior {
  FlockBehavior(Specimen owner) {
    super(owner, Configs.Behavior.Steering.Weight.Flock);
  }
  
  private boolean flockWith(Specimen specimen) {
    return true;
  }

  private PVector velocityMatching() {
    PVector force = new PVector();

    PVector aux;
    int count = 0;
    for (Specimen perceived : owner.sensors.specimen.visible) {
      if(!flockWith(specimen)) continue;
      
      float desiredseparation = min(owner.body.shape.size, perceived.body.shape.size)*Configs.Component.Sensor.SizeToRangeRatio;
      float d = dist(owner.body.physics2D.position, perceived.body.physics2D.position);
      if (d < desiredseparation) {
        force.add(perceived.body.physics2D.movement.velocity);
        count++;
      }
    }
    if (count > 0) {
      force.div((float)count);
      force.normalize();
      force.mult(owner.body.physics2D.maxSpeed());
      force.sub(owner.body.physics2D.movement.velocity);
    }
    return force;
  }

  private PVector separation() {
    PVector force = new PVector();

    PVector aux;
    int count = 0;
    for (Specimen perceived : owner.sensors.specimen.visible) {
      if(!flockWith(specimen)) continue;
      
      float desiredseparation = min(owner.body.shape.size, perceived.body.shape.size)*Configs.Component.Sensor.SizeToRangeRatio;
      aux = PVector.sub(perceived.body.physics2D.position.location, owner.body.physics2D.position.location);
      float d = aux.mag();
      if (d < desiredseparation) {
        aux.normalize();
        aux.div(-d);        // Weight by distance
        force.add(aux);
        count++;            // Keep track of how many
      }
    }
    if (count > 0) {
      force.div((float)count);
      force.normalize();
      force.mult(owner.body.physics2D.maxSpeed());
      force.sub(owner.body.physics2D.movement.velocity);
    }

    return force;
  }

  private PVector cohesion() {
    PVector force = new PVector();

    PVector aux;
    int count = 0;
    for (Specimen perceived : owner.sensors.specimen.visible) {
      if(!flockWith(specimen)) continue;
      
      float desiredseparation = max(owner.body.shape.size, perceived.body.shape.size)*Configs.Component.Sensor.SizeToRangeRatio;
      aux = PVector.sub(perceived.body.physics2D.position.location, owner.body.physics2D.position.location);
      float d = aux.mag();
      if (d < desiredseparation) {
        aux.normalize();
        aux.div(d);        // Weight by distance
        force.add(aux);
        count++;            // Keep track of how many
      }
    }
    if (count > 0) {
      force.div((float)count);
      force.normalize();
      force.mult(owner.body.physics2D.maxSpeed());
      force.sub(owner.body.physics2D.movement.velocity);
    }

    return force;
  }

  private boolean willFlock() {
    return (owner.sensors.specimen != null && owner.sensors.specimen.enabled && !owner.sensors.specimen.visible.isEmpty());
  }

  PVector steeringForce() {
    if (!enabled || !willFlock()) 
      return new PVector();

    PVector force = velocityMatching();
    force.mult(Configs.Behavior.Steering.Weight.FlockAlignment);
    PVector aux = separation();
    aux.mult(Configs.Behavior.Steering.Weight.FlockSeparation);
    force.add(aux);
    aux = cohesion();
    aux.mult(Configs.Behavior.Steering.Weight.FlockCohesion);
    force.add(aux);
    
    return force;
  }
}

class SeekBehavior extends SteeringBehavior {
  PVector target;

  SeekBehavior(Specimen owner, PVector target) {
    super(owner, Configs.Behavior.Steering.Weight.Seek);

    this.target = target;
  }

  PVector steeringForce() {
    if (!enabled) return new PVector();

    return computeSeekingForce(owner.body.physics2D, target);
  }
}

class WallAvoidanceBehavior extends SteeringBehavior {
  WallAvoidanceBehavior(Specimen owner) {
    super(owner, Configs.Behavior.Steering.Weight.WallAvoidance);
  }

  boolean avoidingWalls() {
    return (owner.sensors.wall != null && owner.sensors.wall.enabled);
  }

  PVector computeAvoidanceForce() {
    PVector force = new PVector();

    if (avoidingWalls()) {
      WallSensor sensor = owner.sensors.wall;
      sensor.read();
      if (sensor.obstacleLocation.mag() > 0) {
        // força deve ser proporcional na direção oposta ao obstáculo.
        if (sensor.obstacleLocation.x != 0) force.x = -sensor.range/sensor.obstacleLocation.x;
        if (sensor.obstacleLocation.y != 0) force.y = -sensor.range/sensor.obstacleLocation.y;
        if (sensor.obstacleLocation.z != 0) force.z = -sensor.range/sensor.obstacleLocation.z;
        force.mult(owner.body.physics2D.movement.velocity.mag());
      }
    }
    return force;
  }

  PVector steeringForce() {
    if (!enabled) return new PVector();

    return computeAvoidanceForce();
  }
}

class WanderingBehavior extends SteeringBehavior {
  WanderingBehavior(Specimen owner) {
    super(owner, Configs.Behavior.Steering.Weight.Wandering);
  }

  PVector steeringForce() {
    if (!enabled) return new PVector();

    PVector force = PVector.random2D();
    force.normalize();
    return force;
  }
}

/*********/

class Steering {
  ArrayList<SteeringBehavior> behaviors;  

  Steering(ArrayList<SteeringBehavior> behaviors) {
assert behaviors != null : 
    "Não é possível criar Steering com ArrayList<SteeringBehavior> nulo.";

    this.behaviors = behaviors;
  }

  void accumulateForces(PVector runningTotal) {
    for (SteeringBehavior behavior : behaviors) {
      PVector force = behavior.steeringForce();
      force.mult(behavior.weight);
      if (!accumulateForce(runningTotal, force))
        break;
    }
  }

  boolean accumulateForce(PVector runningTotal, PVector forceToAdd) {
    float magnitudeRemaining = Configs.Behavior.Steering.Max.Force - runningTotal.mag();

    if (magnitudeRemaining <= 0) 
      return false;

    double magnitudeToAdd = forceToAdd.mag();

    if (magnitudeToAdd > magnitudeRemaining) {
      forceToAdd.normalize();
      forceToAdd.mult(magnitudeRemaining);
    }
    runningTotal.add(forceToAdd);

    return true;
  }
}

