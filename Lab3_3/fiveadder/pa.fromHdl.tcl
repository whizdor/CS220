
# PlanAhead Launch Script for Pre-Synthesis Floorplanning, created by Project Navigator

create_project -name fiveadder -dir "/media/aditikh22/HP USB20FD/CS220/Lab3_3/fiveadder/planAhead_run_3" -part xc3s500efg320-4
set_param project.pinAheadLayout yes
set srcset [get_property srcset [current_run -impl]]
set_property target_constrs_file "fiveadder.ucf" [current_fileset -constrset]
set hdlfile [add_files [list {fiveadder.v}]]
set_property file_type Verilog $hdlfile
set_property library work $hdlfile
set_property top fiveadder $srcset
add_files [list {fiveadder.ucf}] -fileset [get_property constrset [current_run]]
open_rtl_design -part xc3s500efg320-4
