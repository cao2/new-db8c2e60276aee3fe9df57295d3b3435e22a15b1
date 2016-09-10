
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity gfx is
    Port (  Clock: in std_logic;
            reset: in std_logic;
            pwrreq: in std_logic_vector(2 downto 0);
            pwrres: out std_logic_vector(2 downto 0));
end gfx;

architecture Behavioral of gfx is
   signal poweron: std_logic :='1';
begin
    
  process (Clock)
   begin
    if reset ='1' then
        pwrres<=(others => '0');
        
    elsif (rising_edge(Clock)) then
    	if pwrreq(2 downto 2)="1" then
    		if pwrreq( 1 downto 0) = "00" then
    			poweron <= '0';
    		elsif pwrreq(1 downto 0) ="10" then
    			poweron <= '1';
    		end if;
    		pwrres <= pwrreq;
    	else
    		pwrres <= "000";
    	end if;
        
    end if;
    end process;

end Behavioral;
