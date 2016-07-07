
# PlanAhead Launch Script for Pre-Synthesis Floorplanning, created by Project Navigator

create_project -name Keyboard -dir "/mnt/Daten/Dokumente/studium/vhdl/hpi-vhdl-2016/pue3/Keyboard/planAhead_run_3" -part xc7a100tcsg324-1
set_param project.pinAheadLayout yes
set srcset [get_property srcset [current_run -impl]]
set_property target_constrs_file "project_main.ucf" [current_fileset -constrset]
set hdlfile [add_files [list {scanner.vhd}]]
set_property file_type VHDL $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {RF_fetch.vhd}]]
set_property file_type VHDL $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {key2segments.vhd}]]
set_property file_type VHDL $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {output_main.vhd}]]
set_property file_type VHDL $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {keyboard-main.vhd}]]
set_property file_type VHDL $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {project_main.vhd}]]
set_property file_type VHDL $hdlfile
set_property library work $hdlfile
set_property top project_main $srcset
add_files [list {project_main.ucf}] -fileset [get_property constrset [current_run]]
open_rtl_design -part xc7a100tcsg324-1
