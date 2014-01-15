/** @file Shapes.pde
 * Define formas.
 *
 * @author Guilherme N. Ramos (gnramos@unb.br)
 */

class CircleShape extends ShapeComponent {
  CircleShape(float size) {
    super(size);
  }

  void display() {
    ellipse(0, 0, size, size);
  }
}

class SquareShape extends ShapeComponent {
  SquareShape(float size) {
    super(size);
  }

  void display() {
    rect(0, 0, size, size);
  }
}
