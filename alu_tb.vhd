----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/02/2021 07:12:50 PM
-- Design Name: 
-- Module Name: alu_tb - Behavioral
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

entity alu_tb is
--  Port ( );
end alu_tb;

architecture Behavioral of alu_tb is
    signal a, b : STD_LOGIC_VECTOR(31 downto 0);
    signal aluCtrl : STD_LOGIC_VECTOR(3 downto 0);
    signal Cin, zero, oflow, Cout : STD_LOGIC;
    signal aluOut : STD_LOGIC_VECTOR(31 downto 0);
    
    CONSTANT delay : TIME := 50ns;
    
    component alu is
        port(
            A, B: in STD_LOGIC_VECTOR(31 downto 0);
            ALUCntl: in STD_LOGIC_VECTOR(3 downto 0);
            Carryin: in STD_LOGIC;
            Zero, Overflow, Carryout: out STD_LOGIC;
            ALUout: out STD_LOGIC_VECTOR(31 downto 0)
        );
    end component alu;
    
    begin
    dut : alu
        port map(
            A => a,
            B => b,
            ALUCntl => aluCtrl,
            Carryin => Cin,
            Zero => zero,
            Overflow => oflow,
            Carryout => Cout,
            ALUout => aluOut
        );
        
        process
        begin
            a <= x"FFFFFFFF";
            b <= x"00000000";
            aluCtrl <= "0000";
            Cin <= '0';
            wait for delay;
            
            a <= x"98989898";
            b <= x"89898989";
            aluCtrl <= "0001";
            wait for delay;
            
            a <= x"01010101";
            b <= x"10101010";
            aluCtrl <= "0011";
            wait for delay;
            
            a <= x"00000001";
            b <= x"FFFFFFFF";
            aluCtrl <= "0010";
            wait for delay;
            
            a <= x"6389754F";
            b <= x"AD5624E6";
            aluCtrl <= "0010";
            wait for delay;
            
            a <= x"00000001";
            b <= x"FFFFFFFF";
            aluCtrl <= "0010";
            Cin <= '1';
            wait for delay;
            
            a <= x"6389754F";
            b <= x"AD5624E6";
            aluCtrl <= "0010";
            wait for delay;
            
            a <= x"FFFFFFFF";
            b <= x"FFFFFFFF";
            aluCtrl <= "0010";
            wait for delay;
            
            a <= x"00000000";
            b <= x"00000001";
            aluCtrl <= "0110";
            wait for delay;
            
            a <= x"F9684783";
            b <= x"F998D562";
            aluCtrl <= "0110";
            wait for delay;
            
            a <= x"9ABCDEDF";
            b <= x"9ABCDEFD";
            aluCtrl <= "1100";
            wait for delay;
            
            a <= x"89BCDE34";
            b <= x"C53BD687";
            aluCtrl <= "0010";
            wait;
            
        end process;

end Behavioral;
