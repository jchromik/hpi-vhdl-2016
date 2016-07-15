
# PlanAhead Launch Script for Pre-Synthesis Floorplanning, created by Project Navigator

create_project -name Audio -dir "/mnt/Daten/Dokumente/studium/vhdl/hpi-vhdl-2016/pue4/Audio/planAhead_run_2" -part xc7a100tcsg324-1
set_param project.pinAheadLayout yes
set srcset [get_property srcset [current_run -impl]]
set_property target_constrs_file "project_main.ucf" [current_fileset -constrset]
set hdlfile [add_files [list {seg_scancode_to_segments.vhd}]]
set_property file_type VHDL $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {kb_scanner.vhd}]]
set_property file_type VHDL $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {kb_rf_fetch.vhd}]]
set_property file_type VHDL $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {audio_scancode_to_divisor.vhd}]]
set_property file_type VHDL $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {segment_out.vhd}]]
set_property file_type VHDL $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {keyboard_in.vhd}]]
set_property file_type VHDL $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {audio_out.vhd}]]
set_property file_type VHDL $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {project_main.vhd}]]
set_property file_type VHDL $hdlfile
set_property library work $hdlfile
set_property top project_main $srcset
add_files [list {project_main.ucf}] -fileset [get_property constrset [current_run]]
open_rtl_design -part xc7a100tcsg324-1
