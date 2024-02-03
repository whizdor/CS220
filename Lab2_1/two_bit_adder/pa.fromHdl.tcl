
# PlanAhead Launch Script for Pre-Synthesis Floorplanning, created by Project Navigator

create_project -name two_bit_adder -dir "/media/aditikh22/HP USB20FD/CS220/Lab2_1/two_bit_adder/planAhead_run_2" -part xc3s500efg320-4
set_param project.pinAheadLayout yes
set srcset [get_property srcset [current_run -impl]]
set_property target_constrs_file "two_bit_adder.ucf" [current_fileset -constrset]
set hdlfile [add_files [list {two_bit_adder.v}]]
set_property file_type Verilog $hdlfile
set_property library work $hdlfile
set_property top two_bit_adder $srcset
add_files [list {two_bit_adder.ucf}] -fileset [get_property constrset [current_run]]
open_rtl_design -part xc3s500efg320-4
