
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE ieee.numeric_std.ALL;
use work.nondeterminism.all;

entity Memory is
    Port (  Clock: in std_logic;
            reset: in std_logic;
            full_b_m: in std_logic;
            req : in STD_LOGIC_VECTOR(51 downto 0);
            wb_req: in std_logic_vector(50 downto 0);
            res: out STD_LOGIC_VECTOR(51 downto 0);
            wb_ack: out std_logic;
            full_m: out std_logic:='0');
end Memory;

architecture Behavioral of Memory is
     type rom_type is array (2**20-1 downto 0) of std_logic_vector (31 downto 0);     
     signal ROM_array : rom_type:= (others=> (others=>'0'));

begin
    
  process (Clock)
    
    variable tmplog: std_logic_vector(51 downto 0);
    variable enr: boolean:=false;
    variable enw: boolean:=true; 
    variable address: integer;
    variable flag: boolean:=false;
    variable nada: std_logic_vector(51 downto 0) :=(others=>'0');
    variable bo :boolean;
    variable nilmem: std_logic_vector(31 downto 0) := (others=>'0');
    variable tpmem: std_logic_vector(31 downto 0):= selection(2**31-1,32);
    begin
    if reset ='1' then
        res<=(others => '0');
        wb_ack <='0';
    elsif (rising_edge(Clock)) then
    --first set everything to default
       -- res<=nada;
        if req(50 downto 50) = "1" then
        	address:=to_integer(unsigned(req(47 downto 32)));
        	if (req(49 downto 48)="01") then
        		res<=req(51 downto 32) & ROM_array(address);
        	elsif (req(49 downto 48)="10") then
        		ROM_array(address) <= req(31 downto 0);
        		res<=req;
        	end if;
        	
        else
            res <= (others => '0');
        end if;
        
        if wb_req(50 downto 50) = "1" then
        	address:=to_integer(unsigned(wb_req(47 downto 32)));
        	ROM_array(address) <= wb_req(31 downto 0);
        	wb_ack <= '1';
        else
        	wb_ack <= '0';
        end if;
        
    end if;
    end process;

end Behavioral;
