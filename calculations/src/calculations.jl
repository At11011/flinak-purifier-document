# =============================================================================
# Title:        Calculations
# Author:       Nathaniel Thomas
# Affiliation:  Texas A&M University, Department of Nuclear Engineering
# Email:        nathaniel@tamu.edu
# Date Created: 3/18/2026
# Version:      1.0
#
# Description:
#   A julia calculation script for various components of the FLiNaK purifier.
#
# =============================================================================

module calculations

using Unitful, PhysicalConstants.CODATA2018

function scrubber_requirement()
    # Inputs
    flowrate = 800u"mL/minute"
    h2_hf_ratio = 10
    temperature = 298u"K"
    pressure = 1u"atm"
    runtime = 48u"hr"
    hf_molar_mass = 20.0063432u"g/mol"
    hf_density = 0.99u"g/mL"
    koh_molar_mass = 56.106u"g/mol"
    koh_concentration = 14u"M"
    acid_base_ratio = 1 # HF + KOH -> H2O + KF
    scrubber_safety_factor = 2 # Double the minimum required concentration

    # Calculations
    hf_flowrate = flowrate / (h2_hf_ratio + 1)
    h2_flowrate = hf_flowrate * h2_hf_ratio
    R = BoltzmannConstant * AvogadroConstant
    hf_molar_flowrate = pressure * hf_flowrate / (R * temperature)
    total_hf = uconvert(u"mol", hf_molar_flowrate * runtime)
    total_koh = total_hf / acid_base_ratio
    total_hf_mass = total_hf * hf_molar_mass
    total_hf_volume = total_hf_mass / hf_density
    total_koh_mass = total_koh * koh_molar_mass
    total_koh_volume = uconvert(u"L", total_hf / koh_concentration)

    # Print outs
    println("Gas constant: $(round(typeof(R), sigdigits = 3, R))")
    println("HF flowrate: $(round(typeof(hf_flowrate), sigdigits = 3, hf_flowrate))")
    println("H2 flowrate: $(round(typeof(h2_flowrate), sigdigits = 3, h2_flowrate))")
    println("Total HF moles: $(round(typeof(total_hf), sigdigits = 3, total_hf))")
    println("Total HF mass: $(round(typeof(total_hf_mass), sigdigits = 3, total_hf_mass))")
    println("Total HF volume: $(round(typeof(total_hf_volume), sigdigits = 3, total_hf_volume))")
    println("Total KOH mass: $(round(typeof(total_koh_mass), sigdigits = 3, total_koh_mass))")
    println("Total KOH volume at $koh_concentration: $(round(typeof(total_koh_volume), 
        sigdigits = 3, total_koh_volume))")
end

function main()
    scrubber_requirement()
end

end # module calculations
