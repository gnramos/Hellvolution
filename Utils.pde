/** @file Utils.pde
 * Define funções/classes auxiliares.
 *
 * @author Guilherme N. Ramos (gnramos@unb.br)
 */


/***********
 * Funções *
 ***********/

/** Overload da função original com argumento PositionComponent. */
void translate(Physics2DComponent physics2D) {
  translate(physics2D.position.location.x, physics2D.position.location.y);
}

/** Overload da função original com argumento PositionComponent. */
void rotate(Physics2DComponent physics2D) {
  rotate(physics2D.position.headingAngle);
}


float randomShapeSize() {
  return random(Configs.Component.Shape.Min.Size, Configs.Component.Shape.Max.Size);
}

ShapeComponent randomShapeComponent() {
  float prob = random(1);
  if (prob < 0.5)
    return new CircleShape(randomShapeSize());
  else
    return new SquareShape(randomShapeSize());
}

color randomColor() {
  return color(random(Configs.Processing.Color.Max), random(Configs.Processing.Color.Max), random(Configs.Processing.Color.Max));
}

float randomStrokeWeight() {
  return random(Configs.Component.Style.Min.StrokeWeight, Configs.Component.Style.Max.StrokeWeight);
}

StyleComponent randomStyleComponent() {
  return new StyleComponent(randomColor(), randomColor(), randomStrokeWeight());
}

PositionComponent randomPositionComponent() {
  return new PositionComponent(250, 250/*random(width), random(height)*/, 0, random(TWO_PI));
}

Movement2DComponent randomMovement2DComponent() {
  return new Movement2DComponent(PVector.random2D(), PVector.random2D());
}

float randomMass() {
  return random(Configs.Component.Physics2D.Min.Mass, Configs.Component.Physics2D.Max.Mass);
}

Physics2DComponent randomPhysics2DComponent() {
  return new Physics2DComponent(randomMass(), randomMovement2DComponent(), randomPositionComponent());
}

BodyComponent randomBodyComponent() {
  return new BodyComponent(randomShapeComponent(), randomStyleComponent(), randomPhysics2DComponent());
}

Unnamed randomUnnamed() {
  BodyComponent body = randomBodyComponent();
  WallSensor wallSensor = new WallSensor(body.physics2D.position, 2*body.shape.size);
  return new Unnamed(body, new WallAvoidanceBehavior(wallSensor));
}

/**************
 * Interfaces *
 **************/

interface Displayable {
  void display();
}

interface Updatable {
  void update();
}

