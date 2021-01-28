source "helpers.tcl"
source ../src/ICeWall.tcl

read_lef ../../../test/sky130/sky130_tech.lef
read_lef ../../../test/sky130/sky130_std_cell.lef

read_lef coyote_tc/lef/sky130_fd_io__corner_bus_overlay.lef
read_lef coyote_tc/lef/sky130_fd_io__overlay_gpiov2.lef
read_lef coyote_tc/lef/sky130_fd_io__overlay_vccd_hvc.lef
read_lef coyote_tc/lef/sky130_fd_io__overlay_vccd_lvc.lef
read_lef coyote_tc/lef/sky130_fd_io__overlay_vdda_hvc.lef
read_lef coyote_tc/lef/sky130_fd_io__overlay_vdda_lvc.lef
read_lef coyote_tc/lef/sky130_fd_io__overlay_vddio_hvc.lef
read_lef coyote_tc/lef/sky130_fd_io__overlay_vddio_lvc.lef
read_lef coyote_tc/lef/sky130_fd_io__overlay_vssa_hvc.lef
read_lef coyote_tc/lef/sky130_fd_io__overlay_vssa_lvc.lef
read_lef coyote_tc/lef/sky130_fd_io__overlay_vssd_hvc.lef
read_lef coyote_tc/lef/sky130_fd_io__overlay_vssd_lvc.lef
read_lef coyote_tc/lef/sky130_fd_io__overlay_vssio_hvc.lef
read_lef coyote_tc/lef/sky130_fd_io__overlay_vssio_lvc.lef
read_lef coyote_tc/lef/sky130_fd_io__top_gpio_ovtv2.lef
read_lef coyote_tc/lef/sky130_fd_io__top_gpiov2.lef
read_lef coyote_tc/lef/sky130_fd_io__top_ground_hvc_wpad.lef
read_lef coyote_tc/lef/sky130_fd_io__top_ground_lvc_wpad.lef
read_lef coyote_tc/lef/sky130_fd_io__top_power_hvc_wpad.lef
read_lef coyote_tc/lef/sky130_fd_io__top_power_lvc_wpad.lef
read_lef coyote_tc/lef/sky130_fd_io__top_xres4v2.lef
read_lef coyote_tc/lef/sky130io_fill.lef

read_liberty ../../../test/sky130/sky130_tt.lib
read_liberty coyote_tc/lib/sky130_dummy_io.lib

read_verilog coyote_tc/1_synth.v

link_design coyote_tc

if {[catch {ICeWall load_footprint coyote_tc/coyote_tc.package.strategy} msg]} {
  puts $errorInfo
  puts $msg
  exit
}

initialize_floorplan \
  -die_area  {0 0 5400.000 4616.000} \
  -core_area {200.0 200.0 5200.0 4416.0} \
  -tracks    [ICeWall get_tracks] \
  -site      unit

if {[catch {ICeWall init_footprint coyote_tc/coyote_tc.sigmap} msg]} {
  puts $errorInfo
  puts $msg
  exit
}

set def_file results/coyote_tc_sky130.def

write_def $def_file
diff_files $def_file coyote_tc_sky130.defok