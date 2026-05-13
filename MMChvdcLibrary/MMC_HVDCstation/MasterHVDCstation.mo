within MMChvdcLibrary.MMC_HVDCstation;
model MasterHVDCstation
  "This is the user configurable master station where user can...
 define the mode of operation among Pac-Qac, Vdc-Qac, and Vac modes."
  import CM = Modelica.ComplexMath;
  import      Modelica.Units.SI;
  import Complex;
  parameter Boolean Vdc_Pac_flag = true "True-Pac(Vac) mode; False-Vdc mode";
  parameter Boolean Vac_Qac_flag = true "True-Qac mode; False-Vac mode";

  parameter Real Rr=Rr "Connection resistance (pu)"
    annotation (Dialog(group="Physical parameters"));
  parameter Real Xr=Xr "Connection inductance L (pu)"
    annotation (Dialog(group="Physical parameters"));
  parameter Real L_arm=L_arm "MMC arm inductance (pu)"
    annotation (Dialog(group="Physical parameters"));
  parameter Real R_arm=R_arm "MMC arm resistance (pu)"
    annotation (Dialog(group="Physical parameters"));
  parameter Real C_dc = 195E-6 "Equivalent capacitance of the DC grid (F)"
   annotation (
    Dialog(group = "Physical parameters"));
  parameter Real C_sub=C_sub "MMC submodule capacitor (F)"
    annotation (Dialog(group="Physical parameters"));
  parameter Real N_sub=N_sub "Number of submodules per arm"
    annotation (Dialog(group="Physical parameters"));
  parameter Real S_b=S_b "System base power (MVA)"
    annotation (Dialog(group="Base values"));
  parameter Real MVAb=MVAb "Converter rated power (MVA)"
    annotation (Dialog(group="Physical parameters"));
  parameter Real fb=fb "System frequency (Hz)"
    annotation (Dialog(group="Base values"));
  parameter Real Vb=Vb "Base voltage (kV)"
    annotation (Dialog(group="Base values"));
  parameter Real Vdcb=Vdcb "Base DC voltage (kV)"
    annotation (Dialog(group="Base values"));
  parameter Real V_0 "Connection bus voltage magnitude (pu)"
    annotation (Dialog(group="Power flow data"));
  parameter Modelica.Units.SI.Angle angle_0 "Connection bus voltage angle"
    annotation (Dialog(group="Power flow data"));
  parameter Real P_0 "Pref initial (pu)"
    annotation (Dialog(group="Power flow data"));
  parameter Real Q_0 "Qref initial (pu)"
    annotation (Dialog(group="Power flow data"));
  parameter Real Vdc_0 "DC voltage reference (pu)"
    annotation (Dialog(group="Power flow data"));
  parameter Real Wmmc_0 "Energy reference (pu)"
    annotation (Dialog(group="Power flow data"));

  ComponentLibrary.BasicBlocks.Tranformation.SItoPU                     sI_to_pu(
    Vb=Vb,
    MVAb=MVAb,
    Vdcb=Vdcb) annotation (Placement(transformation(extent={{-40,-7},{40,7}},
          origin={-60,157})));
  ComponentLibrary.BasicBlocks.Tranformation.PUtoSI                     pu_to_SI(Vb=Vb,
      Vdcb=Vdcb) annotation (Placement(transformation(
        extent={{-20,-9},{20,9}},
        rotation=180,
        origin={140,163})));
  ComponentLibrary.ControlBlocks.OuterLoopControls.EnergyControl.VariableRefEnergyControl
    EnergyControl(
    k=5,
    T(displayUnit="ms") = 0.001*(50/3),
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    x_start=0,
    y_start=W_0) annotation (Placement(transformation(extent={{-20,-20},{20,20}},
          origin={-100,66})));
  ComponentLibrary.ControlBlocks.OuterLoopControls.ActivePowerControl.ActivePowerControl
    powerControl(
    k=1,
    T(displayUnit="ms") = 0.001*(100/3),
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    x_start=0,
    y_start=P_0) annotation (Placement(transformation(extent={{-20,-20},{20,20}},
          origin={-100,0})));
  ComponentLibrary.ControlBlocks.OuterLoopControls.ReactivePowerControl.ReactivePowerControl
    reactivePowerControl(
    k=10,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    y_start=Q_0) annotation (Placement(transformation(extent={{-20,-20},{20,20}},
          origin={-100,-60})));
  ComponentLibrary.ControlBlocks.InnerLoopControls.DCcurrentControl.DCcurrentControl
    dCsideModulation(
    k=1,
    T(displayUnit="ms") = 0.001*(4/3),
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    x_start=0,
    y_start=DC_0) annotation (Placement(transformation(extent={{-20,-20},{20,20}},
          origin={120,54})));
  ComponentLibrary.ControlBlocks.InnerLoopControls.ACcurrentControl.dAxisACcurrentControl
    aCside_R_Modulation(
    fb=avgMMCmodel_withBlock2_1.SysData.fn,
    Xr=avgMMCmodel_withBlock2_1.Xr,
    L_arm=avgMMCmodel_withBlock2_1.L_arm,
    Vb=avgMMCmodel_withBlock2_1.Vb,
    MVAb=avgMMCmodel_withBlock2_1.MVAb,
    Kp=50,
    T(displayUnit="s") = 0.005/3,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    y_start=ACd0) annotation (Placement(transformation(extent={{-20,-20},{20,20}},
          origin={120,-6})));
  ComponentLibrary.ControlBlocks.InnerLoopControls.ACcurrentControl.qAxisACcurrentControl
    aCside_I_Modulation(
    fb=avgMMCmodel_withBlock2_1.SysData.fn,
    Xr=avgMMCmodel_withBlock2_1.Xr,
    L_arm=avgMMCmodel_withBlock2_1.L_arm,
    Vb=avgMMCmodel_withBlock2_1.Vb,
    MVAb=avgMMCmodel_withBlock2_1.Vb,
    Kp=50,
    T=0.005/3,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    y_start=ACq0) annotation (Placement(transformation(extent={{-20,-20},{20,20}},
          origin={120,-68})));
  ComponentLibrary.Converter.AvgMMCmodel                     avgMMCmodel_withBlock2_1(
    Rr=Rr,
    Xr=Xr,
    L_arm=L_arm,
    R_arm=R_arm,
    C_sub=C_sub,
    N_sub=N_sub,
    S_b=S_b,
    MVAb=MVAb,
    fb=fb,
    Vb=Vb,
    Vdcb=Vdcb,
    Vgd=V_0*Vb*1000,
    teta_bus=angle_0,
    Vdc0=Vdc_0,
    Wmmc_0=Wmmc_0,
    P_ref=P_0*MVAb*1E6,
    Q_ref=Q_0*MVAb*1E6,
    v_ref=V_0) annotation (Placement(transformation(extent={{-78,-23.0001},{78,
            23.0001}}, origin={-10,211})));
  ComponentLibrary.BasicBlocks.Calculator.PQcalculator                     pQ_calculator
    annotation (Placement(transformation(extent={{-172,60},{-152,80}})));
public
  ComponentLibrary.BasicBlocks.Tranformation.dqToRI                     dq_to_RI
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={170,130})));
  ComponentLibrary.BasicBlocks.Tranformation.RITodq                     rI_to_dq
    annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=270,
        origin={-54,120})));
  Modelica.Blocks.Math.Atan2           atan2_1
                   annotation (Placement(transformation(
        extent={{-4,-4},{4,4}},
        rotation=270,
        origin={30,130})));
  ComponentLibrary.BasicBlocks.Tranformation.RITodq                     rI_to_dq1
    annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=270,
        origin={-10,120})));
  Modelica.Blocks.Math.Gain gain(k=MVAb)
                                        annotation (
    Placement(visible = true, transformation(origin={-72,-200},     extent={{-6,-6},
            {6,6}},                                                                                  rotation=0)));
  Modelica.Blocks.Math.Gain gain1(k=MVAb)
                                        annotation (
    Placement(visible = true, transformation(origin={2,-200},       extent={{6,-6},{
            -6,6}},                                                                                  rotation=180)));
  Modelica.Electrical.Analog.Interfaces.PositivePin pin_p annotation (Placement(
        transformation(extent={{-210,210},{-190,230}}),iconTransformation(
          extent={{-210,210},{-190,230}})));
  Modelica.Electrical.Analog.Interfaces.NegativePin pin_n annotation (Placement(
        transformation(extent={{-210,10},{-190,30}}),   iconTransformation(
          extent={{-210,10},{-190,30}})));
  OpenIPSL.Interfaces.PwPin pwPin annotation (Placement(transformation(extent={{190,92},
            {210,112}}),        iconTransformation(extent={{190,92},{210,112}})));
  ComponentLibrary.ControlBlocks.OuterLoopControls.DCvoltageControl.DCvotlageControl
    DCvoltageControl(
    k=5,
    T(displayUnit="ms") = 0.001*(100/3),
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    x_start=0,
    y_start=-P_0) annotation (Placement(transformation(extent={{-20,-20},{20,20}},
          origin={-100,-140})));
  Modelica.Blocks.Logical.Switch switch2
    annotation (Placement(transformation(extent={{18,34},{28,44}})));
  Modelica.Blocks.Math.Gain gain4(k=Vdcb)  annotation (
    Placement(visible = true, transformation(origin={-158,-200},    extent={{-6,-6},
            {6,6}},                                                                                  rotation=0)));
  Modelica.Blocks.Math.Gain gain2(k=Vb) annotation (
    Placement(visible = true, transformation(origin={84,-200},      extent={{6,-6},{
            -6,6}},                                                                                  rotation=180)));
  Modelica.Blocks.Logical.Switch switch3
    annotation (Placement(transformation(extent={{-4,4},{4,-4}},
        rotation=90,
        origin={4,94})));
  ComponentLibrary.BasicBlocks.PLL.Synchronization                     synchronization02_1(
    fb=fb,
    k_filt=10,
    T_filt=0.001,
    initType_filt=Modelica.Blocks.Types.Init.InitialState,
    y_start_filt=0,
    k_pi=(2*0.707)/(2*Modelica.Constants.pi*fb*0.0005),
    T_pi=0.0005,
    initType_pi=Modelica.Blocks.Types.Init.InitialState,
    x_start_pi=0,
    y_start_pi=0,
    k_i=1,
    initType_i=Modelica.Blocks.Types.Init.InitialOutput,
    y_start_i=0)
    annotation (Placement(transformation(extent={{-42,-160},{-22,-140}})));
  ComponentLibrary.BasicBlocks.Tranformation.PolarToComplex
    polar2Complex1 annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={44,-150})));
  ComponentLibrary.BasicBlocks.Tranformation.RITodq                     rI_to_dq5
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={10,-150})));
  ComponentLibrary.ControlBlocks.OuterLoopControls.ACvoltageControl.dAxisACvoltageControl
    aCd_axisVoltageControl1(
    k=10,
    T(displayUnit="ms") = 0.001*(100/3),
    initType=Modelica.Blocks.Types.Init.InitialState,
    x_start=0,
    y_start=0)
    annotation (Placement(transformation(extent={{0,-128},{40,-88}})));
  ComponentLibrary.ControlBlocks.OuterLoopControls.ACvoltageControl.qAxisACvoltageControl
    aCq_axisVoltageControl1(
    k=10,
    T(displayUnit="ms") = 0.001*(100/3),
    initType=Modelica.Blocks.Types.Init.InitialState,
    x_start=0,
    y_start=0) annotation (Placement(transformation(extent={{0,-80},{40,-40}})));
  Modelica.Blocks.Logical.Switch switch4
    annotation (Placement(transformation(extent={{60,30},{70,40}})));
  Modelica.Blocks.Logical.Switch switch5
    annotation (Placement(transformation(extent={{60,-38},{70,-28}})));
  Modelica.Blocks.Math.Gain gain3(k=Modelica.Constants.pi/180) annotation (
      Placement(transformation(
        extent={{-6,6},{6,-6}},
        rotation=0,
        origin={162,-200})));
  ComponentLibrary.BasicBlocks.Calculator.EnergyCalculator                     energy_Calculator(C_eq=6*
        C_sub/N_sub)
    annotation (Placement(transformation(extent={{-170,110},{-150,130}})));
  Modelica.Blocks.Interfaces.RealInput Pref if Vdc_Pac_flag "Reference AC Active Power (pu)"  annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={-100,-240}),
                          iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={-100,-220})));
  Modelica.Blocks.Interfaces.RealInput Qref if Vac_Qac_flag "Reference AC Reactive Power (pu)" annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={-20,-240}),iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
      origin={-40,-220})));
  Modelica.Blocks.Interfaces.RealInput Vdc_ref if not Vdc_Pac_flag "Reference DC voltage (pu)" annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={-180,-240}), iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={-160,-220})));
  Modelica.Blocks.Interfaces.RealOutput Vdc_ref_SI "Reference DC voltage (kV)" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-140,-250}), iconTransformation(
        extent={{-9,-9},{9,9}},
        rotation=0,
        origin={209,-141})));
  Modelica.Blocks.Interfaces.RealOutput Pref_SI "Reference AC Active Power (MW)" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-60,-250}),iconTransformation(
        extent={{-9,-9},{9,9}},
        rotation=0,
        origin={209,-61})));
  Modelica.Blocks.Interfaces.RealOutput Qref_SI "Reference AC Rective Power (MVAr)" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={20,-250}),  iconTransformation(
        extent={{-9,-9},{9,9}},
        rotation=0,
        origin={209,-101})));
  Modelica.Blocks.Interfaces.RealInput Vac_ref if not Vac_Qac_flag "Reference AC voltage" annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={60,-240}),iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={40,-220})));
  Modelica.Blocks.Interfaces.RealOutput Vac_ref_SI "Reference AC Voltage (kV)" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={100,-250}),iconTransformation(
        extent={{-9,-9},{9,9}},
        rotation=0,
      origin={209,-19})));
  Modelica.Blocks.Interfaces.RealInput f_ref if not Vac_Qac_flag "Reference frequency (Hz)" annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={180,-240}), iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
    origin={160,-220})));
  Modelica.Blocks.Interfaces.RealInput theta_ref if not Vac_Qac_flag "Reference phase angle (degree)" annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={140,-240}), iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
      origin={100,-220})));

protected
  parameter Real P_SI = P_0*MVAb*1E6 "Pref initial (W)" annotation (
    Dialog(group = "Power flow data"));
  parameter Real Q_SI = Q_0*MVAb*1E6 "Qref initial (VAr)" annotation (
    Dialog(group = "Power flow data"));
  parameter Complex S0(re = P_SI, im = -Q_SI) "Complex power, conjugate (VA)";
  parameter Complex xq0 = CM.j * (Xr + 0.5 * L_arm) * Vb * Vb / MVAb "Equivalent AC reactance (Ohm)";
  parameter Complex Ra0(re = (Rr + R_arm / 2) * Vb * Vb / MVAb, im = 0) "Equivalent AC resistance (Ohm)";
  parameter Complex Vt0 = CM.fromPolar(V_0*Vb*1000 / sqrt(3), angle_0) "Phase to phase voltage at terminals (V)";
  parameter Complex I0_SI = 1 / 3 * (S0 / CM.conj(Vt0)) "Current per phase (A)";
  parameter Real ir0 = CM.real(I0_SI) "Init. val.";
  parameter Real ii0 = CM.imag(I0_SI) "Init. val.";
  parameter Complex v_m = Vt0 + (Ra0 + xq0) * I0_SI "modulated  voltage per phase (V)";
  parameter SI.Angle delta0 = CM.arg(Vt0 + (Ra0 + xq0) * I0_SI);

  // Initialization of DC side*
  parameter Complex P_vsc_ac=v_m*CM.conj(I0_SI);
  parameter Real P_vsc_dc=CM.real(P_vsc_ac)*((3));
  parameter Real P_vsc_dc_pu = -P_0;

  parameter Real R_dc = 2*(R_arm)*Vb*Vb/(3*MVAb) "Equivalent DC resistance (Ohm)";
  parameter Real Vdc0_SI = Vdc_0*Vdcb*1000 "DC voltage  (V)";
  parameter Real dis = sqrt(Vdc0_SI*Vdc0_SI-(4*R_dc*P_vsc_dc));
  parameter Real Idc0_SI= -(-1*Vdc0_SI+(dis))/(2*R_dc) "DC current (A)";
  //parameter Real Idc0_SI =  (Vdc0_SI - (Vdc0_SI - P_vsc_dc * R_dc/Vdc0_SI))/R_dc;
  //parameter Real Idc0_SI = S_b/Vdc0_SI;
  parameter Real Vmdc0_SI= Vdc0_SI-R_dc*Idc0_SI  "DC current (A)";
  parameter Real Pdc_0_SI=Vdc0_SI*Idc0_SI;

  //Energy Controller
  parameter Real W_0 = (Pdc_0_SI-P_SI)/(MVAb*1E6) "Initial output of PI controller";

  //DC Current control
  parameter Real Idc0_pu= Idc0_SI/(MVAb*1E6/Vdc0_SI) "DC current (A)";
  parameter Real Vmdc0_pu= Vmdc0_SI/(Vdcb*1000) "DC current (A)";
  parameter Real DC_0 = Vdc_0 - Vmdc0_pu "Initial output of PI controller";

  //AC Current control
  parameter Real vmr0 = CM.real(v_m) annotation (
    Dialog(group = "Initial Values"));
  parameter Real vmi0 = CM.imag(v_m) annotation (
    Dialog(group = "Initial Values"));
  parameter Real vmd0 = vmr0 * cos(angle_0) + vmi0 * sin(angle_0) annotation (
    Dialog(group = "Initial Values"));
  parameter Real vmq0 = vmr0 * sin(angle_0) - vmi0 * cos(angle_0) annotation (
    Dialog(group = "Initial Values"));
  parameter Real vmd0pu = sqrt(3)*vmd0/(Vb*1000) annotation (
    Dialog(group = "Initial Values"));
  parameter Real vmq0pu = sqrt(3)*vmq0/(Vb*1000) annotation (
    Dialog(group = "Initial Values"));
  parameter Real id0 = ir0 * cos(angle_0) + ii0 * sin(angle_0) annotation (
    Dialog(group = "Initial Values"));
  parameter Real iq0 = ir0 * sin(angle_0) - ii0 * cos(angle_0) annotation (
    Dialog(group = "Initial Values"));

  parameter Real id0pu = id0*(Vb*1000)/(MVAb*1E6)*sqrt(3) annotation (
    Dialog(group = "Initial Values"));
  parameter Real iq0pu = iq0*(Vb*1000)/(MVAb*1E6)*sqrt(3) annotation (
    Dialog(group = "Initial Values"));

  parameter Real vgr0 = CM.real(Vt0) annotation (
    Dialog(group = "Initial Values"));
  parameter Real vgi0 = CM.imag(Vt0) annotation (
    Dialog(group = "Initial Values"));

  parameter Real vgd0_SI = vgr0*sqrt(3)*cos(angle_0) + vgi0*sqrt(3)*sin(angle_0);
  parameter Real vgq0_SI = vgr0*sqrt(3)*sin(angle_0) - vgi0*sqrt(3)*cos(angle_0);

  parameter Real vgd0 = vgd0_SI / (Vb*1000) " d-axis current (pu)";
  parameter Real vgq0 = vgq0_SI / (Vb*1000) " q-axis current (pu)";

  parameter Real ACd0 = vmd0pu - vgd0 + (Xr+L_arm/2) * iq0pu "Initial output of d axis current PI controller";
  parameter Real ACq0 = vmq0pu - vgq0 - (Xr+L_arm/2) * id0pu "Initial output of q axis current PI controller";

    //DC Voltage Control
  //parameter Real V_DC_0 = vgd0 * id0;

public
  Modelica.Blocks.Sources.BooleanConstant flag2(k=Vac_Qac_flag) annotation (Placement(transformation(
        extent={{-5,-5},{5,5}},
        rotation=0,
        origin={-101,-33})));
  Modelica.Blocks.Sources.BooleanConstant flag1(k=Vdc_Pac_flag) annotation (Placement(transformation(extent={{-104,34},
            {-94,44}})));
  Modelica.Blocks.Math.Gain Vdc_ref_mock(k=1) annotation (Placement(visible=true,
        transformation(
        origin={-180,-210},
        extent={{-6,-6},{6,6}},
        rotation=90)));
  Modelica.Blocks.Math.Gain Pref_mock(k=1) annotation (Placement(visible=true,
        transformation(
        origin={-100,-210},
        extent={{-6,-6},{6,6}},
        rotation=90)));
  Modelica.Blocks.Math.Gain Qref_mock(k=1) annotation (Placement(visible=true,
        transformation(
        origin={-20,-210},
        extent={{-6,-6},{6,6}},
        rotation=90)));
  Modelica.Blocks.Math.Gain Vac_ref_mock(k=1) annotation (Placement(visible=true,
        transformation(
        origin={60,-210},
        extent={{-6,-6},{6,6}},
        rotation=90)));
  Modelica.Blocks.Math.Gain theta_ref_mock(k=1) annotation (Placement(visible=true,
        transformation(
        origin={140,-210},
        extent={{-6,-6},{6,6}},
        rotation=90)));
  Modelica.Blocks.Math.Gain f_ref_mock(k=1) annotation (Placement(visible=true,
        transformation(
        origin={180,-210},
        extent={{-6,-6},{6,6}},
        rotation=90)));
equation
  if Vdc_Pac_flag then
    Vdc_ref_mock.u = 0;
  end if;
  if Vac_Qac_flag then
    Vac_ref_mock.u = 0;
    theta_ref_mock.u = 0;
    f_ref_mock.u = 0;
  end if;
  if not Vdc_Pac_flag then
    Pref_mock.u = 0;
  end if;
  if not Vac_Qac_flag then
    Qref_mock.u = 0;
  end if;
  connect(EnergyControl.idc_ref, dCsideModulation.idc_ref)
    annotation (Line(points={{-78.3333,66},{96,66}}, color={0,0,127}));
  connect(sI_to_pu.Idc_pu,dCsideModulation. idc) annotation (Line(points={{-84,
          148.6},{-84,124},{-70,124},{-70,58},{96,58}},         color={0,0,127}));
  connect(pin_p, avgMMCmodel_withBlock2_1.pin_p) annotation (Line(points={{-200,
          220},{-200,224.34},{-90.2941,224.34}},
                                             color={0,0,255}));
  connect(pin_n, avgMMCmodel_withBlock2_1.pin_n) annotation (Line(points={{-200,20},
          {-200,198},{-90.2941,198},{-90.2941,199.5}},
        color={0,0,255}));
  connect(avgMMCmodel_withBlock2_1.p, pwPin) annotation (Line(points={{70.2941,
          211},{200,211},{200,102}},                             color={0,0,255}));
  connect(EnergyControl.Wtot, energy_Calculator.Wtot) annotation (Line(points={{
          -123.333,66},{-138,66},{-138,120},{-148.4,120}},  color={0,0,127}));
  connect(energy_Calculator.Vceq,sI_to_pu. Vceq_pu) annotation (Line(points={{-171.7,
          120.1},{-180,120.1},{-180,136},{-72,136},{-72,148.6}},
                               color={0,0,127}));
  connect(rI_to_dq.xi,sI_to_pu. Vgi_pu) annotation (Line(points={{-48,132},{-48,
          148.6}},                         color={0,0,127}));
  connect(rI_to_dq1.xr,sI_to_pu. Igr_pu) annotation (Line(points={{-16,132},{
          -16,136},{-36,136},{-36,148.6}},       color={0,0,127}));
  connect(rI_to_dq.angle,rI_to_dq1. angle) annotation (Line(points={{-42,120},{
          -28,120},{-28,102},{12,102},{12,120},{2,120}},  color={0,0,127}));
  connect(dq_to_RI.angle,rI_to_dq1. angle) annotation (Line(points={{182,130},{
          186,130},{186,102},{12,102},{12,120},{2,120}},  color={0,0,127}));
  connect(aCside_R_Modulation.igd,rI_to_dq1. xd) annotation (Line(points={{96,-6},
          {-16,-6},{-16,100},{-16.1,100},{-16.1,108.1}},       color={0,0,127}));
  connect(aCside_I_Modulation.igd,rI_to_dq1. xd) annotation (Line(points={{96,-76},
          {76,-76},{76,-6},{-16,-6},{-16,100},{-16.1,100},{-16.1,108.1}},
                                                                   color={0,0,127}));
  connect(gain.y,Pref_SI)  annotation (Line(points={{-65.4,-200},{-60,-200},{
          -60,-250}},
                  color={0,0,127}));
  connect(gain1.y,Qref_SI)  annotation (Line(points={{8.6,-200},{20,-200},{20,
          -250}},     color={0,0,127}));
  connect(gain4.y, Vdc_ref_SI) annotation (Line(points={{-151.4,-200},{-140,
          -200},{-140,-250}},
                        color={0,0,127}));
  connect(Pref_SI, Pref_SI)
    annotation (Line(points={{-60,-250},{-60,-250}}, color={0,0,127}));
  connect(gain2.y, Vac_ref_SI) annotation (Line(points={{90.6,-200},{100,-200},
          {100,-250}}, color={0,0,127}));
  connect(switch3.y, rI_to_dq1.angle) annotation (Line(points={{4,98.4},{4,102},
          {12,102},{12,120},{2,120}},        color={0,0,127}));
  connect(synchronization02_1.theta, polar2Complex1.angle) annotation (Line(
        points={{-21,-146},{-18,-146},{-18,-134},{44,-134},{44,-138}},
                                                 color={0,0,127}));
  connect(rI_to_dq5.angle, synchronization02_1.theta) annotation (Line(points={{10,-138},
          {10,-134},{-18,-134},{-18,-146},{-21,-146}},
                                          color={0,0,127}));
  connect(switch2.y, switch4.u1) annotation (Line(points={{28.5,39},{59,39}},
                                   color={0,0,127}));
  connect(switch5.y, aCside_I_Modulation.igq_ref) annotation (Line(points={{70.5,
          -33},{84,-33},{84,-60},{96,-60}},   color={0,0,127}));
  connect(synchronization02_1.theta_ref,gain3. y) annotation (Line(points={{-32,
          -138},{-32,-130},{-60,-130},{-60,-174},{174,-174},{174,-200},{168.6,-200}},
        color={0,0,127}));
  connect(aCq_axisVoltageControl1.Vgq, rI_to_dq.xq) annotation (Line(points={{-4,-72},
          {-48.1,-72},{-48.1,108.1}},                                color={0,0,
          127}));
  connect(aCside_I_Modulation.vgq, rI_to_dq.xq) annotation (Line(points={{96,-52},
          {72,-52},{72,-84},{-48.1,-84},{-48.1,108.1}},
        color={0,0,127}));
  connect(dq_to_RI.xi, pu_to_SI.Vmi_pu) annotation (Line(points={{174.7,141.9},
          {174.7,146},{151,146},{151,151.3}},
                                           color={0,0,127}));
  connect(dq_to_RI.xr, pu_to_SI.Vmr_pu) annotation (Line(points={{164.3,141.9},
          {164.3,144},{140,144},{140,151.3}},
                                          color={0,0,127}));
  connect(aCside_I_Modulation.Vmq, dq_to_RI.xq) annotation (Line(points={{142,-60},
          {174.8,-60},{174.8,118}},                    color={0,0,127}));
  connect(dCsideModulation.Vmdc, pu_to_SI.Vmdc_pu) annotation (Line(points={{142,58},
          {156,58},{156,142},{130,142},{130,151.3}},    color={0,0,127}));
  connect(dCsideModulation.Vdc, sI_to_pu.Vdc_pu) annotation (Line(points={{96,50},
          {-74,50},{-74,120},{-94.6667,120},{-94.6667,148.6}},           color=
          {0,0,127}));
  connect(switch4.u3, aCq_axisVoltageControl1.igd_ref) annotation (Line(points={{59,31},
          {48,31},{48,-60},{42,-60}},
        color={0,0,127}));
  connect(sI_to_pu.Vceq_SI, avgMMCmodel_withBlock2_1.Vc_eq) annotation (Line(
        points={{-72,165.4},{-72,176},{-26,176},{-26,180},{-26.0588,180},{
          -26.0588,185.7}},
        color={0,0,127}));
  connect(avgMMCmodel_withBlock2_1.Vdc, sI_to_pu.Vdc_SI) annotation (Line(
        points={{-81.1176,185.7},{-81.1176,174},{-94.6667,174},{-94.6667,165.4}},
                                                                     color={0,0,
          127}));
  connect(pQ_calculator.Qac, reactivePowerControl.Qac) annotation (Line(points={{-150.4,
          66},{-146,66},{-146,-60},{-124,-60}},       color={0,0,127}));
  connect(avgMMCmodel_withBlock2_1.Idc, sI_to_pu.Idc_SI) annotation (Line(
        points={{-71.9412,185.7},{-71.9412,172},{-84,172},{-84,165.4}}, color={
          0,0,127}));
  connect(avgMMCmodel_withBlock2_1.VmI, pu_to_SI.Vmi_SI) annotation (Line(
        points={{6.05882,185.7},{6.05882,182},{150,182},{150,174.7}},     color
        ={0,0,127}));
  connect(avgMMCmodel_withBlock2_1.VmR, pu_to_SI.Vmr_SI) annotation (Line(
        points={{-7.70588,185.7},{-7.70588,180},{140,180},{140,174.7}}, color={
          0,0,127}));
  connect(avgMMCmodel_withBlock2_1.V_m_dc, pu_to_SI.Vmdc_SI) annotation (Line(
        points={{-44.4118,185.7},{-44.4118,178},{130,178},{130,174.7}},
        color={0,0,127}));
  connect(sI_to_pu.Vgr_SI, avgMMCmodel_withBlock2_1.VgR) annotation (Line(
        points={{-60,165.4},{-60,174},{33.5882,174},{33.5882,185.7}}, color={0,
          0,127}));
  connect(sI_to_pu.Vgi_SI, avgMMCmodel_withBlock2_1.VgI) annotation (Line(
        points={{-48,165.4},{-48,172},{42.7647,172},{42.7647,185.7}}, color={0,
          0,127}));
  connect(sI_to_pu.Igr_SI, avgMMCmodel_withBlock2_1.IgR) annotation (Line(
        points={{-36,165.4},{-36,170},{51.9412,170},{51.9412,185.7}}, color={0,
          0,127}));
  connect(sI_to_pu.Igi_SI, avgMMCmodel_withBlock2_1.IgI) annotation (Line(
        points={{-25.3333,165.4},{-25.3333,168},{61.1176,168},{61.1176,185.7}},
        color={0,0,127}));
  connect(rI_to_dq.xr, sI_to_pu.Vgr_pu)
    annotation (Line(points={{-60,132},{-60,148.6}}, color={0,0,127}));
  connect(sI_to_pu.Igi_pu, rI_to_dq1.xi) annotation (Line(points={{-25.3333,
          148.6},{-25.3333,138},{-4,138},{-4,132}}, color={0,0,127}));
  connect(atan2_1.u2, sI_to_pu.Vgr_pu) annotation (Line(points={{27.6,134.8},{
          27.6,142},{-60,142},{-60,148.6}}, color={0,0,127}));
  connect(atan2_1.u1, sI_to_pu.Vgi_pu) annotation (Line(points={{32.4,134.8},{
          32.4,144},{-48,144},{-48,148.6}}, color={0,0,127}));
  connect(switch3.u1, atan2_1.y) annotation (Line(points={{7.2,89.2},{7.2,86},{
          30,86},{30,125.6}}, color={0,0,127}));
  connect(aCside_R_Modulation.Vmd, dq_to_RI.xd)
    annotation (Line(points={{142,2},{164.6,2},{164.6,118}}, color={0,0,127}));
  connect(synchronization02_1.Vq, rI_to_dq.xq) annotation (Line(points={{-44,
          -144},{-48,-144},{-48,-72},{-48.1,-72},{-48.1,108.1}}, color={0,0,127}));
  connect(pQ_calculator.Pac, powerControl.Pac) annotation (Line(points={{-150.4,
          73.6},{-142,73.6},{-142,0},{-124,0}}, color={0,0,127}));
  connect(pQ_calculator.igd, rI_to_dq1.xd) annotation (Line(points={{-173.7,
          76.1},{-180,76.1},{-180,90},{-16,90},{-16,100},{-16.1,100},{-16.1,
          108.1}}, color={0,0,127}));
  connect(aCside_R_Modulation.igq, rI_to_dq1.xq) annotation (Line(points={{96,
          -14},{-4.1,-14},{-4.1,108.1}}, color={0,0,127}));
  connect(pQ_calculator.igq, rI_to_dq1.xq) annotation (Line(points={{-173.7,
          71.9},{-184,71.9},{-184,94},{-4.1,94},{-4.1,108.1}}, color={0,0,127}));
  connect(pQ_calculator.vgd, rI_to_dq.xd) annotation (Line(points={{-173.7,67.9},
          {-188,67.9},{-188,98},{-60,98},{-60,104},{-60.1,104},{-60.1,108.1}},
        color={0,0,127}));
  connect(pQ_calculator.vgq, rI_to_dq.xq) annotation (Line(points={{-173.7,63.9},
          {-192,63.9},{-192,102},{-48.1,102},{-48.1,108.1}}, color={0,0,127}));
  connect(sI_to_pu.Vdc_pu, EnergyControl.Vdc) annotation (Line(points={{
          -94.6667,148.6},{-94.6667,120},{-132,120},{-132,78},{-123.333,78}},
        color={0,0,127}));
  connect(sI_to_pu.Vdc_pu, DCvoltageControl.Vdc) annotation (Line(points={{
          -94.6667,148.6},{-94.6667,120},{-132,120},{-132,-140},{-124,-140}},
        color={0,0,127}));
  connect(pQ_calculator.Pac, EnergyControl.Pac) annotation (Line(points={{-150.4,
          73.6},{-142,73.6},{-142,53.6},{-123.333,53.6}},        color={0,0,127}));
  connect(powerControl.Vgd, rI_to_dq.xd) annotation (Line(points={{-124,-12},{
          -188,-12},{-188,98},{-60,98},{-60,104},{-60.1,104},{-60.1,108.1}},
        color={0,0,127}));
  connect(reactivePowerControl.Vgd, rI_to_dq.xd) annotation (Line(points={{-124,
          -72},{-188,-72},{-188,98},{-60,98},{-60,104},{-60.1,104},{-60.1,108.1}},
        color={0,0,127}));
  connect(switch4.y, aCside_R_Modulation.igd_ref) annotation (Line(points={{
          70.5,35},{76,35},{76,2},{96,2}}, color={0,0,127}));
  connect(aCside_I_Modulation.igq, rI_to_dq1.xq) annotation (Line(points={{96,
          -68},{80,-68},{80,-14},{-4.1,-14},{-4.1,108.1}}, color={0,0,127}));
  connect(rI_to_dq.xd, aCside_R_Modulation.vgd) annotation (Line(points={{-60.1,
          108.1},{-60.1,10},{96,10}}, color={0,0,127}));
  connect(aCd_axisVoltageControl1.igq_ref, switch5.u3) annotation (Line(points={{42,-108},
          {54,-108},{54,-37},{59,-37}},            color={0,0,127}));
  connect(DCvoltageControl.Vgd, rI_to_dq.xd) annotation (Line(points={{-124,
          -152},{-188,-152},{-188,98},{-60,98},{-60,104},{-60.1,104},{-60.1,
          108.1}}, color={0,0,127}));
  connect(switch2.u3, DCvoltageControl.igd_ref) annotation (Line(points={{17,35},
          {-72,35},{-72,-140},{-78,-140}}, color={0,0,127}));
  connect(polar2Complex1.xi, rI_to_dq5.xi) annotation (Line(points={{32.1,
          -144.1},{22,-144.1},{22,-144}}, color={0,0,127}));
  connect(polar2Complex1.xr, rI_to_dq5.xr) annotation (Line(points={{32.1,
          -156.1},{22,-156.1},{22,-156}}, color={0,0,127}));
  connect(switch3.u3, synchronization02_1.theta) annotation (Line(points={{0.8,
          89.2},{0.8,-36},{-18,-36},{-18,-146},{-21,-146}}, color={0,0,127}));
  connect(aCd_axisVoltageControl1.Vgd_ref, rI_to_dq5.xd) annotation (Line(
        points={{-4,-96},{-14,-96},{-14,-156.1},{-1.9,-156.1}}, color={0,0,127}));
  connect(sI_to_pu.Vceq_pu, dCsideModulation.Vc_eq) annotation (Line(points={{
          -72,148.6},{-72,136},{-66,136},{-66,80},{86,80},{86,42},{96,42}},
        color={0,0,127}));
  connect(aCside_R_Modulation.Vc_eq, sI_to_pu.Vceq_pu) annotation (Line(points=
          {{96,-22},{86,-22},{86,80},{-66,80},{-66,136},{-72,136},{-72,148.6}},
        color={0,0,127}));
  connect(aCside_I_Modulation.Vc_eq, sI_to_pu.Vceq_pu) annotation (Line(points=
          {{96,-84},{86,-84},{86,80},{-66,80},{-66,136},{-72,136},{-72,148.6}},
        color={0,0,127}));
  connect(powerControl.igd_ref, switch2.u1) annotation (Line(points={{-78,0},{-28,
          0},{-28,43},{17,43}}, color={0,0,127}));
  connect(reactivePowerControl.igq_ref, switch5.u1) annotation (Line(points={{-78,
          -60},{-66,-60},{-66,-29},{59,-29}}, color={0,0,127}));
  connect(Vdc_ref_mock.u, Vdc_ref)
    annotation (Line(points={{-180,-217.2},{-180,-240}}, color={0,0,127}));
  connect(Vdc_ref_mock.y, gain4.u) annotation (Line(points={{-180,-203.4},{-180,
          -200},{-165.2,-200}}, color={0,0,127}));
  connect(DCvoltageControl.Vdc_ref, Vdc_ref_mock.y) annotation (Line(points={{-124,
          -128},{-180,-128},{-180,-203.4}}, color={0,0,127}));
  connect(gain.u, Pref_mock.y) annotation (Line(points={{-79.2,-200},{-100,-200},
          {-100,-203.4}}, color={0,0,127}));
  connect(Pref_mock.u, Pref)
    annotation (Line(points={{-100,-217.2},{-100,-240}}, color={0,0,127}));
  connect(powerControl.Pac_ref, Pref_mock.y) annotation (Line(points={{-124,12},
          {-170,12},{-170,-186},{-100,-186},{-100,-203.4}}, color={0,0,127}));
  connect(Qref, Qref_mock.u)
    annotation (Line(points={{-20,-240},{-20,-217.2}}, color={0,0,127}));
  connect(gain1.u, Qref_mock.y) annotation (Line(points={{-5.2,-200},{-20,-200},
          {-20,-203.4}}, color={0,0,127}));
  connect(reactivePowerControl.Qac_ref, Qref_mock.y) annotation (Line(points={{-124,
          -48},{-160,-48},{-160,-180},{-20,-180},{-20,-203.4}}, color={0,0,127}));
  connect(Vac_ref, Vac_ref_mock.u)
    annotation (Line(points={{60,-240},{60,-217.2}}, color={0,0,127}));
  connect(gain2.u, Vac_ref_mock.y) annotation (Line(points={{76.8,-200},{60,-200},
          {60,-203.4}}, color={0,0,127}));
  connect(polar2Complex1.xmag, Vac_ref_mock.y) annotation (Line(points={{56,-150},
          {60,-150},{60,-203.4}}, color={0,0,127}));
  connect(theta_ref, theta_ref_mock.u)
    annotation (Line(points={{140,-240},{140,-217.2}}, color={0,0,127}));
  connect(theta_ref_mock.y, gain3.u) annotation (Line(points={{140,-203.4},{140,
          -200},{154.8,-200}}, color={0,0,127}));
  connect(f_ref, f_ref_mock.u)
    annotation (Line(points={{180,-240},{180,-217.2}}, color={0,0,127}));
  connect(f_ref_mock.y, synchronization02_1.f_ref) annotation (Line(points={{180,
          -203.4},{180,-166},{-50,-166},{-50,-156},{-44,-156}}, color={0,0,127}));
  connect(aCq_axisVoltageControl1.Vgq_ref, rI_to_dq5.xq) annotation (Line(
        points={{-4,-48},{-10,-48},{-10,-144.1},{-1.9,-144.1}}, color={0,0,127}));
  connect(flag1.y, switch2.u2)
    annotation (Line(points={{-93.5,39},{17,39}}, color={255,0,255}));
  connect(flag2.y, switch5.u2)
    annotation (Line(points={{-95.5,-33},{59,-33}}, color={255,0,255}));
  connect(switch3.u2, flag2.y) annotation (Line(points={{4,89.2},{4,-33},{-95.5,
          -33}}, color={255,0,255}));
  connect(aCd_axisVoltageControl1.Vgd, rI_to_dq.xd) annotation (Line(points={{-4,
          -120},{-60,-120},{-60,10},{-60.1,10},{-60.1,108.1}}, color={0,0,127}));
  connect(switch4.u2, flag2.y) annotation (Line(points={{59,35},{34,35},{34,-33},
          {-95.5,-33}}, color={255,0,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-220,
            -300},{220,240}}),
                         graphics={
        Rectangle(
          extent={{-200,240},{200,-240}},
          lineColor={0,0,0},
          lineThickness=1),
        Line(
          points={{-200,240},{200,-120}},
          color={0,0,0},
          thickness=1),
        Line(
          points={{-108,24},{-28,24}},
          color={0,0,0},
          thickness=1),
        Line(
          points={{-92,36}},
          color={0,0,0},
          thickness=0.5),
        Line(
          points={{-108,-16},{-28,-16}},
          color={0,0,0},
          thickness=1),
        Line(
          points={{44,142},{74,172},{104,142},{132,170}},
          color={0,0,0},
          thickness=1),
        Text(
          extent={{-90,112},{116,40}},
          textColor={238,46,47},
          textString="MMC"),
        Text(
          extent={{-202,174},{-132,122}},
          textColor={0,0,0},
          textString="+"),
        Text(
          extent={{-204,16},{-134,-36}},
          textColor={0,0,0},
          textString="-"),
        Text(
          extent={{-78,12},{78,-12}},
          textColor={0,0,0},
          textString="Vdc_ref",
          origin={-160,-144},
          rotation=90),
        Text(
          extent={{-62,11},{62,-11}},
          textColor={0,0,0},
          textString="Qref",
          origin={-40,-163},
          rotation=90),
        Text(
          extent={{-62,11},{62,-11}},
          textColor={0,0,0},
          textString="Pref",
          origin={-100,-165},
          rotation=90),
        Text(
          extent={{-62,11},{62,-11}},
          textColor={0,0,0},
          textString="Vac_ref",
          origin={40,-149},
          rotation=90),
        Text(
          extent={{-62,11},{62,-11}},
          textColor={0,0,0},
          textString="f_ref",
          origin={160,-161},
          rotation=90),
        Text(
          extent={{-62,11},{62,-11}},
          textColor={0,0,0},
          origin={100,-145},
          rotation=90,
          textString="theta_ref"),
        Text(
          extent={{-50.5,26},{50.5,-26}},
          textColor={0,0,0},
          origin={-78.5,188},
          rotation=180,
          textString="Block/Deblock"),
        Text(
          extent={{-33.5,10},{33.5,-10}},
          textColor={0,0,0},
          origin={14.5,186},
          rotation=180,
          textString="Vac/Qac"),
        Text(
          extent={{-35.5,10},{35.5,-10}},
          textColor={0,0,0},
          origin={92.5,188},
          rotation=180,
          textString="Vdc/Pac")}),                               Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-220,-300},{220,
            240}},
        grid={2,2})));
end MasterHVDCstation;
