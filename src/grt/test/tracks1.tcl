# layer range for clock nets. def file from the openroad-flow (modified gcd_sky130hs)
source "helpers.tcl"
read_liberty "sky130hs/sky130hs_tt.lib"
read_lef "sky130hs/sky130hs.tlef"
read_lef "sky130hs/sky130hs_std_cell.lef"

read_def "tracks1.def"

set guide_file [make_result_file tracks1.guide]

global_route

write_guides $guide_file

diff_file tracks1.guideok $guide_file
