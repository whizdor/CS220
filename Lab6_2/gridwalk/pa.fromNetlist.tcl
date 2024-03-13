
# PlanAhead Launch Script for Post-Synthesis floorplanning, created by Project Navigator

create_project -name gridwalk -dir "/users/btech/aditikh22/gridwalk/planAhead_run_2" -part xc3s500efg320-4
set_property design_mode GateLvl [get_property srcset [current_run -impl]]
set_property edif_top_file "/users/btech/aditikh22/gridwalk/grid.ngc" [ get_property srcset [ current_run ] ]
add_files -norecurse { {/users/btech/aditikh22/gridwalk} }
set_property target_constrs_file "grid.ucf" [current_fileset -constrset]
add_files [list {grid.ucf}] -fileset [get_property constrset [current_run]]
link_design
