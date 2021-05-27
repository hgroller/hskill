 Chip Assembly Do File Examples

    This contains examples of commands that are commonly used in do files for a chip assembly design.

    Comment lines are included to identify command functions and the chapter where the command is discussed in more detail.


    Using the rules did file editor

    # Applying Rules to Sets of Nets

    # Starting the rules did file editor

    rules_didfile edit



    Defining classes, groups, net pairs, bundles, and regions

    # Defining a class of nets

    define (class class4 Camino|CDIN\*)

    # Defining a group of fromtos

    define (group group1)

    define (group group1 (add_fromto (fromto Y-R X-R)))

    # Defining a group set

    define (group_set grpset1 (add_group group1))

    define (group_set grpset1 (add_group group2))

    # Defining a net pair

    define (pair (nets ADIN\[0\] ADIN\[1\]))

    # Defining a bundle of nets

    define (bundle bundle1 (nets ADIN\[0\] ADIN\[1\] ADIN\[2\] ADIN\[3\] ADIN\[4\] ADIN\[5\])(gap 1))

    # Defining a region

    define (region region1 (rect metal2 0 0 45 65))



    Setting Basic Rules

    # Setting the manufacturing grid

    grid manufacturing 0.01

    # Setting a wire grid

    grid wire .1 metal2 (direction x) (offset 0)

    grid wire .1 metal2 (direction y) (offset 0)

    # Setting a via grid

    grid via .1 (direction x) (offset 0) via1

    grid via .1 (direction y) (offset 0) via1

    # Setting a placement grid

    grid place 0.1 (direction x) (offset 0)

    grid place 0.1 (direction y) (offset 0)

    # Setting layer clearance (spacing) rules

    rule layer metal4 (clearance .4)

    rule layer metal4 (clearance .5 (type pin_wire))

    # Setting wire width rules

    rule layer metal4 (pin_width_taper up_down)

    # Setting width based clearance rules

    rule layer M2 (width_based_clear (width_thresh 5.0 (clear 1.5) (length_thresh 10.0 (clear 3.0)))

    (width_thresh 10.0 (clear 3.0) (length_thresh 10.0 (clear 5.0)))

    # Setting class, net, and region rules

    rule class critical1 (clearance 1.4 (type wire_wire))

    rule net SCLK (width 12)

    rule region region1 (width .8)

    rule region region1 (clearance .8(type wire_wire))

    # Setting via and pin rules

    rule layer metal2 (stack_via exact)

    rule layer metal2 (via_on_pin on (grid off) (fit on))

    rule IC(inter_layer_clearance.3(layer_pair cut1 cut2))



    Setting Rules to Control Crosstalk, Timing, and Noise

    # Setting crosstalk rules

    rule class critil1(parallel_segment(gap .5)(limit 10))

    rule class critil1(parallel_segment(gap .6)(limit 20))

    rule class critil1(parallel_segment(gap .8)(limit 30))

    rule class critil1(parallel_segment(gap 1)(limit 50))

    # Setting net length rules

    circuit class critical1 (match_net_length on (tolerance 10))

    circuit class critical1 (length 250 20 (type actual))

    # Assigning layer properties for capacitance and resistance

    layer_property metal1 (sheet_resistance .1)

    layer_property metal1 (area_capacitance_coeff .2)

    layer_property metal1 (side_wall_capacitance_coeff .2)

    rule layer metal1 (time_length_factor 2)

    # Setting rules for maximum delay

    circuit class critical1 (match_capacitance on (tolerance 20))

    circuit class critical1 (max_capacitance 120)



    Creating power and ground trunks

    # See Analyzing and Preparing the Design for Routing on page 47.

    # Using the ring option in proute to create trunks

    rule net VSS (width 20)

    rule net VDD (width 20)

    direction metal3 horizontal

    direction metal4 vertical

    proute ring (net VDD VSS) (primary_layer metal4 metal3) (jumper_layer metal4 metal3)



    Global routing

    # Setting the layer direction for global routing

    local_direction conduit (parallel_layer metal3 metal1) (perpendicular_layer metal4 metal2)

    # Running global routing

    groute 1

    # Cutting the keepout layers covering blocked pins

    cut_keepout to_edge 



    Preroute compaction

    # Assigning an I/O pad property to images (cells) before preroute compaction

    image_property (type io_pad)

    image_property OUTBUF (type io_pad)

    image_property INBUF (type io_pad)

    # Aligning specific components before preroute compaction

    define (align_component main_mem Addr_gen (direction horizontal))

    define (align_component main_mem misc (direction vertical))

    # Compacting the design before routing

    pre_route_compaction 1 (design variable) (direction vh) (conduit_enlargement 5) (groute_pass 3)



    Saving block placement and prerouted trunks

    # Saving block placement and prerouted trunks to a file

    write session (include placement) (include gwire) 

    ./new.ses



    Power and ground routing

    # See Routing Your Design on page 67

    # Creating an I/O ring

    proute io_ring

    # Connecting power trunks to pins in the blocks

    proute pin_trunk (component *) (nets VDD VSS)

    # Using proute to create a supply grid (optional)

    rule net VDD (width 30)

    rule net VSS (width 30)

    rule net SCLK (width 15)

    proute stripe (direction vertical) (net VDD) (layer metal6) (gap 200) (first_offset 10)

    proute stripe (direction vertical) (net VSS) (layer metal6) (gap 200) (first_offset 125)

    proute stripe (direction horizontal) (net VDD) (layer metal5) (gap 200) (first_offset 10)

    proute stripe (direction horizontal) (net VSS) (layer metal5) (gap 200) (first_offset 125)

    proute stripe (direction vertical) (net SCLK) (layer metal6) (gap 215) (first_offset 75)

    proute stripe (direction horizontal) (net SCLK) (layer metal5) (gap 215) (first_offset 75)

    # Controlling voltage drop

    image_pin_property VSSPAD VSS (signal_direction out)

    image_pin_property VSSPAD VSS (current .5)

    image_pin_property VDDPAD VDD (signal_direction in)

    image_pin_property VDDPAD VDD (current .5)

    circuit net VDD (irdrop 0.1)

    circuit net VSS (irdrop 0.2)

    sel net VSS VDD

    route 2

    view irdrop_labels on

    report irdrop window

    # Saving power and ground routing

    write route ./power.rte



    Routing buses

    # Bus routing

    bus

    # Defining a bundle of nets

    define (bundle bundle1 (nets ADIN\[0\] ADIN\[1\] ADIN\[2\] ADIN\[3\] ADIN\[4\] ADIN\[5\])(gap 1))

    # Select net bundle

    select bundle bundle1

    # Preroute and protect a net bundle

    route 5

    clean 2

    protect selected



    Prerouting critical nets

    # Defining a net pair

    define (pair (nets ADIN\[0\] ADIN\[1\]))

    # Select net pair

    select net ADIN0 ADIN1

    # Preroute and protect a net pair

    route 3

    clean 2

    protect selected



    Creating a virtual pin to control net topology

    # Select the net

    edit_pick_net_by_name  ADIN\[9\]

    # Add a virtual pin

    edit_add_virtual_pin 1495 700

    # Reorder Guides

    order daisy net ADIN\[9\]

    # Define a width rule for a fromto

    define (net ADIN\[9\] (fromto (virtual_pin VP) Camino|Rom_C (rule (width 2))))

    # Shielding a critical net

    # Assigning a supply property to power nets

    sel net VSS

    assign_supply VSS (selected_wires)

    unsel net VSS

    # Select and route a net to be shielded

    sel net SCLK

    rule net SCLK (clearance 8 (type wire_wire))

    rule net SCLK (clearance 8 (type area_wire))

    rule net SCLK (limit_way 5)

    rule net SCLK (clearance -1 (type area_via))

    route 5

    clean 1

    # Protect the target net and reset clearance values

    unsel net SCLK

    prot net SCLK

    rule net SCLK (clearance -1)

    rule net SCLK (clearance -1 (type area_via))

    # Specify shielding rules and route the shield

    rule net SCLK (shield_gap 1)

    rule net SCLK (shield_width 1)

    circuit net SCLK (shield on (type parallel) (use_net VSS))

    shield

    sel net VSS

    route 3



    Saving preroutes to a file

    write route ./preroute.rte



    Detail Routing

    # Rerun global routing

    groute 3

    # Run track ordering

    troute

    # Detail routing

    bestsave on ./bestsave.w

    route 25

    clean 5

    # Examine the routing status

    report status window

    # Run additional route and clean passes if necessary

    route 10 26

    clean 5



    Postrouting and saving you design

    # Removing notches in same net wires

    set same_net_checking_on

    route 3q

    # Writing parasitics to a file

    write dspf ./design.dspf

    # Saving your design

    write session (include placement)./final.ses


Return to top of page
