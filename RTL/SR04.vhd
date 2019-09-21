--------------------------------------------------------------------------------
-- Company: <Name>
--
-- File: SR04.vhd
-- File history:
--      <Revision number>: <Date>: <Comments>
--      <Revision number>: <Date>: <Comments>
--      <Revision number>: <Date>: <Comments>
--
-- Description: 
--
-- <Description here>
--
-- Targeted device: <Family::SmartFusion2> <Die::M2S025> <Package::256 VF>
-- Author: <Name>
--
--------------------------------------------------------------------------------

library IEEE;

use ieee.std_logic_1164.all;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
entity SR04 is
port (
    --<port_name> : <direction> <type>;
    reset : IN  std_logic;
    clk_100M : IN  std_logic;
	clk_sound_speed : IN  std_logic; -- example
	Pulse_In : IN  std_logic; -- Width represent disantce
	Trig_out : OUT  std_logic; -- >10us sperate by 83.3ms
    Distance : OUT std_logic_vector(31 downto 0)  -- example
    --<other_ports>;
);
end SR04;
architecture architecture_SR04 of SR04 is
   -- signal, component etc. declarations
	signal Pulse_In_q1,Pulse_In_q2 : std_logic; -- example
	signal signal_name2 : std_logic_vector(1 downto 0) ; -- example
	signal counter_trig_out : std_logic_vector(15 downto 0) :=(others=>'0'); -- example
	signal counter_PulseIn : std_logic_vector(31 downto 0) ; -- example

begin
process (clk_sound_speed,reset) begin
  if reset ='0' then 
     Trig_out<='0';
     counter_trig_out<= (others=>'0');
  elsif (clk_sound_speed'event and clk_sound_speed='1') then
    if (unsigned(counter_trig_out )< 7) then Trig_out <='1'; 

            --met la sortie à 1 jusqu'a 
    else Trig_out <='0';               --la valeur du rapport cyclique
    end if;
    counter_trig_out <= counter_trig_out + 1;  
               
  end if;
end process;
process (clk_sound_speed,reset) begin
  if reset ='0' then 
     Pulse_In_q1<='0';
     Pulse_In_q2<='0';
     counter_PulseIn<= (others=>'0');
     Distance   <=(others=>'0');
  elsif (clk_sound_speed'event and clk_sound_speed='1') then
     Pulse_In_q1<=Pulse_In;
     Pulse_In_q2<=Pulse_In_q1;
    if (Pulse_In_q2 ='1' and Pulse_In_q1 ='1') then     counter_PulseIn <= counter_PulseIn + 1;                 
    elsif (unsigned(counter_trig_out )=0) then     
            counter_PulseIn <= (others=>'0');
            Distance   <=counter_PulseIn;
    end if;
  end if;
end process;
   -- architecture body
end architecture_SR04;
