
# PlanAhead Launch Script for Post-Synthesis floorplanning, created by Project Navigator

create_project -name two_bit_adder -dir "/media/aditikh22/HP USB20FD/CS220/Lab2_1/two_bit_adder/planAhead_run_3" -part xc3s500efg320-4
set_property design_mode GateLvl [get_property srcset [current_run -impl]]
set_property edif_top_file "/media/aditikh22/HP USB20FD/CS220/Lab2_1/two_bit_adder/two_bit_adder.ngc" [ get_property srcset [ current_run ] ]
add_files -norecurse { {/media/aditikh22/HP USB20FD/CS220/Lab2_1/two_bit_adder} }
set_property target_constrs_file "two_bit_adder.ucf" [current_fileset -constrset]
add_files [list {two_bit_adder.ucf}] -fileset [get_property constrset [current_run]]
link_design
