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
  SteeringBehavior() {
  }

  abstract PVector steeringForce();
}

class Steering {
  ArrayList<SteeringBehavior> behaviors;  

  Steering(ArrayList<SteeringBehavior> behaviors) {
assert behaviors != null : 
    "Não é possível criar Steering com ArrayList<SteeringBehavior> nulo.";

    this.behaviors = behaviors;
  }

  void accumulateForces(PVector runningTotal) {
    for (SteeringBehavior behavior : behaviors)
      if (!accumulateForce(runningTotal, behavior.steeringForce()))
        break;
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

class WallAvoidanceBehavior extends SteeringBehavior {
  WallSensor sensor;

  WallAvoidanceBehavior(WallSensor sensor) {
assert sensor != null :
    "Não é possível criar WallAvoidanceBehavior com WallSensor nulo.";

    this.sensor = sensor;
    this.enabled = true;
  }

  boolean avoidingWalls() {
    return (sensor.enabled && sensor.obstacleLocation.mag() > 0);
  }

  PVector computeAvoidanceForce() {
    // força deve ser proporcional na direção oposta ao obstáculo.
    PVector force = new PVector();
    sensor.read();
    if (sensor.obstacleLocation.mag() > 0) {
      if (sensor.obstacleLocation.x != 0) force.x = -sensor.range/sensor.obstacleLocation.x;
      if (sensor.obstacleLocation.y != 0) force.y = -sensor.range/sensor.obstacleLocation.y;
      if (sensor.obstacleLocation.z != 0) force.z = -sensor.range/sensor.obstacleLocation.z;
      //force.mult(owner.body.move.currentSpeed());
    }
    return force;
  }

  PVector steeringForce() {
    PVector force = new PVector();

    if (enabled) force = computeAvoidanceForce();

    return force;
  }
}

class WanderingBehavior extends SteeringBehavior {
  PVector steeringForce() {
    PVector force = PVector.random2D();
    force.normalize();
    return force;
  }
}

