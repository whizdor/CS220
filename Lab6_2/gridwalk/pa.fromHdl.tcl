
# PlanAhead Launch Script for Pre-Synthesis Floorplanning, created by Project Navigator

create_project -name gridwalk -dir "/users/btech/aditikh22/gridwalk/planAhead_run_2" -part xc3s500efg320-4
set_param project.pinAheadLayout yes
set srcset [get_property srcset [current_run -impl]]
set_property target_constrs_file "grid.ucf" [current_fileset -constrset]
set hdlfile [add_files [list {full_operator.v}]]
set_property file_type Verilog $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {rotary_shft.v}]]
set_property file_type Verilog $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {five_bit_adder_subtractor.v}]]
set_property file_type Verilog $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {grid.v}]]
set_property file_type Verilog $hdlfile
set_property library work $hdlfile
set_property top grid $srcset
add_files [list {grid.ucf}] -fileset [get_property constrset [current_run]]
open_rtl_design -part xc3s500efg320-4
