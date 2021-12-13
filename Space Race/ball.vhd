LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
use ieee.numeric_std.all; 

ENTITY ball IS
	PORT (
		v_sync    : IN STD_LOGIC;
		pixel_row : IN STD_LOGIC_VECTOR(10 DOWNTO 0);
		pixel_col : IN STD_LOGIC_VECTOR(10 DOWNTO 0);
		red       : OUT STD_LOGIC;
		green     : OUT STD_LOGIC;
		blue      : OUT STD_LOGIC;
		data      : IN STD_LOGIC;
        movel      : IN STD_LOGIC;
        mover : IN STD_LOGIC;
        moveu : IN STD_LOGIC;
        moved : IN STD_LOGIC;
        movec : IN STD_LOGIC;
        sw0 : IN STD_LOGIC;
        sw1 : IN STD_LOGIC;
        sw2 : IN STD_LOGIC;
        points : OUT STD_LOGIC_VECTOR(3 DOWNTO 0) := "0000"
	);
END ball;

ARCHITECTURE Behavioral OF ball IS

	CONSTANT size  : INTEGER := 16; -- modify ball size from 8
	SIGNAL ball_on : STD_LOGIC; -- indicates whether ball is over current pixel position
	SIGNAL ball_row, ball_col : STD_LOGIC_VECTOR(10 DOWNTO 0);
	-- current ball position - intitialized to center of screen
	SIGNAL ball_x  : STD_LOGIC_VECTOR(10 DOWNTO 0) := CONV_STD_LOGIC_VECTOR(400, 11);
	SIGNAL ball_y  : STD_LOGIC_VECTOR(10 DOWNTO 0) := CONV_STD_LOGIC_VECTOR(575, 11);
	-- current ball motion - initialized to +4 pixels/frame
	SIGNAL ball_x_motion : STD_LOGIC_VECTOR(10 DOWNTO 0) := "00000000100";
	SIGNAL ball_y_motion : STD_LOGIC_VECTOR(10 DOWNTO 0) := "00000000100";
	SIGNAL hold : STD_LOGIC_VECTOR(10 DOWNTO 0);
	
	SIGNAL fruit_x : std_logic_vector (10 DOWNTO 0) := CONV_STD_LOGIC_VECTOR(400, 11);
	SIGNAL fruit_y : STD_LOGIC_VECTOR(10 DOWNTO 0) := CONV_STD_LOGIC_VECTOR(300, 11);
	SIGNAL fruit_x_motion : STD_LOGIC_VECTOR(10 DOWNTO 0) := "00000000100";
	SIGNAL fruit_on : STD_LOGIC;
	constant fruitsize : INTEGER := 16;
	SIGNAL count : STD_LOGIC_VECTOR(3 DOWNTO 0) := "0000";
	
	---------------------------------
	signal fruit_xpos0  : std_logic_vector (10 downto 0) := CONV_STD_LOGIC_VECTOR(100,11);
	signal fruit_ypos0  : std_logic_vector (10 downto 0) := CONV_STD_LOGIC_VECTOR(300,11);
	signal fruit_mot0  : std_logic_vector (10 downto 0) := "11111111100";
	signal fruit_on0 : std_logic;
	
	signal fruit_xpos1  : std_logic_vector (10 downto 0) := CONV_STD_LOGIC_VECTOR(300,11);
	signal fruit_ypos1  : std_logic_vector (10 downto 0) := CONV_STD_LOGIC_VECTOR(400,11);
	signal fruit_mot1  : std_logic_vector (10 downto 0) := "00000000100";
	signal fruit_on1 : std_logic;
	
	signal fruit_xpos2  : std_logic_vector (10 downto 0) := CONV_STD_LOGIC_VECTOR(200,11);
	signal fruit_ypos2  : std_logic_vector (10 downto 0) := CONV_STD_LOGIC_VECTOR(500,11);
	signal fruit_mot2  : std_logic_vector (10 downto 0) := "11111111000";
	signal fruit_on2 : std_logic;
	
	signal fruit_xpos3  : std_logic_vector (10 downto 0) := CONV_STD_LOGIC_VECTOR(600,11);
	signal fruit_ypos3  : std_logic_vector (10 downto 0) := CONV_STD_LOGIC_VECTOR(200,11);
	signal fruit_mot3  : std_logic_vector (10 downto 0) := CONV_STD_LOGIC_VECTOR(50,11);
	signal fruit_on3 : std_logic;
	
	signal fruit_xpos4  : std_logic_vector (10 downto 0) := CONV_STD_LOGIC_VECTOR(400,11);
	signal fruit_ypos4  : std_logic_vector (10 downto 0) := CONV_STD_LOGIC_VECTOR(100,11);
	signal fruit_mot4  : std_logic_vector (10 downto 0) := "11111111100";
	signal fruit_on4 : std_logic;
	
	signal fruit_xpos5  : std_logic_vector (10 downto 0) := CONV_STD_LOGIC_VECTOR(800,11);
	signal fruit_ypos5  : std_logic_vector (10 downto 0) := CONV_STD_LOGIC_VECTOR(100,11);
	signal fruit_mot5  : std_logic_vector (10 downto 0) := "00000000100";
	signal fruit_on5 : std_logic;
	
	signal fruit_xpos6  : std_logic_vector (10 downto 0) := CONV_STD_LOGIC_VECTOR(750,11);
	signal fruit_ypos6  : std_logic_vector (10 downto 0) := CONV_STD_LOGIC_VECTOR(450,11);
	signal fruit_mot6  : std_logic_vector (10 downto 0) := "11111111100";
	signal fruit_on6 : std_logic;
	
	signal fruit_xpos7  : std_logic_vector (10 downto 0) := CONV_STD_LOGIC_VECTOR(910,11);
	signal fruit_ypos7  : std_logic_vector (10 downto 0) := CONV_STD_LOGIC_VECTOR(350,11);
	signal fruit_mot7  : std_logic_vector (10 downto 0) := "00000000100";
	signal fruit_on7 : std_logic;
	
	signal fruit_xpos8  : std_logic_vector (10 downto 0) := CONV_STD_LOGIC_VECTOR(267,11);
	signal fruit_ypos8  : std_logic_vector (10 downto 0) := CONV_STD_LOGIC_VECTOR(250,11);
	signal fruit_mot8  : std_logic_vector (10 downto 0) := "11111110000";
	signal fruit_on8 : std_logic;
	
	signal fruit_xpos9  : std_logic_vector (10 downto 0) := CONV_STD_LOGIC_VECTOR(300,11);
	signal fruit_ypos9  : std_logic_vector (10 downto 0) := CONV_STD_LOGIC_VECTOR(300,11);
	signal fruit_mot9  : std_logic_vector (10 downto 0) := "00000010000";
	signal fruit_on9 : std_logic;
	------------------------------------------------
	
BEGIN

		  
		  
		  
		   red <=  ball_on or fruit_on0 or fruit_on1 or fruit_on2 or fruit_on3 or fruit_on4 or fruit_on5 or fruit_on6 or fruit_on7 or fruit_on8 or fruit_on9; -- color setup for red ball on white background
	       green <=  ball_on or fruit_on0 or fruit_on1 or fruit_on2 or fruit_on3 or fruit_on4 or fruit_on5 or fruit_on6 or fruit_on7 or fruit_on8 or fruit_on9;
	       blue  <=  ball_on or fruit_on0 or fruit_on1 or fruit_on2 or fruit_on3 or fruit_on4 or fruit_on5 or fruit_on6 or fruit_on7 or fruit_on8 or fruit_on9; -- modify ball color from red to magenta
		
	
	-- process to draw ball current pixel address is covered by ball position
	bdraw : PROCESS (ball_x, ball_y, ball_row, ball_col, movel, mover, moveu, moved) IS
	BEGIN
	
        --Drawing player
        IF (pixel_col >= ball_x - size) AND
		 (pixel_col <= ball_x + size) AND
			 (pixel_row >= ball_y - size) AND
			 (pixel_row <= ball_y + size) THEN
				ball_on <= '1';
		ELSE
			ball_on <= '0';
		END IF;
		
		END PROCESS;
		
		mball : PROCESS
		BEGIN
			WAIT UNTIL rising_edge(v_sync);
		
		--Motion Logic	
		IF mover = '1' AND ball_X < 800 - size then 
			  ball_x_motion <= "00000000010";
		ELSIF movel = '1' AND ball_x > size*2 then 
			  ball_x_motion <= "11111111110";
	    ELSE
	          ball_x_motion <= "00000000000";
	    END IF;
	    
		IF moved = '1' AND ball_y < 600 - size then
		      ball_y_motion <= "00000000010";
		ELSIF moveu = '1' AND ball_y > size then
		      ball_y_motion <= "11111111110";
		ELSE
		      ball_y_motion <= "00000000000";
		END IF;
		
		
		--COLLISION LOGIC
		
		
		      If(fruit_xpos0 + fruitsize*2 >= ball_x AND fruit_xpos0 - fruitsize*2  <= ball_x AND fruit_ypos0 + fruitsize*2 >= ball_y AND fruit_ypos0 - fruitsize*2 <= ball_y)
		      OR (count > 0 and fruit_xpos1 + fruitsize*2 >= ball_x AND fruit_xpos1 - fruitsize*2  <= ball_x AND fruit_ypos1 + fruitsize*2 >= ball_y AND fruit_ypos1 - fruitsize*2 <= ball_y)
		      or (count > 1 and fruit_xpos2 + fruitsize*2 >= ball_x AND fruit_xpos2 - fruitsize*2  <= ball_x AND fruit_ypos2 + fruitsize*2 >= ball_y AND fruit_ypos2 - fruitsize*2 <= ball_y)
		      or (count > 2 and fruit_xpos3 + fruitsize*2 >= ball_x AND fruit_xpos3 - fruitsize*2  <= ball_x AND fruit_ypos3 + fruitsize*2 >= ball_y AND fruit_ypos3 - fruitsize*2 <= ball_y)
		      or (count > 3 and fruit_xpos4 + fruitsize*2 >= ball_x AND fruit_xpos4 - fruitsize*2  <= ball_x AND fruit_ypos4 + fruitsize*2 >= ball_y AND fruit_ypos4 - fruitsize*2 <= ball_y)
		      or (count > 4 and fruit_xpos5 + fruitsize*2 >= ball_x AND fruit_xpos5 - fruitsize*2  <= ball_x AND fruit_ypos5 + fruitsize*2 >= ball_y AND fruit_ypos5 - fruitsize*2 <= ball_y)
		      or (count > 5 and fruit_xpos6 + fruitsize*2 >= ball_x AND fruit_xpos6 - fruitsize*2  <= ball_x AND fruit_ypos6 + fruitsize*2 >= ball_y AND fruit_ypos6 - fruitsize*2 <= ball_y)
		      or (count > 6 and fruit_xpos7 + fruitsize*2 >= ball_x AND fruit_xpos7 - fruitsize*2  <= ball_x AND fruit_ypos7 + fruitsize*2 >= ball_y AND fruit_ypos7 - fruitsize*2 <= ball_y)
		      or (count > 7 and fruit_xpos8 + fruitsize*2 >= ball_x AND fruit_xpos8 - fruitsize*2  <= ball_x AND fruit_ypos8 + fruitsize*2 >= ball_y AND fruit_ypos8 - fruitsize*2 <= ball_y)
		      or (count > 8 and fruit_xpos9 + fruitsize*2 >= ball_x AND fruit_xpos9 - fruitsize*2  <= ball_x AND fruit_ypos9 + fruitsize*2 >= ball_y AND fruit_ypos9 - fruitsize*2 <= ball_y)
		      
		      then
		          ball_x <= CONV_STD_LOGIC_VECTOR(400, 11);
		          ball_y <= CONV_STD_LOGIC_VECTOR(575, 11);
		          count <= "0000";
              elsif(ball_y < 25) then
                  ball_x <= CONV_STD_LOGIC_VECTOR(400, 11);
		          ball_y <= CONV_STD_LOGIC_VECTOR(575, 11);
		          if(count < 9) then
		              count <= count + "0001";
		          else
		              count <= "0000";
		          end if;
		      else
                  ball_y <= ball_y + ball_y_motion; -- compute next ball position
                  ball_x <= ball_x + ball_x_motion; -- compute next ball position
              end if;
              
        
        points <= count + 1;
        
		END PROCESS;
		
		fruitDraw0 : process (pixel_col,pixel_row) IS
		begin
		
		--Drawing NPC
		
		      IF ((((CONV_INTEGER(pixel_col)-CONV_INTEGER(fruit_xpos0))*
		      (CONV_INTEGER(pixel_col)-CONV_INTEGER(fruit_xpos0)))+
		      ((CONV_INTEGER(pixel_row)-CONV_INTEGER(fruit_ypos0))*
		      (CONV_INTEGER(pixel_row)-CONV_INTEGER(fruit_ypos0)))) <= (fruitsize*fruitsize)) THEN
				fruit_on0 <= '1';
		  ELSE
			    fruit_on0 <= '0';
		  END IF;
		
		
		end process;
		
		fruitDraw1 : process (pixel_col,pixel_row) IS
		begin
		if(count > 0) then
		      IF ((((CONV_INTEGER(pixel_col)-CONV_INTEGER(fruit_xpos1))*
		      (CONV_INTEGER(pixel_col)-CONV_INTEGER(fruit_xpos1)))+
		      ((CONV_INTEGER(pixel_row)-CONV_INTEGER(fruit_ypos1))*
		      (CONV_INTEGER(pixel_row)-CONV_INTEGER(fruit_ypos1)))) <= (fruitsize*fruitsize)) THEN
				fruit_on1 <= '1';
		  ELSE
			    fruit_on1 <= '0';
		  END IF;
		end if;
		end process;
		
		fruitDraw2 : process (pixel_col,pixel_row) IS
		begin
		if(count > 1) then
		      IF ((((CONV_INTEGER(pixel_col)-CONV_INTEGER(fruit_xpos2))*
		      (CONV_INTEGER(pixel_col)-CONV_INTEGER(fruit_xpos2)))+
		      ((CONV_INTEGER(pixel_row)-CONV_INTEGER(fruit_ypos2))*
		      (CONV_INTEGER(pixel_row)-CONV_INTEGER(fruit_ypos2)))) <= (fruitsize*fruitsize)) THEN
				fruit_on2 <= '1';
		  ELSE
			    fruit_on2 <= '0';
		  END IF;
		end if;
		end process;
		
		fruitDraw3 : process (pixel_col,pixel_row) IS
		begin
		if(count > 2) then
		      IF ((((CONV_INTEGER(pixel_col)-CONV_INTEGER(fruit_xpos3))*
		      (CONV_INTEGER(pixel_col)-CONV_INTEGER(fruit_xpos3)))+
		      ((CONV_INTEGER(pixel_row)-CONV_INTEGER(fruit_ypos3))*
		      (CONV_INTEGER(pixel_row)-CONV_INTEGER(fruit_ypos3)))) <= (fruitsize*fruitsize)) THEN
				fruit_on3 <= '1';
		  ELSE
			    fruit_on3 <= '0';
		  END IF;
		end if;
		end process;
		
		fruitDraw4 : process (pixel_col,pixel_row) IS
		begin
		if(count > 3) then
		      IF ((((CONV_INTEGER(pixel_col)-CONV_INTEGER(fruit_xpos4))*
		      (CONV_INTEGER(pixel_col)-CONV_INTEGER(fruit_xpos4)))+
		      ((CONV_INTEGER(pixel_row)-CONV_INTEGER(fruit_ypos4))*
		      (CONV_INTEGER(pixel_row)-CONV_INTEGER(fruit_ypos4)))) <= (fruitsize*fruitsize)) THEN
				fruit_on4 <= '1';
		  ELSE
			    fruit_on4 <= '0';
		  END IF;
		end if;
		end process;
		
		fruitDraw5 : process (pixel_col,pixel_row) IS
		begin
		if(count > 4) then
		      IF ((((CONV_INTEGER(pixel_col)-CONV_INTEGER(fruit_xpos5))*
		      (CONV_INTEGER(pixel_col)-CONV_INTEGER(fruit_xpos5)))+
		      ((CONV_INTEGER(pixel_row)-CONV_INTEGER(fruit_ypos5))*
		      (CONV_INTEGER(pixel_row)-CONV_INTEGER(fruit_ypos5)))) <= (fruitsize*fruitsize)) THEN
				fruit_on5 <= '1';
		  ELSE
			    fruit_on5 <= '0';
		  END IF;
		end if;
		end process;
		
		fruitDraw6 : process (pixel_col,pixel_row) IS
		begin
		if(count > 5) then
		      IF ((((CONV_INTEGER(pixel_col)-CONV_INTEGER(fruit_xpos6))*
		      (CONV_INTEGER(pixel_col)-CONV_INTEGER(fruit_xpos6)))+
		      ((CONV_INTEGER(pixel_row)-CONV_INTEGER(fruit_ypos6))*
		      (CONV_INTEGER(pixel_row)-CONV_INTEGER(fruit_ypos6)))) <= (fruitsize*fruitsize)) THEN
				fruit_on6 <= '1';
		  ELSE
			    fruit_on6 <= '0';
		  END IF;
		end if;
		end process;
		
		fruitDraw7 : process (pixel_col,pixel_row) IS
		begin
		if(count > 6) then
		      IF ((((CONV_INTEGER(pixel_col)-CONV_INTEGER(fruit_xpos7))*
		      (CONV_INTEGER(pixel_col)-CONV_INTEGER(fruit_xpos7)))+
		      ((CONV_INTEGER(pixel_row)-CONV_INTEGER(fruit_ypos7))*
		      (CONV_INTEGER(pixel_row)-CONV_INTEGER(fruit_ypos7)))) <= (fruitsize*fruitsize)) THEN
				fruit_on7 <= '1';
		  ELSE
			    fruit_on7 <= '0';
		  END IF;
		end if;
		end process;
		
		fruitDraw8 : process (pixel_col,pixel_row) IS
		begin
		if(count > 7) then
		      IF ((((CONV_INTEGER(pixel_col)-CONV_INTEGER(fruit_xpos8))*
		      (CONV_INTEGER(pixel_col)-CONV_INTEGER(fruit_xpos8)))+
		      ((CONV_INTEGER(pixel_row)-CONV_INTEGER(fruit_ypos8))*
		      (CONV_INTEGER(pixel_row)-CONV_INTEGER(fruit_ypos8)))) <= (fruitsize*fruitsize)) THEN
				fruit_on8 <= '1';
		  ELSE
			    fruit_on8 <= '0';
		  END IF;
		end if;
		end process;
		
		fruitDraw9 : process (pixel_col,pixel_row) IS
		begin
		if(count > 8) then
		      IF ((((CONV_INTEGER(pixel_col)-CONV_INTEGER(fruit_xpos9))*
		      (CONV_INTEGER(pixel_col)-CONV_INTEGER(fruit_xpos9)))+
		      ((CONV_INTEGER(pixel_row)-CONV_INTEGER(fruit_ypos9))*
		      (CONV_INTEGER(pixel_row)-CONV_INTEGER(fruit_ypos9)))) <= (fruitsize*fruitsize)) THEN
				fruit_on9 <= '1';
		  ELSE
			    fruit_on9 <= '0';
		  END IF;
		end if;
		end process;
		
		mfruit0 : process
		begin 
		WAIT UNTIL rising_edge(v_sync);
		
			IF fruit_xpos0 + size >= 800 THEN
				fruit_mot0 <= "11111111100"; -- -4 pixels
			ELSIF fruit_xpos0 <= size THEN
				fruit_mot0 <= "00000000100";
			END IF;
		      fruit_xpos0 <= fruit_xpos0 + fruit_mot0;
		end process;
		
		mfruit1 : process
		begin 
		WAIT UNTIL rising_edge(v_sync);
		
			IF fruit_xpos1 + size >= 800 THEN
				fruit_mot1 <= "11111111100"; -- -4 pixels
			ELSIF fruit_xpos1 <= size THEN
				fruit_mot1 <= "00000000100"; -- +4 pixels
			END IF;
			    fruit_xpos1 <= fruit_xpos1 + fruit_mot1; -- compute next ball position
		end process;
		
		mfruit2 : process
		begin 
		WAIT UNTIL rising_edge(v_sync);
		
			IF fruit_xpos2 + size >= 800 THEN
				fruit_mot2 <= "11111111100"; -- -4 pixels
			ELSIF fruit_xpos2 <= size THEN
				fruit_mot2 <= "00000000100"; -- +4 pixels
			END IF;
			    fruit_xpos2 <= fruit_xpos2 + fruit_mot2; -- compute next ball position
		end process;
		
		mfruit3 : process
		begin 
		WAIT UNTIL rising_edge(v_sync);
		
			IF fruit_xpos3 + size >= 800 THEN
				fruit_mot3 <= "11111111100"; -- -4 pixels
			ELSIF fruit_xpos3 <= size THEN
				fruit_mot3 <= "00000000100"; -- +4 pixels
			END IF;
			    fruit_xpos3 <= fruit_xpos3 + fruit_mot3; -- compute next ball position
		end process;
		
		mfruit4 : process
		begin 
		WAIT UNTIL rising_edge(v_sync);
		
			IF fruit_xpos4 + size >= 800 THEN
				fruit_mot4 <= "11111111100"; -- -4 pixels
			ELSIF fruit_xpos4 <= size THEN
				fruit_mot4 <= "00000000100"; -- +4 pixels
			END IF;
			    fruit_xpos4 <= fruit_xpos4 + fruit_mot4; -- compute next ball position
		end process;
		
		mfruit5 : process
		begin 
		WAIT UNTIL rising_edge(v_sync);
		
			IF fruit_xpos5 + size >= 800 THEN
				fruit_mot5 <= "11111111100"; -- -4 pixels
			ELSIF fruit_xpos5 <= size THEN
				fruit_mot5 <= "00000000100"; -- +4 pixels
			END IF;
			    fruit_xpos5 <= fruit_xpos5 + fruit_mot5; -- compute next ball position
		end process;
		
		mfruit6 : process
		begin 
		WAIT UNTIL rising_edge(v_sync);
		
			IF fruit_xpos6 + size >= 800 THEN
				fruit_mot6 <= "11111111100"; -- -4 pixels
			ELSIF fruit_xpos6 <= size THEN
				fruit_mot6 <= "00000000100"; -- +4 pixels
			END IF;
			    fruit_xpos6 <= fruit_xpos6 + fruit_mot6; -- compute next ball position
		end process;
		
		mfruit7 : process
		begin 
		WAIT UNTIL rising_edge(v_sync);
		
			IF fruit_xpos7 + size >= 800 THEN
				fruit_mot7 <= "11111111100"; -- -4 pixels
			ELSIF fruit_xpos7 <= size THEN
				fruit_mot7 <= "00000000100"; -- +4 pixels
			END IF;
			    fruit_xpos7 <= fruit_xpos7 + fruit_mot7; -- compute next ball position
		end process;
		
		mfruit8 : process
		begin 
		WAIT UNTIL rising_edge(v_sync);
		
			IF fruit_xpos8 + size >= 800 THEN
				fruit_mot8 <= "11111111100"; -- -4 pixels
			ELSIF fruit_xpos8 <= size THEN
				fruit_mot8 <= "00000000100"; -- +4 pixels
			END IF;
			    fruit_xpos8 <= fruit_xpos8 + fruit_mot8; -- compute next ball position
		end process;
		
		mfruit9 : process
		begin 
		WAIT UNTIL rising_edge(v_sync);
		
			IF fruit_xpos9 + size >= 800 THEN
				fruit_mot9 <= "11111111100"; -- -4 pixels
			ELSIF fruit_xpos9 <= size THEN
				fruit_mot9 <= "00000000100"; -- +4 pixels
			END IF;
			    fruit_xpos9 <= fruit_xpos9 + fruit_mot9; -- compute next ball position
		end process;
		
		
		
END Behavioral;