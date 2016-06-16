
# PlanAhead Launch Script for Pre-Synthesis Floorplanning, created by Project Navigator

create_project -name Moebius -dir "/mnt/Daten/Dokumente/studium/vhdl/hpi-vhdl-2016/pue2/Moebius/planAhead_run_3" -part xc7a100tcsg324-1
set_param project.pinAheadLayout yes
set srcset [get_property srcset [current_run -impl]]
set_property target_constrs_file "S_Reg.ucf" [current_fileset -constrset]
set hdlfile [add_files [list {S_Reg.vhd}]]
set_property file_type VHDL $hdlfile
set_property library work $hdlfile
set_property top S_Reg $srcset
add_files [list {S_Reg.ucf}] -fileset [get_property constrset [current_run]]
open_rtl_design -part xc7a100tcsg324-1
