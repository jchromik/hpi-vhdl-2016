
# PlanAhead Launch Script for Pre-Synthesis Floorplanning, created by Project Navigator

create_project -name Fanoe -dir "/mnt/Daten/Dokumente/studium/vhdl/hpi-vhdl-2016/pue2/Fanoe/planAhead_run_1" -part xc7a100tcsg324-1
set_param project.pinAheadLayout yes
set srcset [get_property srcset [current_run -impl]]
set_property target_constrs_file "Fanoe.ucf" [current_fileset -constrset]
set hdlfile [add_files [list {Fanoe.vhd}]]
set_property file_type VHDL $hdlfile
set_property library work $hdlfile
set_property top Fanoe $srcset
add_files [list {Fanoe.ucf}] -fileset [get_property constrset [current_run]]
open_rtl_design -part xc7a100tcsg324-1
