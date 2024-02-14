
# PlanAhead Launch Script for Pre-Synthesis Floorplanning, created by Project Navigator

create_project -name rotary_shaft -dir "/media/aditikh22/KUSHAGRA/Lab5_1/rotary_shaft/planAhead_run_1" -part xc3s500efg320-4
set_param project.pinAheadLayout yes
set srcset [get_property srcset [current_run -impl]]
set_property target_constrs_file "rotary_shaft_encoder_top.ucf" [current_fileset -constrset]
set hdlfile [add_files [list {rotary_shaft_encoder.v}]]
set_property file_type Verilog $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {rotary_shaft.v}]]
set_property file_type Verilog $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {rotary_shaft_encoder_top.v}]]
set_property file_type Verilog $hdlfile
set_property library work $hdlfile
set_property top rotary_shaft_encoder_top $srcset
add_files [list {rotary_shaft_encoder_top.ucf}] -fileset [get_property constrset [current_run]]
open_rtl_design -part xc3s500efg320-4
