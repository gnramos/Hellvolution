/** @file Environments.pde
 * Define os ambientes possíveis.
 *
 * @author Guilherme N. Ramos (gnramos@unb.br)
 */
 
 /** Lida com o fundo de tela. */ 
 class Background implements Updatable {
   /** Construtor. */
   Background(){}
   
   // Overload
   void update() {
     background(Configs.Processing.Environment.Background.Color);
   }
 }
