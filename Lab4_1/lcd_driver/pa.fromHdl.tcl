
# PlanAhead Launch Script for Pre-Synthesis Floorplanning, created by Project Navigator

create_project -name lcd_driver -dir "/media/aditikh22/KUSHAGRA/Lab4_1/lcd_driver/planAhead_run_1" -part xc3s500efg320-4
set_param project.pinAheadLayout yes
set srcset [get_property srcset [current_run -impl]]
set_property target_constrs_file "LCD_Driver_top.ucf" [current_fileset -constrset]
set hdlfile [add_files [list {lcd_driver.v}]]
set_property file_type Verilog $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {lcd_driver_top.v}]]
set_property file_type Verilog $hdlfile
set_property library work $hdlfile
set_property top LCD_Driver_top $srcset
add_files [list {LCD_Driver_top.ucf}] -fileset [get_property constrset [current_run]]
open_rtl_design -part xc3s500efg320-4
