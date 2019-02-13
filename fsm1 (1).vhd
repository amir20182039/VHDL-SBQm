library ieee;
use ieee.std_logic_1164.all;

	entity fsm is 
	port ( clk: in std_logic;	
		input: in std_logic_vector (1 downto 0) ; --output sensor
		output: out std_logic_vector(1 downto 0)); --input counter
	end entity fsm;

	architecture mealy_2p of fsm is 
		type state_type is (start,inc,dec);
		signal current_state: state_type;
		signal next_state: state_type;
	begin
		cs: process (clk)
			begin
			if(rising_edge(CLK)) then
				current_state <= next_state;
			end if;
	        end process cs;
	    ns : process (current_state,input) 
		        begin
		case current_state is
			when start =>
				if input= "00" then
					output <="11"; 	next_state <=start;
				elsif input= "11" then
				    output<="00"; 	next_state <= start;
                                elsif input= "10" then
				    next_state <= inc;
                                elsif input= "01" then
				    next_state <= dec;
				end if;
			when inc =>
				output <="10"; 
				if input= "00" then
				 next_state <=start;
				elsif input= "11" then
				    next_state <= start;
                                elsif input= "10" then
				    next_state <= inc;
                                elsif input= "01" then
				    next_state <= dec;
				end if;
                      when dec =>
				output <="01"; 
				if input= "00" then
				 next_state <=start;
				elsif input= "11" then
				    next_state <= start;
                                elsif input= "10" then
				    next_state <= inc;
                                elsif input= "01" then
				    next_state <= dec;
				end if;
		end case;
	   end process ns;
	end mealy_2p;