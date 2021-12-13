# Space Race

The player controls the square, and the computer controls the circles. The player can move up down left and right via the buttons on the FPGA.

The objective is to reach the top of the screen without being hit by an "asteroid." If you are hit, you reset to level 1. If you reach the top, you move on to the next level.

Every level, another asteroid is added. They move at different positions going left to right. The asteroids bounce off of the walls indefinitely.

The seven-segment display on the FPGA displays the current level. It will increment each time the player reaches the top of the screen, and reset to 1 when they are hit.

There are 10 levels. Once the player finishes the last level, the game resets to it's initial state at level 1.

The game is based off of the moving ball from lab 3. I was able to implement controllable motion to the ball by adding the buttons to the XDC file. By manipulating the motion variable for the bouncing ball, each button controls a direction of motion.

I added each ball individually as a separate function, I was trying to implement them with loops, but I could not solve the bugs it created. They work in three parts, the drawing, the motion, and the hitbox.

Each ball has its own variables for x, y, motion, and on. When you reach the next level, the ball is drawn and the hitbox is initialized.
