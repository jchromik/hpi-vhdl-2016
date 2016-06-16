
# PlanAhead Launch Script for Pre-Synthesis Floorplanning, created by Project Navigator

create_project -name Prelldemo -dir "/mnt/Daten/Dokumente/studium/vhdl/hpi-vhdl-2016/pue2/Prelldemo/planAhead_run_2" -part xc7a100tcsg324-1
set_param project.pinAheadLayout yes
set srcset [get_property srcset [current_run -impl]]
set_property target_constrs_file "VDFF.ucf" [current_fileset -constrset]
set hdlfile [add_files [list {VDFF.vhd}]]
set_property file_type VHDL $hdlfile
set_property library work $hdlfile
set_property top VDFF $srcset
add_files [list {VDFF.ucf}] -fileset [get_property constrset [current_run]]
open_rtl_design -part xc7a100tcsg324-1
