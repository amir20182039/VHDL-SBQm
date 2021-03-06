library ieee;
use ieee.std_logic_1164.all;
use std.textio.all;
use ieee.std_logic_textio.all;

entity tb_proj is
end entity tb_proj;

architecture test_proj of tb_proj is

component SBQM_SYSTEM 
			GENERIC( 
			N : POSITIVE :=3
			);

			PORT	(
			RESET, CLK: IN STD_LOGIC;
			PHOTOCELL	:IN STD_LOGIC_VECTOR (1 DOWNTO 0);
			ROM_OUT_DECODER_1: OUT STD_LOGIC_VECTOR (6 DOWNTO 0);
			ROM_OUT_DECODER_2: OUT STD_LOGIC_VECTOR (6 DOWNTO 0);
			PCOUNT_OUT_DECODER_3: OUT STD_LOGIC_VECTOR (6 DOWNTO 0);
			TCOUNT_IN_ENCODER: IN STD_LOGIC_VECTOR (1 DOWNTO 0)
			);

end component SBQM_SYSTEM ;

for fsm : SBQM_SYSTEM use entity work.SBQM_SYSTEM (BEHAV);

----------signal----------
signal rst                    : std_logic;
signal clk                    : std_logic;
signal photocell              :std_logic_vector (1 downto 0);
signal rom_out_decoder_1      :std_logic_vector (6 downto 0);
signal rom_out_decoder_2      :std_logic_vector (6 downto 0);
signal pcount_out_decoder     :std_logic_vector (6 downto 0);
signal tcount_in_encoder      :std_logic_vector(1 downto 0);
begin

------- object------------
fsm: SBQM_SYSTEM port map( rst,clk,photocell,rom_out_decoder_1,rom_out_decoder_2 ,pcount_out_decoder,tcount_in_encoder  );
process is
---------opem file------------
file file_test : text open read_mode is "input_vectors.txt";
file file_output  :text open write_mode is "output_vectors.txt";

variable l:line;
variable o1 : line;
variable clk_in_file,rst_in_file    :std_logic;
variable photocell_in_file          :std_logic_vector (1 downto 0);             
variable rom_out_decoder_1_out_file :std_logic_vector (6 downto 0);
variable rom_out_decoder_2_out_file :std_logic_vector (6 downto 0);
variable pcount_out_decoder_out_file :std_logic_vector (6 downto 0);
variable tcount_in_encoder_in_file   :std_logic_vector(1 DOWNTO 0);
variable pause :time;
variable message : string (1 to 3);
variable o_message: string (1 to 7 ) :="qout = " ;
variable o_q_out : std_logic;

begin

---------initializing inputs---------------
rst <='0'; clk <= '1'; photocell<="10"; tcount_in_encoder <="10";

----------loop to read from file----------

while not endfile (file_test) loop

readline (file_test,l);

read (l, rst_in_file);
read (l, clk_in_file);
read (l, photocell_in_file);
read (l, tcount_in_encoder_in_file);
read (l ,pause);
read (l , rom_out_decoder_1_out_file );
read (l ,rom_out_decoder_2_out_file  );
read (l ,pcount_out_decoder_out_file );
read (l , message );

------assigning imported------
rst <= rst_in_file; clk<= clk_in_file; tcount_in_encoder <= tcount_in_encoder_in_file; photocell <=photocell_in_file;

---------- writing output to file---------
write (o1,o_message);
write (o1,rom_out_decoder_1);
write (o1,rom_out_decoder_2);
write (o1,pcount_out_decoder);
writeline (file_output ,o1);

--------------wait and assert statments for debugging ----------------

wait for pause;
assert rom_out_decoder_1= rom_out_decoder_1_out_file
report "design error";
assert rom_out_decoder_2= rom_out_decoder_2_out_file
report "design error";
assert pcount_out_decoder= pcount_out_decoder_out_file
report "design error"
SEVERITY warning;
end loop;
-------closing files -----------------

file_close (file_test);
file_close(file_output);
    wait;
  end process;
end architecture test_proj;