/** @file Configs.pde
 * Define as configurações possíveis.
 *
 * @author Guilherme N. Ramos (gnramos@unb.br)
 */

static class Configs {
  static class Behavior {    
    static class Steering {
      static class Max {
        static final float Force = 50;
      }
      
      static class Weight {
        static final float Flee = 2;
        static final float FlockAlignment = 0.5;
        static final float FlockCohesion = 0.2;
        static final float FlockSeparation = 0.3; // FlockAlignment+FlockCohesion+FlockSeparation = 1
        static final float Flock = 2;
        static final float Seek = 2;
        static final float WallAvoidance = 10;
        static final float Wandering = 1;
      }
    }
  }

  static class Component {
    static class Physics2D {
        static final float MassToSpeedRatio = 50;
      static class Max {
        static final float Mass = 100;
      }

      static class Min {
        static final float Mass = 5;
      }
    }
    
    static class Shape {
      static class Max {
        static final float Size = 25;
      }

      static class Min {
        static final float Size = 5;
      }
    }

    static class Sensor {
      static final float SizeToRangeRatio = 4;
    }
    
    static class Style {
      static class Max {
        static final float StrokeWeight = 5;
      }

      static class Min {
        static final float StrokeWeight = 1;
      }
    }
  }

  static class Processing {
    static class Color {
      static final int Mode  = RGB; /**<  Either RGB or HSB, corresponding to Red/Green/Blue and Hue/Saturation/Brightness. */
      static final float Max = 255; /**< Range for all color elements. */
    }

    static class Environment {
      static final color BackgroundColor = #FFFFFF;

      static class Frame {
        static final float   ToDisplayRatio = 0.9;
        static final int     Rate         = 30;
        static final boolean Resizable    = true;
        static final int     Hint         = DISABLE_DEPTH_MASK;
      }

      static final boolean UseOpenGL = false;
    }

    static class Shape {
      static final int EllipseMode = RADIUS;
      static final int RectMode    = RADIUS;
      static final int Smooth      = 8;
    }
  }
}

