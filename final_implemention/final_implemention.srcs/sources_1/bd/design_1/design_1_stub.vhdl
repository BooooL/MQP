-- Copyright 1986-2016 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2016.2 (win64) Build 1577090 Thu Jun  2 16:32:40 MDT 2016
-- Date        : Tue Dec 13 21:30:24 2016
-- Host        : Georges-T460p running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode synth_stub
--               C:/Users/georges/Documents/GitHub/MQP/final_implemention/final_implemention.srcs/sources_1/bd/design_1/design_1_stub.vhdl
-- Design      : design_1
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7z020clg484-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity design_1 is
  Port ( 
    DDR_addr : inout STD_LOGIC_VECTOR ( 14 downto 0 );
    DDR_ba : inout STD_LOGIC_VECTOR ( 2 downto 0 );
    DDR_cas_n : inout STD_LOGIC;
    DDR_ck_n : inout STD_LOGIC;
    DDR_ck_p : inout STD_LOGIC;
    DDR_cke : inout STD_LOGIC;
    DDR_cs_n : inout STD_LOGIC;
    DDR_dm : inout STD_LOGIC_VECTOR ( 3 downto 0 );
    DDR_dq : inout STD_LOGIC_VECTOR ( 31 downto 0 );
    DDR_dqs_n : inout STD_LOGIC_VECTOR ( 3 downto 0 );
    DDR_dqs_p : inout STD_LOGIC_VECTOR ( 3 downto 0 );
    DDR_odt : inout STD_LOGIC;
    DDR_ras_n : inout STD_LOGIC;
    DDR_reset_n : inout STD_LOGIC;
    DDR_we_n : inout STD_LOGIC;
    FIFO_DATA : in STD_LOGIC_VECTOR ( 7 downto 0 );
    FIFO_OE1 : out STD_LOGIC;
    FIFO_OE2 : out STD_LOGIC;
    FIFO_RCK : out STD_LOGIC;
    FIFO_RRST1 : out STD_LOGIC;
    FIFO_RRST2 : out STD_LOGIC;
    FIXED_IO_ddr_vrn : inout STD_LOGIC;
    FIXED_IO_ddr_vrp : inout STD_LOGIC;
    FIXED_IO_mio : inout STD_LOGIC_VECTOR ( 53 downto 0 );
    FIXED_IO_ps_clk : inout STD_LOGIC;
    FIXED_IO_ps_porb : inout STD_LOGIC;
    FIXED_IO_ps_srstb : inout STD_LOGIC;
    button : in STD_LOGIC;
    cam_reset : out STD_LOGIC;
    cam_rst : in STD_LOGIC;
    cam_sysclk : out STD_LOGIC;
    cam_trigger : out STD_LOGIC;
    fpga_clk : in STD_LOGIC;
    hsync : out STD_LOGIC;
    leds : out STD_LOGIC_VECTOR ( 7 downto 0 );
    reset : in STD_LOGIC;
    rgb : out STD_LOGIC_VECTOR ( 11 downto 0 );
    sw : in STD_LOGIC_VECTOR ( 7 downto 0 );
    vsync : out STD_LOGIC
  );

end design_1;

architecture stub of design_1 is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "DDR_addr[14:0],DDR_ba[2:0],DDR_cas_n,DDR_ck_n,DDR_ck_p,DDR_cke,DDR_cs_n,DDR_dm[3:0],DDR_dq[31:0],DDR_dqs_n[3:0],DDR_dqs_p[3:0],DDR_odt,DDR_ras_n,DDR_reset_n,DDR_we_n,FIFO_DATA[7:0],FIFO_OE1,FIFO_OE2,FIFO_RCK,FIFO_RRST1,FIFO_RRST2,FIXED_IO_ddr_vrn,FIXED_IO_ddr_vrp,FIXED_IO_mio[53:0],FIXED_IO_ps_clk,FIXED_IO_ps_porb,FIXED_IO_ps_srstb,button,cam_reset,cam_rst,cam_sysclk,cam_trigger,fpga_clk,hsync,leds[7:0],reset,rgb[11:0],sw[7:0],vsync";
begin
end;
