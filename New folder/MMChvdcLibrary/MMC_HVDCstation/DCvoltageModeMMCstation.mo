within MMChvdcLibrary.MMC_HVDCstation;
model DCvoltageModeMMCstation "MMC HVDC station with only DC voltage control."
  import CM = Modelica.ComplexMath;
  import      Modelica.Units.SI;
  import Complex;
  ComponentLibrary.BasicBlocks.Tranformation.SItoPU                     sI_to_pu(
    Vb=Vb,
    MVAb=MVAb,
    Vdcb=Vdcb) annotation (Placement(transformation(extent={{-47,-10},{47,10}},
          origin={-29,88})));
  ComponentLibrary.BasicBlocks.Tranformation.PUtoSI                     pu_to_SI(Vb=Vb,
      Vdcb=Vdcb) annotation (Placement(transformation(
        extent={{-26,-10},{26,10}},
        rotation=180,
        origin={124,92})));
  ComponentLibrary.ControlBlocks.OuterLoopControls.EnergyControl.VariableRefEnergyControl
    EnergyControl(
    k=10,
    T=0.05/3,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    x_start=0,
    y_start=W_0) annotation (Placement(transformation(extent={{-20,-20},{20,20}},
          origin={-72,20})));
  ComponentLibrary.ControlBlocks.OuterLoopControls.DCvoltageControl.DCvotlageControl
    DCvoltageControl(
    k=10,
    T(displayUnit="ms") = 0.001*(100/3),
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    x_start=0,
    y_start=-P_0) annotation (Placement(transformation(extent={{-20,-20},{20,20}},
          origin={-40,-40})));
  ComponentLibrary.ControlBlocks.OuterLoopControls.ReactivePowerControl.ReactivePowerControl
    reactivePowerControl(
    k=10,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    y_start=Q_0) annotation (Placement(transformation(extent={{-20,-20},{20,20}},
          origin={-40,-100})));
  ComponentLibrary.ControlBlocks.InnerLoopControls.DCcurrentControl.DCcurrentControl
    DCcurrentControl(
    k=1,
    T=0.004/3,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    x_start=0,
    y_start=DC_0) annotation (Placement(transformation(extent={{-20,-20},{20,20}},
          origin={120,8})));
  ComponentLibrary.ControlBlocks.InnerLoopControls.ACcurrentControl.dAxisACcurrentControl
    dAxisACcurrentControl(
    fb=avgMMCmodel.SysData.fn,
    Xr=avgMMCmodel.Xr,
    L_arm=avgMMCmodel.L_arm,
    Vb=avgMMCmodel.Vb,
    MVAb=avgMMCmodel.MVAb,
    Kp=1.5,
    T(displayUnit="s") = 0.005/3,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    x_start=0,
    y_start=ACd0) annotation (Placement(transformation(extent={{-20,-20},{20,20}},
          origin={120,-48})));
  ComponentLibrary.ControlBlocks.InnerLoopControls.ACcurrentControl.qAxisACcurrentControl
    qAxisACcurrentControl(
    fb=avgMMCmodel.SysData.fn,
    Xr=avgMMCmodel.Xr,
    L_arm=avgMMCmodel.L_arm,
    Vb=avgMMCmodel.Vb,
    MVAb=avgMMCmodel.Vb,
    Kp=1.5,
    T=0.005/3,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    x_start=0,
    y_start=ACq0) annotation (Placement(transformation(extent={{-20,-20},{20,20}},
          origin={120,-108})));
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
    v_ref=V_0) annotation (Placement(transformation(extent={{-77,-22},{77,22}},
          origin={-1,148})));
  ComponentLibrary.BasicBlocks.Calculator.PQcalculator                     pQ_calculator
    annotation (Placement(transformation(extent={{-160,-66},{-120,-26}})));
  Modelica.Electrical.Analog.Interfaces.PositivePin pin_p annotation (Placement(
        transformation(extent={{-220,80},{-200,100}}), iconTransformation(
          extent={{-220,80},{-200,100}})));
  Modelica.Electrical.Analog.Interfaces.NegativePin pin_n annotation (Placement(
        transformation(extent={{-220,-80},{-200,-60}}), iconTransformation(
          extent={{-220,-80},{-200,-60}})));
  OpenIPSL.Interfaces.PwPin pwPin annotation (Placement(transformation(extent={{
            200,-12},{220,8}}), iconTransformation(extent={{200,-12},{220,8}})));
  Modelica.Blocks.Interfaces.RealInput Qref annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={100,-200})));
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
  //parameter Real P_vsc_dc_pu = -P_0;

  parameter Real R_dc = 2*R_arm*Vb*Vb/(3*MVAb) "Equivalent DC resistance (Ohm)";
  parameter Real Vdc0_SI = Vdc_0*Vdcb*1000 "DC voltage  (V)";
  parameter Real dis = sqrt(Vdc0_SI*Vdc0_SI-(4*R_dc*P_vsc_dc));
  parameter Real Idc0_SI= -(-1*Vdc0_SI+(dis))/(2*R_dc) "DC current (A)";
  //parameter Real Idc0_SI =  (Vdc0_SI - (Vdc0_SI - P_vsc_dc * R_dc/Vdc0_SI))/R_dc;
  parameter Real Vmdc0_SI= Vdc0_SI-R_dc*Idc0_SI  "DC current (A)";
  parameter Real Pdc_0_SI=Vdc0_SI*Idc0_SI;

  //Energy Controller
  parameter Real W_0 = (Pdc_0_SI-P_SI)/(MVAb*1E6) "Initial output of PI controller";

  //Active Power Control
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
  ComponentLibrary.BasicBlocks.Tranformation.dqToRI                     dq_to_RI
    annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=90,
        origin={176,50})));
  ComponentLibrary.BasicBlocks.Tranformation.RITodq                     rI_to_dq
    annotation (Placement(transformation(
        extent={{-9,10},{9,-10}},
        rotation=270,
        origin={-22,49})));
  Modelica.Blocks.Math.Atan2           atan2_1
                   annotation (Placement(transformation(
        extent={{-3,3},{3,-3}},
        rotation=270,
        origin={35,47})));
  ComponentLibrary.BasicBlocks.Tranformation.RITodq                     rI_to_dq1
    annotation (Placement(transformation(
        extent={{-9,10},{9,-10}},
        rotation=270,
        origin={6,49})));
  Modelica.Blocks.Math.Gain gain1(k=MVAb)
                                        annotation (
    Placement(visible = true, transformation(origin={114,-160},     extent={{-6,-6},
            {6,6}},                                                                                  rotation=0)));
  Modelica.Blocks.Interfaces.RealOutput Qref_SI
    "Reference AC Rective Power (MVAr)" annotation (Placement(transformation(
        extent={{-9,-9},{9,9}},
        rotation=0,
        origin={143,-169}), iconTransformation(
        extent={{-9,-9},{9,9}},
        rotation=270,
        origin={187,-109})));
  Modelica.Blocks.Math.Gain gain(k=Vdcb)
                                        annotation (
    Placement(visible = true, transformation(origin={38,-160},      extent={{-6,-6},
            {6,6}},                                                                                  rotation=0)));
  Modelica.Blocks.Interfaces.RealInput Vref annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={20,-200}),iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={-100,-200})));
  Modelica.Blocks.Interfaces.RealOutput Vref_SI
    "Reference AC Active Power (MW)" annotation (Placement(transformation(
        extent={{-9,-9},{9,9}},
        rotation=0,
        origin={65,-169}), iconTransformation(
        extent={{-9,-9},{9,9}},
        rotation=270,
        origin={187,-109})));
protected
  ComponentLibrary.BasicBlocks.Calculator.EnergyCalculator                     energy_Calculator(C_eq=6*
        C_sub/N_sub)
    annotation (Placement(transformation(extent={{-160,10},{-140,30}})));
equation
  connect(DCcurrentControl.Vmdc, pu_to_SI.Vmdc_pu) annotation (Line(points={{142,12},
          {150,12},{150,66},{111,66},{111,79}},  color={0,0,127}));
  connect(reactivePowerControl.igq_ref, qAxisACcurrentControl.igq_ref)
    annotation (Line(points={{-18,-100},{96,-100}}, color={0,0,127}));
  connect(avgMMCmodel.p, pwPin) annotation (Line(points={{78.2647,148},{196,148},
          {196,-2},{210,-2}}, color={0,0,255}));
  connect(avgMMCmodel.VmR, pu_to_SI.Vmr_SI) annotation (Line(points={{1.26471,
          123.8},{1.26471,116},{124,116},{124,105}}, color={0,0,127}));
  connect(EnergyControl.Wtot, energy_Calculator.Wtot)
    annotation (Line(points={{-95.3333,20},{-138.4,20}}, color={0,0,127}));
  connect(rI_to_dq.angle, rI_to_dq1.angle) annotation (Line(points={{-10,49},{
          -6,49},{-6,32},{26,32},{26,49},{18,49}},        color={0,0,127}));
  connect(dq_to_RI.xr, pu_to_SI.Vmr_pu) annotation (Line(points={{172.58,57.14},
          {172.58,68},{124,68},{124,79}},          color={0,0,127}));
  connect(dq_to_RI.xi, pu_to_SI.Vmi_pu) annotation (Line(points={{178.82,57.14},
          {178.82,70},{138.3,70},{138.3,79}},
                                            color={0,0,127}));
  connect(dAxisACcurrentControl.Vmd, dq_to_RI.xd) annotation (Line(points={{142,
          -40},{172.76,-40},{172.76,42.8}}, color={0,0,127}));
  connect(qAxisACcurrentControl.Vmq, dq_to_RI.xq) annotation (Line(points={{142,
          -100},{178.88,-100},{178.88,42.8}}, color={0,0,127}));
  connect(dq_to_RI.angle, rI_to_dq1.angle) annotation (Line(points={{183.2,50},
          {188,50},{188,32},{26,32},{26,49},{18,49}},     color={0,0,127}));
  connect(atan2_1.y, rI_to_dq1.angle) annotation (Line(points={{35,43.7},{35,32},
          {26,32},{26,49},{18,49}},      color={0,0,127}));
  connect(gain1.y, Qref_SI) annotation (Line(points={{120.6,-160},{128,-160},{
          128,-169},{143,-169}},
                      color={0,0,127}));
  connect(gain1.u, Qref) annotation (Line(points={{106.8,-160},{100,-160},{100,
          -200}}, color={0,0,127}));
  connect(sI_to_pu.Vceq_SI, avgMMCmodel.Vc_eq) annotation (Line(points={{-43.1,
          100},{-42,100},{-42,112},{-16.8529,112},{-16.8529,123.8}}, color={0,0,
          127}));
  connect(sI_to_pu.Igi_SI, avgMMCmodel.IgI) annotation (Line(points={{11.7333,
          100},{11.7333,104},{69.2059,104},{69.2059,123.8}}, color={0,0,127}));
  connect(sI_to_pu.Igr_SI, avgMMCmodel.IgR) annotation (Line(points={{-0.8,100},
          {-0.8,106},{60.1471,106},{60.1471,123.8}}, color={0,0,127}));
  connect(sI_to_pu.Vgi_SI, avgMMCmodel.VgI) annotation (Line(points={{-14.9,100},
          {-14.9,108},{51.0882,108},{51.0882,123.8}}, color={0,0,127}));
  connect(sI_to_pu.Vgr_SI, avgMMCmodel.VgR) annotation (Line(points={{-29,100},
          {-29,110},{42.0294,110},{42.0294,123.8}}, color={0,0,127}));
  connect(avgMMCmodel.VmI, pu_to_SI.Vmi_SI) annotation (Line(points={{14.8529,
          123.8},{14.8529,118},{137,118},{137,105}}, color={0,0,127}));
  connect(avgMMCmodel.V_m_dc, pu_to_SI.Vmdc_SI) annotation (Line(points={{
          -34.9706,123.8},{-34.9706,114},{111,114},{111,105}}, color={0,0,127}));
  connect(avgMMCmodel.Idc, sI_to_pu.Idc_SI) annotation (Line(points={{-62.1471,
          123.8},{-62.1471,108},{-57.2,108},{-57.2,100}}, color={0,0,127}));
  connect(avgMMCmodel.Vdc, sI_to_pu.Vdc_SI) annotation (Line(points={{-71.2059,
          123.8},{-71.2059,108},{-69.7333,108},{-69.7333,100}}, color={0,0,127}));
  connect(pin_p, pin_p)
    annotation (Line(points={{-210,90},{-210,90}}, color={0,0,255}));
  connect(avgMMCmodel.pin_p, pin_p) annotation (Line(points={{-80.2647,160.76},
          {-198,160.76},{-198,90},{-210,90}},
                                            color={0,0,255}));
  connect(avgMMCmodel.pin_n, pin_n) annotation (Line(points={{-80.2647,137},{
          -194,137},{-194,-70},{-210,-70}}, color={0,0,255}));
  connect(rI_to_dq.xi, sI_to_pu.Vgi_pu) annotation (Line(points={{-16,59.8},{
          -16,66},{-14.9,66},{-14.9,76}}, color={0,0,127}));
  connect(rI_to_dq.xr, sI_to_pu.Vgr_pu)
    annotation (Line(points={{-28,59.8},{-28,76},{-29,76}}, color={0,0,127}));
  connect(atan2_1.u1, sI_to_pu.Vgi_pu) annotation (Line(points={{33.2,50.6},{
          33.2,66},{-14.9,66},{-14.9,76}}, color={0,0,127}));
  connect(rI_to_dq1.xi, sI_to_pu.Igi_pu) annotation (Line(points={{12,59.8},{12,
          76},{11.7333,76}}, color={0,0,127}));
  connect(sI_to_pu.Igr_pu, rI_to_dq1.xr) annotation (Line(points={{-0.8,76},{
          -0.8,59.8},{0,59.8}}, color={0,0,127}));
  connect(atan2_1.u2, sI_to_pu.Vgr_pu) annotation (Line(points={{36.8,50.6},{
          36.8,70},{-28,70},{-28,76},{-29,76}}, color={0,0,127}));
  connect(EnergyControl.idc_ref, DCcurrentControl.idc_ref)
    annotation (Line(points={{-50.3333,20},{96,20}}, color={0,0,127}));
  connect(pQ_calculator.igd, rI_to_dq1.xd) annotation (Line(points={{-163.4,
          -33.8},{-172,-33.8},{-172,-18},{-0.1,-18},{-0.1,38.29}}, color={0,0,
          127}));
  connect(pQ_calculator.igq, rI_to_dq1.xq) annotation (Line(points={{-163.4,
          -42.2},{-176,-42.2},{-176,-14},{11.9,-14},{11.9,38.29}}, color={0,0,
          127}));
  connect(pQ_calculator.vgd, rI_to_dq.xd) annotation (Line(points={{-163.4,
          -50.2},{-180,-50.2},{-180,-10},{-28.1,-10},{-28.1,38.29}}, color={0,0,
          127}));
  connect(pQ_calculator.vgq, rI_to_dq.xq) annotation (Line(points={{-163.4,
          -58.2},{-184,-58.2},{-184,-6},{-16.1,-6},{-16.1,38.29}}, color={0,0,
          127}));
  connect(reactivePowerControl.Qac_ref, Qref) annotation (Line(points={{-64,-88},
          {-80,-88},{-80,-140},{100,-140},{100,-200}}, color={0,0,127}));
  connect(reactivePowerControl.Qac, pQ_calculator.Qac) annotation (Line(points={{-64,
          -100},{-110,-100},{-110,-54},{-116.8,-54}},       color={0,0,127}));
  connect(EnergyControl.Pac, pQ_calculator.Pac) annotation (Line(points={{
          -95.3333,7.6},{-110,7.6},{-110,-38.8},{-116.8,-38.8}},
                                                        color={0,0,127}));
  connect(sI_to_pu.Idc_pu, DCcurrentControl.idc) annotation (Line(points={{
          -57.2,76},{-57.2,64},{-36,64},{-36,12},{96,12}}, color={0,0,127}));
  connect(EnergyControl.Vdc, sI_to_pu.Vdc_pu) annotation (Line(points={{
          -95.3333,32},{-106,32},{-106,60},{-69.7333,60},{-69.7333,76}},
                                                                color={0,0,127}));
  connect(DCcurrentControl.Vdc, sI_to_pu.Vdc_pu) annotation (Line(points={{96,4},{
          -40,4},{-40,60},{-69.7333,60},{-69.7333,76}},  color={0,0,127}));
  connect(sI_to_pu.Vceq_pu, DCcurrentControl.Vc_eq)
    annotation (Line(points={{-43.1,76},{-43.1,-4},{96,-4}}, color={0,0,127}));
  connect(energy_Calculator.Vceq, sI_to_pu.Vceq_pu) annotation (Line(points={{
          -161.7,20.1},{-166,20.1},{-166,50},{-43.1,50},{-43.1,76}}, color={0,0,
          127}));
  connect(qAxisACcurrentControl.vgq, rI_to_dq.xq) annotation (Line(points={{96,
          -92},{-8,-92},{-8,-74},{-92,-74},{-92,-6},{-16.1,-6},{-16.1,38.29}},
        color={0,0,127}));
  connect(DCvoltageControl.Vgd, rI_to_dq.xd) annotation (Line(points={{-64,-52},
          {-100,-52},{-100,-10},{-28.1,-10},{-28.1,38.29}}, color={0,0,127}));
  connect(reactivePowerControl.Vgd, rI_to_dq.xd) annotation (Line(points={{-64,
          -112},{-100,-112},{-100,-10},{-28.1,-10},{-28.1,38.29}}, color={0,0,
          127}));
  connect(dAxisACcurrentControl.vgd, rI_to_dq.xd) annotation (Line(points={{96,
          -32},{-8,-32},{-8,-66},{-100,-66},{-100,-10},{-28.1,-10},{-28.1,38.29}},
        color={0,0,127}));
  connect(dAxisACcurrentControl.igd, rI_to_dq1.xd) annotation (Line(points={{96,
          -48},{0,-48},{0,-18},{-0.1,-18},{-0.1,38.29}}, color={0,0,127}));
  connect(dAxisACcurrentControl.igq, rI_to_dq1.xq) annotation (Line(points={{96,
          -56},{12,-56},{12,-14},{11.9,-14},{11.9,38.29}}, color={0,0,127}));
  connect(qAxisACcurrentControl.igq, rI_to_dq1.xq) annotation (Line(points={{96,
          -108},{12,-108},{12,-14},{11.9,-14},{11.9,38.29}}, color={0,0,127}));
  connect(qAxisACcurrentControl.igd, rI_to_dq1.xd) annotation (Line(points={{96,
          -116},{0,-116},{0,-18},{-0.1,-18},{-0.1,38.29}}, color={0,0,127}));
  connect(sI_to_pu.Vceq_pu, dAxisACcurrentControl.Vc_eq) annotation (Line(
        points={{-43.1,76},{-43.1,-4},{60,-4},{60,-64},{96,-64}}, color={0,0,
          127}));
  connect(qAxisACcurrentControl.Vc_eq, sI_to_pu.Vceq_pu) annotation (Line(
        points={{96,-124},{60,-124},{60,-4},{-43.1,-4},{-43.1,76}}, color={0,0,
          127}));
  connect(gain.u,Vref)
    annotation (Line(points={{30.8,-160},{20,-160},{20,-200}},
                                                             color={0,0,127}));
  connect(gain.y,Vref_SI)  annotation (Line(points={{44.6,-160},{50,-160},{50,
          -169},{65,-169}},
                  color={0,0,127}));
  connect(DCvoltageControl.Vdc_ref, Vref) annotation (Line(points={{-64,-28},{
          -86,-28},{-86,-160},{20,-160},{20,-200}}, color={0,0,127}));
  connect(DCvoltageControl.igd_ref, dAxisACcurrentControl.igd_ref) annotation (
      Line(points={{-18,-40},{-12,-40},{-12,-40},{96,-40}}, color={0,0,127}));
  connect(sI_to_pu.Vdc_pu, DCvoltageControl.Vdc) annotation (Line(points={{
          -69.7333,76},{-69.7333,60},{-106,60},{-106,-40},{-64,-40}}, color={0,
          0,127}));
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
          extent={{-146,-142},{-54,-172}},
          textColor={0,0,0},
          textString="Vdc_ref"),
        Text(
          extent={{62,-134},{142,-176}},
          textColor={0,0,0},
          textString="Qref")}),                                  Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-200,-180},{200,180}})));
end DCvoltageModeMMCstation;
