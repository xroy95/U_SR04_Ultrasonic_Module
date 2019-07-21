--------------------------------------------------------------------------------
-- Company: <Name>
--
-- File: Multiple_SR04_04.vhd
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

use IEEE.std_logic_1164.all;
library work;
use work.pkg_apb3.all;

entity Multiple_SR04_04 is
port (
    --<port_name> : <direction> <type>;
      reset : in std_logic;

      apb3_master : in apb3;
      apb3_master_Back : out apb3_Back;
	clk_sound_speed : IN  std_logic; -- example
	Pulse_In : IN  std_logic_vector(3 downto 0) ; -- Width represent disantce
	Trig_out : OUT  std_logic_vector(3 downto 0) -- >10us sperate by 83.3ms

    --<other_ports>;
);
end Multiple_SR04_04;
architecture architecture_Multiple_SR04_04 of Multiple_SR04_04 is
   -- signal, component etc. declarations
	signal Distance_array_Reg : apb3_Reg_array(3 downto 0); -- example



begin
  GEN_SR04_04 : FOR i IN 0 to 3 generate
    SR04_U: entity work.SR04 
    port map(
          clk_100M=>apb3_master.clk,
          clk_sound_speed=>clk_sound_speed,
          distance =>Distance_array_Reg(i),
          reset =>reset,
          Pulse_In=>Pulse_In(i),
          Trig_out =>Trig_out(i)
      );
  end generate GEN_SR04_04;
apb3_reader_sr04 : entity work.apb3_reader 
generic map( 
        Number_Reg => 4,
        REG_DEFINITION =>(R,R,R,R)
)
port map(
      reset =>reset,
      apb3_master =>apb3_master,
      apb3_master_Back =>apb3_master_Back,

      Regs_In =>Distance_array_Reg,
      Regs_Out=>open

);
   -- architecture body
end architecture_Multiple_SR04_04;
