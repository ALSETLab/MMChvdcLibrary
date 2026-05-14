[![DOI](https://zenodo.org/badge/1235907022.svg)](https://doi.org/10.5281/zenodo.20186636)
# MMChvdcLibrary 

## Scope

MMChvdcLibrary is a Modelica library for phasor-domain arm average value modeling of MMC-based HVDC systems, designed to be easily combined with [OpenIPSL](https://github.com/OpenIPSL/OpenIPSL), for power system simulation.

The library provides modular converter models, control blocks, sensors, and mathematical operators, assembled into station-level models supporting P-Q, Vdc–Q, and Vac phasor control modes, along with a user-configurable master HVDC station integrating all three.

The library was developed using [Dymola](http://dymola.com/) 2026 Refresh 1, compatibility with other [Modelica tools](https://modelica.org/tools/) has not been fully tested.

## Quick-Start

1. Load OpenIPSL v3.1.0 to your Modelica tool. See the following Quick-Start Guide to use OpenIPSL with OpenModelica [here](https://docs.google.com/presentation/d/10wueYbwWeVzYoGtiZYcWFWLDFbSEV3ruaTtkaMoGitU/edit?usp=sharing). 

2. Similar to the instructions in the OpenIPSL Quick-Start, run any of the run three pre-configured examples below:

```modelica
MMChvdcLibrary.Examples.ActivePowerModeTest
MMChvdcLibrary.Examples.DCvoltageModeTest
MMChvdcLibrary.Examples.VacModeTest
```

## Citing MMChvdcLibrary

If you use this library in your work or research, all we ask in exchange is that you cite the reference publications. Please reference our work:

- Md N.H. Chowdhury and L. Vanfretti, "MMChvdcLibrary: Modeling Arm Average Value Modular Multilevel Converters in Modelica for Power System Simulation," submitted for publication, American Modelica & FMI Conference 2026, Atlanta, GA, USA, October 12–14, 2026. Author's Pre-print Copy: [here](https://www.researchgate.net/publication/404872847_MMChvdcLibrary_Modeling_Arm_Average_Value_Modular_Multilevel_Converters_in_Modelica_for_Power_System_Simulation)
- Md. N.H. Chowdhury, L. Vanfretti, J. Frasier, and S.S. Tawde, “Phasor-Domain Modeling of Blocking Behavior in Modular Multilevel Converters,” 2026 IEEE Power & Energy Society General Meeting, July 19-23, 2026. Author's Pre-print Copy: [here](https://www.researchgate.net/publication/401562499_Phasor-Domain_MMC_Blocking_Behavior_Modeling)

## Acknowledgements

This paper is based, in part, on work supported in whole or in part by the New York Independent System Operator (NYISO) Funded Project: "Dynamic Modeling of Voltage Source Converters for Black Start Capability Analysis" whose support is gratefully acknowledged.
