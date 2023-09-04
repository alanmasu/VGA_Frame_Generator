----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/17/2023 05:02:53 PM
-- Design Name: 
-- Module Name: test - Behavioral
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

entity test is
--  Port ( );
end test;

architecture Behavioral of test is
    signal clk, vs, hs, sel : std_logic := '0';
    signal r, g, b, r_out, b_out, g_out : std_logic_vector(3 downto 0) := (others => '0');
    signal active, rst, res: std_logic := '0';
    signal v_count, h_count : std_logic_vector(9 downto 0);
begin
    
    gen : entity work.frame_generator
    port map(
        clk => clk,
        res => res,
        sel => sel,
        r_out => r,
        g_out => g,
        b_out => b,
        active => active,
        v_count_in => v_count,
        h_count_in => h_count
    );

    driver : entity work.vga_driver
    port map(
        clk => clk,
        res => res,
        r_in => r,
        g_in => g,
        b_in => b,
        r_out => r_out,
        g_out => g_out,
        b_out => b_out,
        vs => vs,
        hs => hs, 
        active => active, 
        v_count_out => v_count,
        h_count_out => h_count
    );

    process begin
        clk <= '1'; wait for 5 ns;
        clk <= '0'; wait for 5 ns;
    end process;   
   
    process begin
        res <= '0';
        wait for 9 ns;
        res <= '1';
        wait;
    end process;
    
end Behavioral;
            