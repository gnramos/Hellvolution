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
  return new PositionComponent(random(width), random(height), 0, random(TWO_PI));
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

static float sizeToMass(float size) {
  return map(size, Configs.Component.Shape.Min.Size, Configs.Component.Shape.Max.Size,Configs.Component.Physics2D.Min.Mass, Configs.Component.Physics2D.Max.Mass);
}
static float massToSize(float mass) {
  return map(mass,Configs.Component.Physics2D.Min.Mass, Configs.Component.Physics2D.Max.Mass, Configs.Component.Shape.Min.Size, Configs.Component.Shape.Max.Size);
}

BodyComponent randomBodyComponent() {
  ShapeComponent shape = randomShapeComponent();
  Physics2DComponent physics2D = randomPhysics2DComponent();
  physics2D.mass = sizeToMass(shape.size);
  return new BodyComponent(shape, randomStyleComponent(), physics2D);
}

Unnamed randomUnnamed() {
  BodyComponent body = randomBodyComponent();
  ArrayList<SteeringBehavior> behaviors = new ArrayList<SteeringBehavior>();
  Steering steering = new Steering(behaviors);  
  Unnamed unnamed = new Unnamed(body, steering);
  
  WallSensor wallSensor = new WallSensor(body.physics2D.position, 2*body.shape.size);
  behaviors.add(new WallAvoidanceBehavior(unnamed, wallSensor));
//  behaviors.add(new FleeBehavior(unnamed, mouse));
//  behaviors.add(new WanderingBehavior(unnamed));
  
  return unnamed; 
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

