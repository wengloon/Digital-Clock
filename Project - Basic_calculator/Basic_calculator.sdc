## Generated SDC file "Basic_calculator.out.sdc"

## Copyright (C) 2018  Intel Corporation. All rights reserved.
## Your use of Intel Corporation's design tools, logic functions 
## and other software and tools, and its AMPP partner logic 
## functions, and any output files from any of the foregoing 
## (including device programming or simulation files), and any 
## associated documentation or information are expressly subject 
## to the terms and conditions of the Intel Program License 
## Subscription Agreement, the Intel Quartus Prime License Agreement,
## the Intel FPGA IP License Agreement, or other applicable license
## agreement, including, without limitation, that your use is for
## the sole purpose of programming logic devices manufactured by
## Intel and sold by Intel or its authorized distributors.  Please
## refer to the applicable agreement for further details.


## VENDOR  "Altera"
## PROGRAM "Quartus Prime"
## VERSION "Version 18.1.0 Build 625 09/12/2018 SJ Lite Edition"

## DATE    "Tue Feb 13 14:33:34 2024"

##
## DEVICE  "10M50DAF484C7G"
##


#**************************************************************
# Time Information
#**************************************************************

set_time_format -unit ns -decimal_places 3



#**************************************************************
# Create Clock
#**************************************************************

create_clock -name {clk} -period 20.000 -waveform { 0.000 10.000 } [get_ports {clk}]


#**************************************************************
# Create Generated Clock
#**************************************************************



#**************************************************************
# Set Clock Latency
#**************************************************************



#**************************************************************
# Set Clock Uncertainty
#**************************************************************

set_clock_uncertainty -rise_from [get_clocks {clk}] -rise_to [get_clocks {clk}]  0.020  
set_clock_uncertainty -rise_from [get_clocks {clk}] -fall_to [get_clocks {clk}]  0.020  
set_clock_uncertainty -fall_from [get_clocks {clk}] -rise_to [get_clocks {clk}]  0.020  
set_clock_uncertainty -fall_from [get_clocks {clk}] -fall_to [get_clocks {clk}]  0.020  

#**************************************************************
# Set Input Delay
#**************************************************************
set_input_delay  -max -clock [get_clocks {clk}]     [expr 20.000 - 5.000] [get_ports {slide_switch[*]}]
set_input_delay  -min -clock [get_clocks {clk}]                    2.000  [get_ports {slide_switch[*]}]
set_input_delay  -max -clock [get_clocks {clk}]     [expr 20.000 - 5.000] [get_ports {push_button[*]}]
set_input_delay  -min -clock [get_clocks {clk}]                    2.000  [get_ports {push_button[*]}]

#**************************************************************
# Set Output Delay
#**************************************************************



#**************************************************************
# Set Clock Groups
#**************************************************************



#**************************************************************
# Set False Path
#**************************************************************
set_false_path -from [get_clocks {clk}] -to [get_ports {led[*] }]
set_false_path -from [get_clocks {clk}] -to [get_ports {digitSeg[*] }]
set_false_path -from [get_clocks {clk}] -to [get_ports {tenSeg[*] }]
set_false_path -from [get_clocks {clk}] -to [get_ports {hundredSeg[*] }]
set_false_path -from [get_clocks {clk}] -to [get_ports {thousandSeg[*] }]
set_false_path -from [get_clocks {clk}] -to [get_ports {tenThousandSeg[*] }]
set_false_path -from [get_clocks {clk}] -to [get_ports {hundredThousandeg[*] }]

#**************************************************************
# Set Multicycle Path
#**************************************************************



#**************************************************************
# Set Maximum Delay
#**************************************************************



#**************************************************************
# Set Minimum Delay
#**************************************************************



#**************************************************************
# Set Input Transition
#**************************************************************

