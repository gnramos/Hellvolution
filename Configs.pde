/** @file Configs.pde
 * Define as configurações possíveis.
 *
 * @author Guilherme N. Ramos (gnramos@unb.br)
 */

/** Define o escopo das configurações. */
static class Configs {
  /** Define configurações das ações. */
  static class Actions {
    /** Define configurações de movimentação. */
    static class Movement {
      static float MaxAcceleration = 5; /**< Define a aceleração máxima. */
    }
  } // Actions
  static class Processing {
    static class Environment {    
      static class Frame {
        static final float   DisplayRatio = 0.9;  /**< Indica a razão entre o tamanho do frame e o do display. */
        static       int     Rate         = 30;   /**< Quadros por segundo. */
        static final boolean Resizable    = true; /**< Indica se o frame pode ter seu tamanho alterado. */
        static final int     Hint         = DISABLE_DEPTH_MASK;
        // Writing to the depth buffer is disabled to avoid rendering
        // artifacts due to the fact that the particles are semi-transparent
        // but not z-sorted.
      } // Frame

      static final boolean OpenGL = false; /**< Indica se deve-se utilizar a biblioteca OpenGL. */
    } // Environment

    static class Shape {
      static class Mode {
        static final int Rect = RADIUS;
        static final int Ellipse = RADIUS;
      } // Mode
      static int Smooth = 8;  /**< Qualidade de formas em escala (2, 4 ou 8). */
    } // Shape
  } // Processing
}

