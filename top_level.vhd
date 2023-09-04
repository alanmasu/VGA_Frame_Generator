----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/17/2023 04:26:35 PM
-- Design Name: 
-- Module Name: top_level - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity top_level is
    Port ( clk : in STD_LOGIC;
           sel : in STD_LOGIC;
           r_out : out STD_LOGIC_VECTOR (3 downto 0);
           g_out : out STD_LOGIC_VECTOR (3 downto 0);
           b_out : out STD_LOGIC_VECTOR (3 downto 0);
           vs : out STD_LOGIC;
           hs : out STD_LOGIC);
end top_level;

architecture Behavioral of top_level is
    signal r, g, b : std_logic_vector(3 downto 0);
    signal active, rst: std_logic;
begin
    driver : entity work.vga_driver
    port map(
        clk => clk,
        res => '1',
        r_in => r,
        g_in => g,
        b_in => b,
        r_out => r_out,
        g_out => g_out,
        b_out => b_out,
        vs => vs,
        hs => hs, 
        active => active
    );
    gen : entity work.frame_generator
    port map(
        clk => clk,
        res => '1',
        sel => sel,
        r_out => r,
        g_out => g,
        b_out => b,
        active => active
    );

end Behavioral;
