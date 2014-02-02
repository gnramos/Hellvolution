/** @file Specimen.pde
 * Define um indivíduo.
 *
 * @author Guilherme N. Ramos (gnramos@unb.br)
 */

class Sensors {
  SpecimenSensor specimen;
  WallSensor wall;


  void read() {
    if (specimen != null) specimen.read();
    if (wall != null) wall.read();
  }
}

class Specimen {
  BodyComponent body;
  Steering steering;

  Sensors sensors;

  Specimen(BodyComponent body, Steering steering) {
    this.body = body;
    this.steering = steering;

    sensors = new Sensors();
    sensors.specimen = new SpecimenSensor(this.body.physics2D.position, Configs.Component.Sensor.SizeToRangeRatio*this.body.shape.size);
  }

  void steer() {
    steering.accumulateForces(body.physics2D.movement.acceleration);
    body.updatePhysics2D();
    body.physics2D.movement.acceleration.mult(0);
  }

  void update() {
    sensors.read();

    steer();
  }

  void display() {
    body.display();

    dummyDisplayExtras();
  }

  void dummyDisplayExtras() {
    pushMatrix();
    translate(body.physics2D);
    // velocity
    strokeWeight(3);
    stroke(#0000FF);
    line(0, 0, body.physics2D.movement.velocity.x*10, body.physics2D.movement.velocity.y*10);

    // obstacle Force
    stroke(#FF0000);
    WallSensor sensor = (WallSensor)((WallAvoidanceBehavior)steering.behaviors.get(0)).sensor;
    line(0, 0, -sensor.obstacleLocation.x, -sensor.obstacleLocation.y);

    // Sensor para Specimen
    strokeWeight(1);
    stroke(body.style.strokeColor);
    noFill();
    ellipse(0, 0, this.sensors.specimen.range, this.sensors.specimen.range);
    for (Specimen unnamed : this.sensors.specimen.visible) {
      PVector d = PVector.sub(unnamed.sensors.specimen.position.location.get(), this.body.physics2D.position.location);
      line(0, 0, d.x, d.y);
    }

    popMatrix();
  }
}

