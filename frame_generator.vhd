----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/16/2023 08:49:06 PM
-- Design Name: 
-- Module Name: frame_generator - Behavioral
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
-- arithmetic functions with Signed or Unsigned architecture
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity frame_generator is
    Port ( clk : in STD_LOGIC;
           res : in std_logic;
           active : in STD_LOGIC;
           h_count_in : in STD_LOGIC_VECTOR(9 downto 0);
           v_count_in : in STD_LOGIC_VECTOR(9 downto 0);
           sel : in std_logic;
           r_out : out STD_LOGIC_VECTOR (3 downto 0);
           g_out : out STD_LOGIC_VECTOR (3 downto 0);
           b_out : out STD_LOGIC_VECTOR (3 downto 0)
    );
end frame_generator;

architecture Behavioral of frame_generator is
    signal vga_clk : std_logic;
    signal clk_divider : unsigned(1 downto 0);
    signal v_count, h_count : unsigned(9 downto 0);
    signal color_r, color_g, color_b : unsigned(3 downto 0) := "0000";
    signal timing : unsigned(24 downto 0);
    constant v_max : unsigned (9 downto 0) := to_unsigned(524, 10);
    constant h_max : unsigned (9 downto 0) := to_unsigned(799, 10);
begin

    --Equazioni
    v_count <= unsigned(v_count_in);
    h_count <= unsigned(h_count_in);

    vga_clk_gen : process( clk, res )  begin
        if res = '0' then
            clk_divider <= (others => '0');
            vga_clk <= '0';
        elsif rising_edge(clk) then
            vga_clk <= '0';
            clk_divider <= clk_divider + 1;
            if clk_divider = 3 then
                vga_clk <= '1';
            end if ;
        end if ;
    end process ; -- vga_clk_gen
    
    -- counter_generator : process( vga_clk, res ) begin
    --    if res = '0' then
    --        v_count <= (others => '0');
    --        h_count <= (others => '0');
    --    elsif rising_edge(vga_clk) then
    --         h_count <= h_count + 1;
    --         if h_count = h_max - 1 then
    --             v_count <= v_count + 1;
    --             h_count <= (others => '0');
    --             if v_count = v_max - 1  then
    --                 v_count <= (others => '0');
    --                 h_count <= (others => '0');
    --             end if ;
    --         end if ; 
    --     end if ;
    -- end process ; -- counter_generator

    frame_generator : process( clk, res) begin
        if res = '0' then
--            color_r <= "0000";
            color_g <= "0000";
            color_b <= "0000";
        elsif rising_edge(clk) then            
            if active = '1' then
                if sel = '1' then
                    if v_count <= 120 then
                        r_out <= std_logic_vector(color_r);
                        g_out <= "0000";
                        b_out <= "0000";
                    elsif v_count > 120 and v_count <= 240 then
                        r_out <= "0000";
                        g_out <= std_logic_vector(color_g);
                        b_out <= "0000";
                    elsif v_count > 240 and v_count <= 320 then
                        r_out <= "0000";
                        g_out <= "0000";
                        b_out <= std_logic_vector(color_b);
                    elsif v_count > 360 and v_count <= 480 then
                        r_out <= "1100";
                        g_out <= "1100";
                        b_out <= "1100";
                    end if ;    
                elsif sel = '0' then
                    if v_count <= 119 then
                        r_out <= "0110";
                        g_out <= "0000";
                        b_out <= "0000";
                    elsif v_count > 119 and v_count <= 239 then
                        r_out <= "0000";
                        g_out <= "0110";
                        b_out <= "0000";
                    elsif v_count > 239 and v_count <= 359 then
                        r_out <= "0000";
                        g_out <= "0000";
                        b_out <= "0110";
                    elsif v_count > 359 and v_count <= 479 then
                        r_out <= "1100";
                        g_out <= "1100";
                        b_out <= "1100";
                    end if ;    
                end if ;
            end if ;
             if timing = "1011111010111100001000000" then
                 color_r <= color_r + 1;
                 color_g <= color_g + 1;
                 color_b <= color_b + 1;
             end if ;
        end if;
    end process ; -- frame_generator

    timing_process : process(vga_clk, res) begin
        if res = '0' then
            timing <= (others => '0');
        elsif rising_edge (vga_clk) then
            timing <= timing + 1;
           if timing = "1011111010111100001000000" then
               timing <= (others => '0');
           end if ;
        end if ;
    end process ; --timing_process
end Behavioral;
