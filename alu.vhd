----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/01/2021 03:16:23 PM
-- Design Name: 
-- Module Name: alu - Behavioral
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity alu is
    port(
        A, B: in STD_LOGIC_VECTOR(31 downto 0);
        ALUCntl: in STD_LOGIC_VECTOR(3 downto 0);
        Carryin: in STD_LOGIC;
        Zero, Overflow, Carryout: out STD_LOGIC;
        ALUout: out STD_LOGIC_VECTOR(31 downto 0)
    );
end alu;

architecture Behavioral of alu is
begin
    process(A, B, ALUCntl, Carryin)
    
    VARIABLE check : STD_LOGIC_VECTOR(32 downto 0);
    VARIABLE x : STD_LOGIC;
    
    begin
        check := "000000000000000000000000000000000";
        x := '0';
        
        case ALUCntl is
            when "0000" =>
                check := ('0' & A) and ('0' & B);
            when "0001" =>
                check := ('0' & A) or ('0' & B);
            when "0011" =>
                check := ('0' & A) xor ('0' & B);
            when "0010" =>
                x := '1';
                if(Carryin = '1') then
                    check := ('0' & A) + ('0' & B) + Carryin;
                else
                    check := ('0' & A) + ('0' & B);
                end if;
            when "0110" =>
                x := '1';
                check := ('0' & A) + (('0' & not(B)) + '1'); -- subtraction using 2's comp
            when "1100" =>
                check := ('0' & A) nor ('0' & B);
            when others =>
                null;
        end case;
        
        ALUout <= check(31 downto 0);
        
        -- CHECK IF EQUAL TO 0
        if(check(31 downto 0) = x"00000000") then
            Zero <= '1';
        else
            Zero <= '0';
        end if;
        
        if(x = '1') then
            -- CHECK FOR CARRY OUT
            if(check(32) = '1') then
                Carryout <= '1';
            else
                Carryout <= '0';
            end if;
            
            -- CHECK FOR OVERFLOW
            if(check(32) /= check(31)) then
                Overflow <= '1';
            else
                Overflow <= '0';
            end if;
        else
            Carryout <= '0';
            Overflow <= '0';
        end if;
        
    end process;

end Behavioral;
