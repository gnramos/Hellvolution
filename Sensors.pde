/** @file Sensors.pde
 * Define sensores.
 *
 * @author Guilherme N. Ramos (gnramos@unb.br)
 */

abstract class SensorComponent extends Component {
  boolean enabled;

  SensorComponent() {
    this.enabled = true;
  }

  abstract void read();
}

abstract class ProximitySensor extends SensorComponent {
  PositionComponent position;
  float   range;
  PVector obstacleLocation; /* Relativa a posição. */

  ProximitySensor(PositionComponent position, float range) {
assert position != null: 
    "PositionComponent do ProximitySensor não pode ser nulo.";
assert range > 0 :
    "Não é possível criar um ProximitySensor sem alcance.";

    this.position = position;
    this.range = range;
    this.obstacleLocation = new PVector();
  }
}

class WallSensor extends ProximitySensor {
  WallSensor(PositionComponent position, float range) {
    super(position, range);
  }

  float readingToClosestWall(float currentPosition, float positionThreshold) {
    /* Assume-se que as posições são limitadas a [0, positionThreshold]. */
    if (currentPosition < range) return -currentPosition;
    if (currentPosition > positionThreshold - range) return positionThreshold-currentPosition;
    return 0;
  }

  void read() {
    if (enabled) {
      obstacleLocation.x = readingToClosestWall(position.location.x, width);
      obstacleLocation.y = readingToClosestWall(position.location.y, height);
    }
  }
}

class UnnamedSensor extends ProximitySensor {
  ArrayList<Unnamed> visible;
  
  UnnamedSensor(PositionComponent position, float range) {
    super(position, range);

    visible = new ArrayList<Unnamed>();
  }

  boolean isVisible(Unnamed that) {
    double d = dist(this.position, that.body.physics2D.position) - that.body.shape.size;
    return (d <= range);
  }

  void read() {
    visible.clear();
    if (!enabled) return;

    for (Unnamed unnamed : unnamedList)
      if (isVisible(unnamed))
        visible.add(unnamed);
  }
}

