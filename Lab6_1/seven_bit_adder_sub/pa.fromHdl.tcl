
# PlanAhead Launch Script for Pre-Synthesis Floorplanning, created by Project Navigator

create_project -name seven_bit_adder_sub -dir "/users/btech/aditikh22/seven_bit_adder_sub/planAhead_run_1" -part xc3s500efg320-4
set_param project.pinAheadLayout yes
set srcset [get_property srcset [current_run -impl]]
set_property target_constrs_file "seven_bit_adder_sub.ucf" [current_fileset -constrset]
set hdlfile [add_files [list {rotary_shaft.v}]]
set_property file_type Verilog $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {full_operator.v}]]
set_property file_type Verilog $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {seven_bit_adder_sub.v}]]
set_property file_type Verilog $hdlfile
set_property library work $hdlfile
set_property top seven_bit_adder_sub $srcset
add_files [list {seven_bit_adder_sub.ucf}] -fileset [get_property constrset [current_run]]
open_rtl_design -part xc3s500efg320-4
