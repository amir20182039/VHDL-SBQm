library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity seven_seg is
Port ( BCDin : in STD_LOGIC_VECTOR (7 downto 0);
Seven_Segment : out STD_LOGIC_VECTOR (13 downto 0));
end entity;
architecture Behavioral of seven_seg is
begin
process(BCDin)
begin
case BCDin is
when "00000000" =>
Seven_Segment <= "00000000000000"; ---0
when "00000001" =>
Seven_Segment <= "00000011001111"; ---1
when "00000010" =>
Seven_Segment <= "00000010010010"; ---2
when "00000011" =>
Seven_Segment <= "00000010000110"; ---3
when "00000100" =>
Seven_Segment <= "00000011001100"; ---4
when "00000101" =>
Seven_Segment <= "00000010100100"; ---5
when "00000110" =>
Seven_Segment <= "00000010100000"; ---6
when "00000111" =>
Seven_Segment <= "00000010001111"; ---7
when "00001000" =>
Seven_Segment <= "00000010000000"; ---8
when "00001001" =>
Seven_Segment <= "00000010000100"; ---9
when "00001010" =>
Seven_Segment <= "10011110000001"; ---10
when "00001011" =>
Seven_Segment <= "10011111001111"; ---11
when "00001100" =>
Seven_Segment <= "10011110010010"; ---12
when "00001101" =>
Seven_Segment <= "10011110000110"; ---13
when "00001110" =>
Seven_Segment <= "10011111001100"; ---14
when "00001111" =>
Seven_Segment <= "10011110100100"; ---15
when "00010000" =>
Seven_Segment <= "10011110100000"; ---16
when "00010001" =>
Seven_Segment <= "10011110001111"; ---17
when "00010010" =>
Seven_Segment <= "10011110000000"; ---18
when "00010011" =>
Seven_Segment <= "10011110000100"; ---19
when "00010100" =>
Seven_Segment <= "00100100000001"; ---20
when "00010101" =>
Seven_Segment <= "00100101001111"; ---21
when others =>  
Seven_Segment <= "00000010000001"; ---null
end case;
 
end process;
end Behavioral;
