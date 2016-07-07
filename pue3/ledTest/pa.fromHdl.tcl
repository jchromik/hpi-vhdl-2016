
# PlanAhead Launch Script for Pre-Synthesis Floorplanning, created by Project Navigator

create_project -name ledTest -dir "/mnt/Daten/Dokumente/studium/vhdl/hpi-vhdl-2016/pue3/ledTest/planAhead_run_2" -part xc7a100tcsg324-1
set_param project.pinAheadLayout yes
set srcset [get_property srcset [current_run -impl]]
set_property target_constrs_file "led.ucf" [current_fileset -constrset]
set hdlfile [add_files [list {led.vhd}]]
set_property file_type VHDL $hdlfile
set_property library work $hdlfile
set_property top led $srcset
add_files [list {led.ucf}] -fileset [get_property constrset [current_run]]
open_rtl_design -part xc7a100tcsg324-1
