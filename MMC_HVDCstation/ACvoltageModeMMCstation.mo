within MMC_HVDC_AMCONF2026.MMC_HVDCstation;
model ACvoltageModeMMCstation "MMC HVDC station with only AC voltage control."
  import CM = Modelica.ComplexMath;
  import      Modelica.Units.SI;
  import Complex;
  MMC_HVDC_BlackStart.ComponentLibrary.BasicBlocks.Tranformation.SItoPU sI_to_pu(
    Vb=Vb,
    MVAb=MVAb,
    Vdcb=Vdcb) annotation (Placement(transformation(extent={{-69,-9},{69,9}},
          origin={-11,89})));
  MMC_HVDC_BlackStart.ComponentLibrary.BasicBlocks.Tranformation.PUtoSI pu_to_SI(Vb=Vb,
      Vdcb=Vdcb) annotation (Placement(transformation(
        extent={{-26,-8},{26,8}},
        rotation=180,
        origin={132,82})));
  MMC_HVDC_BlackStart.ComponentLibrary.ControlBlocks.OuterLoopControls.EnergyControl.VariableRefEnergyControl
    EnergyControl(
    k=10,
    T(displayUnit="ms") = 0.001*(100/3),
    initType=Modelica.Blocks.Types.Init.InitialState,
    x_start=0,
    y_start=0) annotation (Placement(transformation(extent={{-20,-20},{20,20}},
          origin={-86,20})));
  MMC_HVDC_BlackStart.ComponentLibrary.ControlBlocks.InnerLoopControls.DCcurrentControl.DCcurrentControl
    dCsideModulation(
    k=1,
    T=0.004/3,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    x_start=0,
    y_start=DC_0) annotation (Placement(transformation(extent={{-20,-20},{20,20}},
          origin={120,8})));
  ComponentLibrary.Converter.AvgMMCmodel                     avgMMCmodel(
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
    v_ref=V_0) annotation (Placement(transformation(extent={{-77,-23},{77,
            23.0001}}, origin={-1,149})));
  Modelica.Electrical.Analog.Interfaces.PositivePin pin_p annotation (Placement(
        transformation(extent={{-220,80},{-200,100}}), iconTransformation(
          extent={{-220,80},{-200,100}})));
  Modelica.Electrical.Analog.Interfaces.NegativePin pin_n annotation (Placement(
        transformation(extent={{-220,-80},{-200,-60}}), iconTransformation(
          extent={{-220,-80},{-200,-60}})));
  OpenIPSL.Interfaces.PwPin pwPin annotation (Placement(transformation(extent={{
            200,-12},{220,8}}), iconTransformation(extent={{200,-12},{220,8}})));
  Modelica.Blocks.Interfaces.RealInput Vac_ref
    "Reference AC voltage magnitude (pu)"
    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={0,-200}), iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={0,-200})));
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
  parameter Real Vdc_0=1 "DC voltage reference (pu)"
    annotation (Dialog(group="Power flow data"));
  parameter Real Wmmc_0=1 "Energy reference (pu)"
    annotation (Dialog(group="Power flow data"));

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

  parameter Real R_dc = 2*R_arm*Vb*Vb/(3*MVAb) "Equivalent DC resistance (Ohm)";
  parameter Real Vdc0_SI = Vdc_0*Vdcb*1000 "DC voltage  (V)";
  //parameter Real dis = sqrt(Vdc0_SI*Vdc0_SI-(4*R_dc*P_vsc_dc));
  //parameter Real Idc0_SI= -(-1*Vdc0_SI+(dis))/(2*R_dc) "DC current (A)";
  parameter Real Idc0_SI =  (Vdc0_SI - (Vdc0_SI - P_vsc_dc * R_dc/Vdc0_SI))/R_dc;
  parameter Real Vmdc0_SI= Vdc0_SI-R_dc*Idc0_SI  "DC current (A)";
  parameter Real Pdc_0_SI=Vdc0_SI*Idc0_SI;

  //Energy Controller
  parameter Real W_0 = (Pdc_0_SI-P_SI)/(MVAb*1E6) "Initial output of PI controller";

  //DC Voltage Control
  //parameter Real

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

public
  MMC_HVDC_BlackStart.ComponentLibrary.BasicBlocks.Tranformation.dqToRI dq_to_RI
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={170,30})));
  MMC_HVDC_BlackStart.ComponentLibrary.BasicBlocks.Tranformation.RITodq rI_to_dq
    annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=270,
        origin={0,58})));
  MMC_HVDC_BlackStart.ComponentLibrary.BasicBlocks.Tranformation.RITodq rI_to_dq1
    annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=270,
        origin={40,58})));
  Modelica.Blocks.Math.Gain gain(k=Vb)  annotation (
    Placement(visible = true, transformation(origin={24,-168},      extent={{-6,-6},
            {6,6}},                                                                                  rotation=0)));
  Modelica.Blocks.Interfaces.RealOutput Vac_ref_SI "Reference AC Voltage (kV)"
    annotation (Placement(transformation(
        extent={{-9,-9},{9,9}},
        rotation=0,
        origin={49,-169}), iconTransformation(
        extent={{-9,-9},{9,9}},
        rotation=270,
        origin={187,-109})));
  MMC_HVDC_BlackStart.ComponentLibrary.ControlBlocks.InnerLoopControls.ACcurrentControl.dAxisACcurrentControl
    aCdaxisModulation(
    fb=avgMMCmodel.SysData.fn,
    Xr=avgMMCmodel.Xr,
    L_arm=avgMMCmodel.L_arm,
    Vb=avgMMCmodel.Vb,
    MVAb=MVAb,
    T=0.005/3,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    Kp=1.5,
    y_start=ACd0)
    annotation (Placement(transformation(extent={{100,-68},{140,-28}})));
  MMC_HVDC_BlackStart.ComponentLibrary.ControlBlocks.InnerLoopControls.ACcurrentControl.qAxisACcurrentControl
    aCqaxisModulation(
    fb=avgMMCmodel.SysData.fn,
    Xr=avgMMCmodel.Xr,
    L_arm=avgMMCmodel.L_arm,
    Vb=avgMMCmodel.Vb,
    MVAb=avgMMCmodel.MVAb,
    Kp=1.5,
    T=0.005/3,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    y_start=ACq0)
    annotation (Placement(transformation(extent={{100,-116},{140,-76}})));
  MMC_HVDC_BlackStart.ComponentLibrary.BasicBlocks.Calculator.PQcalculator pQ_calculator
    annotation (Placement(transformation(extent={{-168,-40},{-128,0}})));
  MMC_HVDC_BlackStart.ComponentLibrary.ControlBlocks.OuterLoopControls.ACvoltageControl.dAxisACvoltageControl
    aCd_axisVoltageControl(
    k=10,
    T(displayUnit="ms") = 0.001*(100/3),
    initType=Modelica.Blocks.Types.Init.InitialState,
    x_start=0,
    y_start=0)
    annotation (Placement(transformation(extent={{-84,-108},{-44,-68}})));
  MMC_HVDC_BlackStart.ComponentLibrary.ControlBlocks.OuterLoopControls.ACvoltageControl.qAxisACvoltageControl
    aCq_axisVoltageControl(
    k=10,
    T(displayUnit="ms") = 0.001*(100/3),
    initType=Modelica.Blocks.Types.Init.InitialState,
    x_start=0,
    y_start=0)
    annotation (Placement(transformation(extent={{-84,-60},{-44,-20}})));
  MMC_HVDC_BlackStart.ComponentLibrary.BasicBlocks.Tranformation.PolarToComplex
    polar2Complex annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-30,-160})));
  MMC_HVDC_BlackStart.ComponentLibrary.BasicBlocks.Tranformation.RITodq rI_to_dq2
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-70,-160})));
  MMC_HVDC_BlackStart.ComponentLibrary.BasicBlocks.PLL.Synchronization synchronization02_1(
    fb=50,
    k_filt=10,
    T_filt=0.001,
    initType_filt=Modelica.Blocks.Types.Init.InitialState,
    y_start_filt=0,
    k_pi=(2*0.707)/(2*Modelica.Constants.pi*fb*0.0005),
    T_pi=0.0005,
    initType_pi=Modelica.Blocks.Types.Init.InitialOutput,
    x_start_pi=0,
    y_start_pi=0,
    k_i=1,
    initType_i=Modelica.Blocks.Types.Init.InitialOutput,
    y_start_i=angle_0)
    annotation (Placement(transformation(extent={{-160,-154},{-140,-134}})));
  Modelica.Blocks.Interfaces.RealInput f_ref "Reference frequency (Hz)"
    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={-100,-200}), iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={-100,-200})));
  Modelica.Blocks.Interfaces.RealInput theta_ref
    "Reference phase angle (degree)"
    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={100,-200}), iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={100,-200})));
  Modelica.Blocks.Math.Gain gain1(k=Modelica.Constants.pi/180) annotation (
      Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=90,
        origin={100,-164})));
protected
  MMC_HVDC_BlackStart.ComponentLibrary.BasicBlocks.Calculator.EnergyCalculator energy_Calculator(C_eq=6*
        C_sub/N_sub)
    annotation (Placement(transformation(extent={{-160,10},{-140,30}})));
equation
  connect(sI_to_pu.Idc_SI, avgMMCmodel.Idc) annotation (Line(points={{-52.4,
          99.8},{-52.4,116},{-62.1471,116},{-62.1471,123.7}},
                                                          color={0,0,127}));
  connect(avgMMCmodel.VgI, sI_to_pu.Vgi_SI) annotation (Line(points={{51.0882,
          123.7},{51.0882,108},{9.7,108},{9.7,99.8}},
                                                    color={0,0,127}));
  connect(avgMMCmodel.IgR, sI_to_pu.Igr_SI) annotation (Line(points={{60.1471,
          123.7},{60.1471,106},{30.4,106},{30.4,99.8}},
                                                    color={0,0,127}));
  connect(avgMMCmodel.IgI, sI_to_pu.Igi_SI) annotation (Line(points={{69.2059,
          123.7},{69.2059,104},{48.8,104},{48.8,99.8}},
                                                    color={0,0,127}));
  connect(avgMMCmodel.VgR, sI_to_pu.Vgr_SI) annotation (Line(points={{42.0294,
          123.7},{42.0294,118},{42,118},{42,110},{-12,110},{-12,99.8},{-11,99.8}},
                                                  color={0,0,127}));
  connect(dCsideModulation.Vmdc, pu_to_SI.Vmdc_pu) annotation (Line(points={{142,12},
          {150,12},{150,58},{119,58},{119,71.6}},color={0,0,127}));
  connect(sI_to_pu.Vdc_pu, EnergyControl.Vdc) annotation (Line(points={{-70.8,
          78.2},{-70.8,46},{-120,46},{-120,32},{-109.333,32}}, color={0,0,127}));
  connect(pin_n, avgMMCmodel.pin_n) annotation (Line(points={{-210,-70},{-194,
          -70},{-194,138},{-136,138},{-136,137.5},{-80.2647,137.5}},
                                                                  color={0,0,255}));
  connect(avgMMCmodel.p, pwPin) annotation (Line(points={{78.2647,149},{140,149},
          {140,150},{194,150},{194,-2},{210,-2}},
                              color={0,0,255}));
  connect(EnergyControl.Wtot, energy_Calculator.Wtot)
    annotation (Line(points={{-109.333,20},{-138.4,20}}, color={0,0,127}));
  connect(dq_to_RI.xr, pu_to_SI.Vmr_pu) annotation (Line(points={{164.3,41.9},{
          164.3,60},{132,60},{132,71.6}},          color={0,0,127}));
  connect(dq_to_RI.xi, pu_to_SI.Vmi_pu) annotation (Line(points={{174.7,41.9},{
          174.7,62},{146.3,62},{146.3,71.6}},
                                            color={0,0,127}));
  connect(gain.u, Vac_ref)
    annotation (Line(points={{16.8,-168},{0,-168},{0,-200}}, color={0,0,127}));
  connect(gain.y, Vac_ref_SI) annotation (Line(points={{30.6,-168},{34,-168},{
          34,-169},{49,-169}},
                     color={0,0,127}));
  connect(EnergyControl.Pac, pQ_calculator.Pac) annotation (Line(points={{
          -109.333,7.6},{-120,7.6},{-120,-12.8},{-124.8,-12.8}},
                                                        color={0,0,127}));
  connect(polar2Complex.xmag, Vac_ref)
    annotation (Line(points={{-18,-160},{0,-160},{0,-200}}, color={0,0,127}));
  connect(rI_to_dq2.xr, polar2Complex.xr) annotation (Line(points={{-58,-166},{
          -50,-166.1},{-41.9,-166.1}},    color={0,0,127}));
  connect(rI_to_dq2.xi, polar2Complex.xi) annotation (Line(points={{-58,-154},{
          -50,-154},{-50,-154.1},{-41.9,-154.1}},
                                          color={0,0,127}));
  connect(rI_to_dq2.xd, aCd_axisVoltageControl.Vgd_ref) annotation (Line(points={{-81.9,
          -166.1},{-100,-166.1},{-100,-76},{-88,-76}},                color={0,0,
          127}));
  connect(synchronization02_1.f_ref, f_ref) annotation (Line(points={{-162,-150},
          {-170,-150},{-170,-174},{-100,-174},{-100,-200}}, color={0,0,127}));
  connect(synchronization02_1.theta, polar2Complex.angle) annotation (Line(
        points={{-139,-140},{-30,-140},{-30,-148}}, color={0,0,127}));
  connect(dq_to_RI.angle, synchronization02_1.theta) annotation (Line(points={{182,30},
          {186,30},{186,-140},{-139,-140}},           color={0,0,127}));
  connect(rI_to_dq1.angle, synchronization02_1.theta) annotation (Line(points={{52,58},
          {60,58},{60,-140},{-139,-140}},                                color=
          {0,0,127}));
  connect(rI_to_dq.angle, synchronization02_1.theta) annotation (Line(points={{12,58},
          {24,58},{24,-140},{-139,-140}},                               color={
          0,0,127}));
  connect(gain1.u, theta_ref)
    annotation (Line(points={{100,-171.2},{100,-200}}, color={0,0,127}));
  connect(synchronization02_1.theta_ref, gain1.y) annotation (Line(points={{-150,
          -132},{-150,-126},{100,-126},{100,-157.4}},
        color={0,0,127}));
  connect(aCq_axisVoltageControl.Vgq_ref, rI_to_dq2.xq) annotation (Line(points={{-88,-28},
          {-112,-28},{-112,-154.1},{-81.9,-154.1}},                   color={0,
          0,127}));
  connect(aCqaxisModulation.Vmq, dq_to_RI.xq) annotation (Line(points={{142,-88},
          {174.8,-88},{174.8,18}}, color={0,0,127}));
  connect(aCdaxisModulation.Vmd, dq_to_RI.xd) annotation (Line(points={{142,-40},
          {164.6,-40},{164.6,18}}, color={0,0,127}));
  connect(dq_to_RI.angle, polar2Complex.angle) annotation (Line(points={{182,30},
          {186,30},{186,-140},{-30,-140},{-30,-148}},
        color={0,0,127}));
  connect(rI_to_dq2.angle, synchronization02_1.theta) annotation (Line(points={{-70,
          -148},{-70,-140},{-139,-140}},      color={0,0,127}));
  connect(avgMMCmodel.VmI, pu_to_SI.Vmi_SI) annotation (Line(points={{14.8529,
          123.7},{14.8529,118},{145,118},{145,92.4}}, color={0,0,127}));
  connect(avgMMCmodel.VmR, pu_to_SI.Vmr_SI) annotation (Line(points={{1.26471,
          123.7},{1.26471,116},{132,116},{132,92.4}}, color={0,0,127}));
  connect(avgMMCmodel.V_m_dc, pu_to_SI.Vmdc_SI) annotation (Line(points={{
          -34.9706,123.7},{-34.9706,114},{118,114},{118,102},{119,102},{119,
          92.4}}, color={0,0,127}));
  connect(avgMMCmodel.Vc_eq, sI_to_pu.Vceq_SI) annotation (Line(points={{
          -16.8529,123.7},{-16.8529,110},{-31.7,110},{-31.7,99.8}}, color={0,0,
          127}));
  connect(avgMMCmodel.Vdc, sI_to_pu.Vdc_SI) annotation (Line(points={{-71.2059,
          123.7},{-71.2059,99.8},{-70.8,99.8}}, color={0,0,127}));
  connect(rI_to_dq.xi, sI_to_pu.Vgi_pu) annotation (Line(points={{6,70},{6,74},
          {9.7,74},{9.7,78.2}}, color={0,0,127}));
  connect(sI_to_pu.Vgr_pu, rI_to_dq.xr) annotation (Line(points={{-11,78.2},{
          -11,74},{-6,74},{-6,70}}, color={0,0,127}));
  connect(rI_to_dq1.xi, sI_to_pu.Igi_pu) annotation (Line(points={{46,70},{46,
          74},{48.8,74},{48.8,78.2}}, color={0,0,127}));
  connect(rI_to_dq1.xr, sI_to_pu.Igr_pu) annotation (Line(points={{34,70},{34,
          74},{30.4,74},{30.4,78.2}}, color={0,0,127}));
  connect(pQ_calculator.vgd, rI_to_dq.xd) annotation (Line(points={{-171.4,
          -24.2},{-186,-24.2},{-186,60},{-14,60},{-14,42},{-6.1,42},{-6.1,46.1}},
        color={0,0,127}));
  connect(rI_to_dq.xq, pQ_calculator.vgq) annotation (Line(points={{5.9,46.1},{
          5.9,40},{-18,40},{-18,58},{-184,58},{-184,-32.2},{-171.4,-32.2}},
        color={0,0,127}));
  connect(pQ_calculator.igd, rI_to_dq1.xd) annotation (Line(points={{-171.4,
          -7.8},{-182,-7.8},{-182,56},{-22,56},{-22,38},{33.9,38},{33.9,46.1}},
        color={0,0,127}));
  connect(rI_to_dq1.xq, pQ_calculator.igq) annotation (Line(points={{45.9,46.1},
          {45.9,36},{-26,36},{-26,54},{-180,54},{-180,-16},{-176,-16},{-176,
          -16.2},{-171.4,-16.2}}, color={0,0,127}));
  connect(synchronization02_1.Vq, rI_to_dq.xq) annotation (Line(points={{-162,
          -138},{-184,-138},{-184,58},{-18,58},{-18,40},{5.9,40},{5.9,46.1}},
        color={0,0,127}));
  connect(aCq_axisVoltageControl.Vgq, rI_to_dq.xq) annotation (Line(points={{
          -88,-52},{-184,-52},{-184,58},{-18,58},{-18,40},{5.9,40},{5.9,46.1}},
        color={0,0,127}));
  connect(dCsideModulation.idc_ref, EnergyControl.idc_ref)
    annotation (Line(points={{96,20},{-64.3333,20}}, color={0,0,127}));
  connect(dCsideModulation.idc, sI_to_pu.Idc_pu) annotation (Line(points={{96,
          12},{-52,12},{-52,74},{-52.4,74},{-52.4,78.2}}, color={0,0,127}));
  connect(dCsideModulation.Vdc, sI_to_pu.Vdc_pu) annotation (Line(points={{96,4},
          {-56,4},{-56,52},{-70.8,52},{-70.8,78.2}}, color={0,0,127}));
  connect(dCsideModulation.Vc_eq, sI_to_pu.Vceq_pu) annotation (Line(points={{
          96,-4},{-32,-4},{-32,74},{-31.7,74},{-31.7,78.2}}, color={0,0,127}));
  connect(aCd_axisVoltageControl.Vgd, rI_to_dq.xd) annotation (Line(points={{
          -88,-100},{-186,-100},{-186,60},{-14,60},{-14,42},{-6.1,42},{-6.1,
          46.1}}, color={0,0,127}));
  connect(aCd_axisVoltageControl.igq_ref, aCqaxisModulation.igq_ref)
    annotation (Line(points={{-42,-88},{96,-88}}, color={0,0,127}));
  connect(aCdaxisModulation.igd_ref, aCq_axisVoltageControl.igd_ref)
    annotation (Line(points={{96,-40},{-42,-40}}, color={0,0,127}));
  connect(energy_Calculator.Vceq, sI_to_pu.Vceq_pu) annotation (Line(points={{
          -161.7,20.1},{-172,20.1},{-172,68},{-32,68},{-32,74},{-31.7,74},{
          -31.7,78.2}}, color={0,0,127}));
  connect(aCdaxisModulation.vgd, rI_to_dq.xd) annotation (Line(points={{96,-32},
          {-6,-32},{-6,42},{-6.1,42},{-6.1,46.1}}, color={0,0,127}));
  connect(aCdaxisModulation.igd, rI_to_dq1.xd) annotation (Line(points={{96,-48},
          {34,-48},{34,38},{33.9,38},{33.9,46.1}}, color={0,0,127}));
  connect(aCdaxisModulation.igq, rI_to_dq1.xq) annotation (Line(points={{96,-56},
          {46,-56},{46,36},{45.9,36},{45.9,46.1}}, color={0,0,127}));
  connect(aCdaxisModulation.Vc_eq, sI_to_pu.Vceq_pu) annotation (Line(points={{
          96,-64},{-32,-64},{-32,74},{-31.7,74},{-31.7,78.2}}, color={0,0,127}));
  connect(aCqaxisModulation.vgq, rI_to_dq.xq) annotation (Line(points={{96,-80},
          {6,-80},{6,40},{5.9,40},{5.9,46.1}}, color={0,0,127}));
  connect(aCqaxisModulation.igq, rI_to_dq1.xq) annotation (Line(points={{96,-96},
          {46,-96},{46,36},{45.9,36},{45.9,46.1}}, color={0,0,127}));
  connect(aCqaxisModulation.igd, rI_to_dq1.xd) annotation (Line(points={{96,
          -104},{34,-104},{34,38},{33.9,38},{33.9,46.1}}, color={0,0,127}));
  connect(aCqaxisModulation.Vc_eq, sI_to_pu.Vceq_pu) annotation (Line(points={{
          96,-112},{-32,-112},{-32,74},{-31.7,74},{-31.7,78.2}}, color={0,0,127}));
  connect(pin_p, avgMMCmodel.pin_p) annotation (Line(points={{-210,90},{-196,90},
          {-196,162.34},{-80.2647,162.34}},
                                          color={0,0,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-200,-180},
            {200,180}}), graphics={
        Rectangle(
          extent={{-200,180},{200,-180}},
          lineColor={0,0,0},
          lineThickness=1),
        Line(
          points={{-200,180},{200,-180}},
          color={0,0,0},
          thickness=1),
        Line(
          points={{-108,-36},{-28,-36}},
          color={0,0,0},
          thickness=1),
        Line(
          points={{-92,-24}},
          color={0,0,0},
          thickness=0.5),
        Line(
          points={{-108,-76},{-28,-76}},
          color={0,0,0},
          thickness=1),
        Line(
          points={{44,82},{74,112},{104,82},{132,110}},
          color={0,0,0},
          thickness=1),
        Text(
          extent={{-90,52},{116,-20}},
          textColor={238,46,47},
          textString="MMC"),
        Text(
          extent={{-202,114},{-132,62}},
          textColor={0,0,0},
          textString="+"),
        Text(
          extent={{-204,-44},{-134,-96}},
          textColor={0,0,0},
          textString="-"),
        Text(
          extent={{-66,-136},{44,-164}},
          textColor={0,0,0},
          textString="Vac_ref"),
        Text(
          extent={{-176,-134},{-72,-164}},
          textColor={0,0,0},
          textString="f_ref"),
        Text(
          extent={{60,-140},{170,-166}},
          textColor={0,0,0},
          textString="theta_ref")}),                             Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-200,-180},{200,180}})));
end ACvoltageModeMMCstation;
