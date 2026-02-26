# Script for mechanical calculations of Ni-201.
#
# We consider the mechanical tolerance of Ni-201 in the FLiBe purifier,
# especially the relatively small stem used for the bubbler/salt transfer.

# Source for mechanical properties: 
# https://www.hpalloy.com/Alloys/descriptions/NICKEL201.aspx (Tensile/Yield strength)
# https://www.specialmetals.com/documents/technical-bulletins/nickel-200.pdf

using Unitful, UnitfulUS

lever_arm = 18u"sinch_us"
tensile_strength = 22200u"lb/sinch_us^2" # Nominal
yield_strength = 10200u"lb/sinch_us^2" # Nominal
outer_diameter = 0.75u"sinch_us" 
outer_radius = outer_diameter / 2 
wall_thickness = 0.62u"sinch_us"
inner_diameter = outer_diameter - wall_thickness * 2
inner_radius = inner_diameter / 2 
area = π * ((outer_radius)^2 - (inner_radius)^2)
println("Area: $area")
yield_force = area * yield_strength
tensile_force = area * tensile_strength

second_moment_of_area = π / 4 *( outer_radius ^ 4 - inner_radius^4)
println("Second moment of area: $second_moment_of_area")
section_modulus =  second_moment_of_area / outer_radius
println("Section modulus: $section_modulus")
moment_strength = section_modulus * yield_strength
println("Moment strength: $moment_strength")
bending_force =  moment_strength / lever_arm
