
# PlanAhead Launch Script for Pre-Synthesis Floorplanning, created by Project Navigator

create_project -name MUX-Verb -dir "/home/scandic/VHDL/MUX-Verb/planAhead_run_4" -part xc7a100tcsg324-1
set_param project.pinAheadLayout yes
set srcset [get_property srcset [current_run -impl]]
set_property target_constrs_file "pUe11.ucf" [current_fileset -constrset]
set hdlfile [add_files [list {pUe11.vhd}]]
set_property file_type VHDL $hdlfile
set_property library work $hdlfile
set_property top pUe11 $srcset
add_files [list {pUe11.ucf}] -fileset [get_property constrset [current_run]]
open_rtl_design -part xc7a100tcsg324-1
