
# PlanAhead Launch Script for Post-Synthesis floorplanning, created by Project Navigator

create_project -name MT9V034_test -dir "C:/Users/georges/Documents/GitHub/MQP/MT9V034_test/planAhead_run_1" -part xc6slx16csg324-3
set_property design_mode GateLvl [get_property srcset [current_run -impl]]
set_property edif_top_file "C:/Users/georges/Documents/GitHub/MQP/MT9V034_test/mt9v034_top.ngc" [ get_property srcset [ current_run ] ]
add_files -norecurse { {C:/Users/georges/Documents/GitHub/MQP/MT9V034_test} {ipcore_dir} }
set_property target_constrs_file "mt9v034_top.ucf" [current_fileset -constrset]
add_files [list {mt9v034_top.ucf}] -fileset [get_property constrset [current_run]]
link_design
