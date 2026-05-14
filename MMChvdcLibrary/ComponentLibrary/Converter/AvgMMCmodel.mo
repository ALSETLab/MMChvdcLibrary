within MMChvdcLibrary.ComponentLibrary.Converter;
model AvgMMCmodel "Average MMC HVDC model"
  outer OpenIPSL.Electrical.SystemBase SysData;
  import CM = Modelica.ComplexMath;
  import      Modelica.Units.SI;
  import Complex;
  parameter Real Rr = Rr "Connection resistance (pu)" annotation (
    Dialog(group = "Physical parameters"));
  parameter Real Xr = Xr "Connection inductance L (pu)" annotation (
    Dialog(group = "Physical parameters"));
  parameter Real L_arm = L_arm "MMC arm inductance (pu)" annotation (
    Dialog(group = "Physical parameters"));
  parameter Real R_arm = R_arm "MMC arm resistance (pu)" annotation (
    Dialog(group = "Physical parameters"));
  parameter Real C_sub = C_sub "MMC submodule capacitor (F)" annotation (
    Dialog(group = "Physical parameters"));
  parameter Real N_sub = N_sub "Number of submodules per arm" annotation (
    Dialog(group = "Physical parameters"));
  parameter Real S_b = S_b "System base power (MVA)" annotation (
    Dialog(group = "Base values"));
  parameter Real MVAb = MVAb "Converter rated power (MVA)" annotation (
    Dialog(group = "Base values"));
  parameter Real fb = fb "System frequency (Hz)" annotation (
    Dialog(group = "Base values"));
  parameter Real Vb = Vb "Base voltage (kV)" annotation (
    Dialog(group = "Base values"));
  parameter Real Vdcb = Vdcb "Base DC voltage (kV)" annotation (
    Dialog(group = "Base values"));
  parameter Real Vgd = Vgd "Connection bus voltage magnitude (V)" annotation (
    Dialog(group = "Power flow data"));
  parameter SI.Angle teta_bus = teta_bus "Connection bus voltage angle (radian)" annotation (
    Dialog(group = "Power flow data"));
  parameter Real Vdc0 = Vdc0 "DC voltage reference (pu)" annotation (
    Dialog(group = "Control"));
  parameter Real Wmmc_0 = Wmmc_0 "Energy reference (pu)" annotation (
    Dialog(group = "Control"));
  parameter Real P_ref = P_ref "=Pref initial (W)" annotation (
    Dialog(group = "Power flow data"));
  parameter Real Q_ref = Q_ref "=-Qref initial (VAr)" annotation (
    Dialog(group = "Power flow data"));
  parameter Real v_ref = v_ref "=reference PCC voltage (pu)" annotation (
    Dialog(group = "Control"));

  //Initialization of AC side
  parameter Complex S0(re = P_ref, im = -Q_ref) "Init. val., conjugate";
  parameter Complex xq0 = CM.j * (Xr + 0.5 * L_arm) * Vb * Vb / MVAb "AC equivalent inductive reactance";
  parameter Complex Ra0(re = (Rr + R_arm / 2) * Vb * Vb / MVAb, im = 0) "AC equivalent resistance";
  parameter Complex Vt0 = CM.fromPolar(Vgd / sqrt(3), teta_bus) "Connection bus voltage in complex form";
  parameter Complex I0 = 1 / 3 * (S0 / CM.conj(Vt0)) "Initial AC current (complex)";
  parameter Real ir0 = CM.real(I0) "Initial AC real current";
  parameter Real ii0 = CM.imag(I0) "Initial AC imaginary current";
  parameter Complex v_modulated = Vt0 + (Ra0 + xq0) * I0 "Modulated connection bus voltage magnitude (V)";
  parameter SI.Angle delta0 = CM.arg(Vt0 + (Ra0 + xq0) * I0) "Modulated connection bus voltage angle (radian)";

  // Initialization of DC side*
  parameter Complex P_vsc_ac=v_modulated*CM.conj(I0) "Per phase AC Power";
  parameter Real P_vsc_dc=CM.real(P_vsc_ac)*((3)) "DC Power";
  parameter Real R_dc_SI = 2*R_arm*Vb*Vb/(3*MVAb) "DC side equivalent resistance";
  parameter Real Vdc0_SI = Vdc0*Vdcb*1000 "DC volatge";
  parameter Real dis = sqrt(Vdc0_SI*Vdc0_SI-(4*R_dc_SI*P_vsc_dc)) "Temporary variable";
  parameter Real Idc0= -(-1*Vdc0_SI+(dis))/(2*R_dc_SI) "Initial DC current";
  //parameter Real Vmdc0 = Vdc0_SI - P_vsc_dc * R_dc_SI/Vdc0_SI; % Modulated DC Voltage
  //parameter Real Idc0 =  (Vdc0_SI - (Vdc0_SI - P_vsc_dc * R_dc_SI/Vdc0_SI))/R_dc_SI;
  Modelica.Electrical.Analog.Interfaces.PositivePin pin_p
    annotation (Placement(transformation(extent={{-360,48},{-340,68}}),
        iconTransformation(extent={{-360,48},{-340,68}})));
  Modelica.Electrical.Analog.Interfaces.NegativePin pin_n
    annotation (Placement(transformation(extent={{-360,-60},{-340,-40}}),
        iconTransformation(extent={{-360,-60},{-340,-40}})));
  Modelica.Electrical.Analog.Basic.Resistor R_eq_dc(R=2*R_arm*Vb*Vb/(3*MVAb))
    annotation (Placement(transformation(extent={{-348,12},{-328,32}})));
  Modelica.Electrical.Analog.Basic.Inductor L_eq_dc(i(start=Idc0, fixed=true),
                                                    L=2*L_arm*Vb*Vb/(3*2*MVAb*
        fb*Modelica.Constants.pi))
    annotation (Placement(transformation(extent={{-320,12},{-300,32}})));
  Modelica.Electrical.Analog.Sensors.VoltageSensor voltageSensor annotation (
      Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=270,
        origin={-360,-10})));
  Modelica.Blocks.Interfaces.RealOutput Vdc annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-310,-110}),iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-310,-110})));
  Modelica.Electrical.Analog.Sources.SignalVoltage Vm_dc annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-286,-8})));
  Modelica.Electrical.Analog.Sensors.CurrentSensor currentSensor annotation (
      Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={-310,-42})));
  Modelica.Blocks.Interfaces.RealOutput Idc annotation (Placement(
        transformation(
        extent={{-10,10},{10,-10}},
        rotation=270,
        origin={-270,-110}),iconTransformation(
        extent={{-10,10},{10,-10}},
        rotation=270,
        origin={-270,-110})));
  Modelica.Electrical.Analog.Sources.SignalCurrent signalCurrent annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-156,-8})));
  Modelica.Electrical.Analog.Basic.Capacitor C_eq(v(start=sqrt(Wmmc_0)*Vdcb*
          1000, fixed=true), C=6*C_sub/N_sub)     annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-134,-8})));
  Modelica.Electrical.Analog.Sensors.VoltageSensor voltageSensor1 annotation (
      Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-106,-8})));
  Modelica.Blocks.Interfaces.RealOutput Vc_eq annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-70,-110}), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-70,-110})));
  Modelica.Electrical.Analog.Sources.SignalCurrent modulated_R_current
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-68,12})));
  Modelica.Electrical.Analog.Sources.SignalCurrent modulated_I_current
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-68,-30})));
  Modelica.Electrical.Analog.Sources.SignalVoltage modulated_R_voltage
    annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=270,
        origin={40,58})));
  Modelica.Electrical.Analog.Sources.SignalVoltage modulated_I_voltage
    annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=270,
        origin={40,-54})));
  Modelica.Electrical.Analog.Sources.SignalVoltage coupling_v_R annotation (
      Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=0,
        origin={70,42})));
  Modelica.Electrical.Analog.Sources.SignalVoltage coupling_v_I annotation (
      Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={70,-38})));
  Modelica.Electrical.Analog.Basic.Inductor L_eq_ac_R(i(start=ir0, fixed=
          true),                                                    L=(Xr + 0.5
        *L_arm)*Vb*Vb/(2*MVAb*fb*Modelica.Constants.pi))
    annotation (Placement(transformation(extent={{134,32},{154,52}})));
  Modelica.Electrical.Analog.Basic.Resistor R_eq_ac_R(R=(Rr + R_arm/2)*Vb*Vb/
        MVAb)
    annotation (Placement(transformation(extent={{106,32},{126,52}})));
  Modelica.Electrical.Analog.Basic.Inductor L_eq_ac_I(i(start=ii0, fixed=true),
                                                                    L=(Xr + 0.5
        *L_arm)*Vb*Vb/(2*MVAb*fb*Modelica.Constants.pi))
    annotation (Placement(transformation(extent={{138,-48},{158,-28}})));
  Modelica.Electrical.Analog.Basic.Resistor R_eq_ac_I(R=(Rr + R_arm/2)*Vb*Vb/
        MVAb)
    annotation (Placement(transformation(extent={{106,-48},{126,-28}})));
  OpenIPSL.Interfaces.PwPin p annotation (
    Placement(visible = true, transformation(origin={384,0},       extent={{-4,-4},
            {4,4}},                                                                                 rotation = 0), iconTransformation(origin={350,0},    extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Electrical.Analog.Sources.SignalVoltage vg_R annotation (Placement(
        transformation(
        extent={{-10,10},{10,-10}},
        rotation=90,
        origin={174,58})));
  Modelica.Electrical.Analog.Sources.SignalVoltage vg_I annotation (Placement(
        transformation(
        extent={{10,10},{-10,-10}},
        rotation=90,
        origin={176,-54})));
  Modelica.Electrical.Analog.Sensors.CurrentSensor currentSensor1 annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={90,74})));
  Modelica.Electrical.Analog.Sensors.CurrentSensor currentSensor2 annotation (
      Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={90,-70})));
  OpenIPSL.Electrical.Sensors.PwVoltage pwVoltage annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={346,52})));
  Modelica.ComplexBlocks.ComplexMath.RealToComplex realToComplex1 annotation (
    Placement(visible = true, transformation(origin={330,-30},     extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OpenIPSL.NonElectrical.Nonlinear.Div0block
                                div0block
                                         annotation (Placement(visible=true,
        transformation(
        origin={-238,-4},
        extent={{-8,-8},{8,8}},
        rotation=0)));
  Modelica.Blocks.Math.Product product annotation (Placement(visible=true,
        transformation(
        origin={-192,-8},
        extent={{-8,-8},{8,8}},
        rotation=0)));
  OpenIPSL.NonElectrical.Nonlinear.Div0block
                                div0block1
                                          annotation (Placement(visible=true,
        transformation(
        origin={-3,53},
        extent={{9,-9},{-9,9}},
        rotation=0)));
  OpenIPSL.NonElectrical.Nonlinear.Div0block
                                div0block2
                                          annotation (Placement(visible=true,
        transformation(
        origin={-5,-59},
        extent={{9,-9},{-9,9}},
        rotation=0)));
  Modelica.Blocks.Math.Product product1 annotation (Placement(visible=true,
        transformation(
        origin={-26,12},
        extent={{8,-8},{-8,8}},
        rotation=0)));
  Modelica.Blocks.Math.Product product2 annotation (Placement(visible=true,
        transformation(
        origin={-26,-30},
        extent={{8,-8},{-8,8}},
        rotation=0)));
  Modelica.Blocks.Math.Gain gain3(k=(sqrt(3)*Vb)/(S_b*1000))       annotation (
    Placement(visible = true, transformation(origin={295,-19},     extent = {{5, -5}, {-5, 5}}, rotation = 180)));
  Modelica.Blocks.Math.Gain gain1(k=(sqrt(3)*Vb)/(S_b*1000))       annotation (
    Placement(visible = true, transformation(origin={295,-49},     extent = {{5, -5}, {-5, 5}}, rotation = 180)));
  Modelica.Blocks.Interfaces.RealOutput IgR annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={270,-110}), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={270,-110})));
  Modelica.Blocks.Interfaces.RealOutput IgI annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={310,-110}), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={310,-110})));
  Modelica.Blocks.Math.Gain gain(k=3)   annotation (
    Placement(visible = true, transformation(origin={-44,12},       extent={{-6,-6},
            {6,6}},                                                                                  rotation=180)));
  Modelica.Blocks.Math.Gain gain2(k=3)  annotation (
    Placement(visible = true, transformation(origin={-44,-30},      extent={{-6,-6},
            {6,6}},                                                                                  rotation=180)));
  Modelica.Blocks.Math.Gain gain5(k=Vb*1000/sqrt(3))       annotation (
    Placement(visible = true, transformation(origin={226,58},      extent = {{-6, -6}, {6, 6}}, rotation = 180)));
  Modelica.Blocks.Math.Gain gain4(k=Vb*1000/sqrt(3))       annotation (
    Placement(visible = true, transformation(origin={228,-54},     extent = {{-6, -6}, {6, 6}}, rotation = 180)));
  Modelica.Blocks.Interfaces.RealOutput VgR annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={190,-110}), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={190,-110})));
  Modelica.Blocks.Interfaces.RealOutput VgI annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={230,-110}), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={230,-110})));
  Modelica.Electrical.Analog.Basic.Ground ground2 annotation (
    Placement(visible = true, transformation(origin={142,84},      extent = {{-10, 10}, {10, -10}}, rotation = 0)));
  Modelica.Electrical.Analog.Basic.Ground ground3 annotation (
    Placement(visible = true, transformation(origin={154,-80},     extent = {{-10, 10}, {10, -10}}, rotation=180)));
  Modelica.Blocks.Sources.Constant wL(k=2*Modelica.Constants.pi*fb*(Xr + 0.5*
        L_arm)*Vb*Vb/(2*MVAb*fb*Modelica.Constants.pi))                                                                                            annotation (
    Placement(visible = true, transformation(origin={126,2},        extent={{8,-8},{
            -8,8}},                                                                              rotation = 0)));
  Modelica.Blocks.Math.Product product3 annotation (Placement(visible=true,
        transformation(
        origin={90,12},
        extent={{6,-6},{-6,6}},
        rotation=0)));
  Modelica.Blocks.Math.Product product4 annotation (Placement(visible=true,
        transformation(
        origin={90,-8},
        extent={{6,-6},{-6,6}},
        rotation=0)));
  Modelica.Blocks.Interfaces.RealInput V_m_dc annotation (Placement(
      visible=true,
      transformation(
        origin={-261,-109},
        extent={{-9,9},{9,-9}},
        rotation=90),
      iconTransformation(
        origin={-150,-110},
        extent={{-10,-10},{10,10}},
        rotation=90)));
  Modelica.Blocks.Interfaces.RealInput VmR annotation (Placement(
      visible=true,
      transformation(
        origin={-1,-105},
        extent={{-7,-7},{7,7}},
        rotation=90),
      iconTransformation(
        origin={10,-110},
        extent={{-10,-10},{10,10}},
        rotation=90)));
  Modelica.Blocks.Interfaces.RealInput VmI annotation (Placement(
      visible=true,
      transformation(
        origin={31,-105},
        extent={{-7,-7},{7,7}},
        rotation=90),
      iconTransformation(
        origin={70,-110},
        extent={{-10,-10},{10,10}},
        rotation=90)));
  BasicBlocks.PhasorModels.CurrentPhasor currentPhasor
    annotation (Placement(transformation(extent={{342,-62},{362,-42}})));
  BasicBlocks.PhasorModels.GroundPhasor groundPhasor
    annotation (Placement(transformation(extent={{326,-86},{346,-66}})));
  Modelica.Electrical.Analog.Basic.Ground ground1 annotation (
    Placement(visible = true, transformation(origin={-120,-60},    extent = {{-10, 10}, {10, -10}}, rotation=180)));
  Modelica.Blocks.Math.Product Power annotation (Placement(visible=true,
        transformation(
        origin={-360,-76},
        extent={{8,-8},{-8,8}},
        rotation=90)));
  Modelica.Blocks.Interfaces.RealOutput Pdc "DC Power" annotation (Placement(
        transformation(
        extent={{-6,-6},{6,6}},
        rotation=270,
        origin={-360,-92}),iconTransformation(
        extent={{-9,-9},{9,9}},
        rotation=270,
        origin={-245,-11})));
equation
  connect(pin_p, R_eq_dc.p)
    annotation (Line(points={{-350,58},{-350,58},{-350,22},{-348,22}},
                                                  color={0,0,255}));
  connect(R_eq_dc.n, L_eq_dc.p)
    annotation (Line(points={{-328,22},{-320,22}},
                                                 color={0,0,255}));
  connect(voltageSensor.v, Vdc)
    annotation (Line(points={{-349,-10},{-332,-10},{-332,-84},{-310,-84},{-310,
          -110}},                                            color={0,0,127}));
  connect(L_eq_dc.n, Vm_dc.p)
    annotation (Line(points={{-300,22},{-286,22},{-286,2}},
                                                       color={0,0,255}));
  connect(Vm_dc.n, currentSensor.p)
    annotation (Line(points={{-286,-18},{-286,-42},{-300,-42}},
                                                           color={0,0,255}));
  connect(coupling_v_I.p, modulated_I_voltage.p)
    annotation (Line(points={{60,-38},{40,-38},{40,-44}},    color={0,0,255}));
  connect(R_eq_ac_R.n, L_eq_ac_R.p)
    annotation (Line(points={{126,42},{134,42}}, color={0,0,255}));
  connect(R_eq_ac_I.n, L_eq_ac_I.p)
    annotation (Line(points={{126,-38},{138,-38}}, color={0,0,255}));
  connect(coupling_v_I.n, R_eq_ac_I.p)
    annotation (Line(points={{80,-38},{106,-38}},  color={0,0,255}));
  connect(L_eq_ac_R.n, vg_R.p)
    annotation (Line(points={{154,42},{174,42},{174,48}}, color={0,0,255}));
  connect(L_eq_ac_I.n, vg_I.p)
    annotation (Line(points={{158,-38},{176,-38},{176,-44}}, color={0,0,255}));
  connect(currentSensor1.p, vg_R.n)
    annotation (Line(points={{100,74},{174,74},{174,68}}, color={0,0,255}));
  connect(modulated_R_voltage.n, currentSensor1.n)
    annotation (Line(points={{40,68},{40,74},{80,74}},    color={0,0,255}));
  connect(currentSensor2.p, vg_I.n)
    annotation (Line(points={{100,-70},{176,-70},{176,-64}}, color={0,0,255}));
  connect(currentSensor2.n, modulated_I_voltage.n)
    annotation (Line(points={{80,-70},{40,-70},{40,-64}},    color={0,0,255}));
  connect(pwVoltage.p, p)
    annotation (Line(points={{356,52},{368,52},{368,0},{384,0}},
                                                         color={0,0,255}));
  connect(div0block.u2, voltageSensor1.v) annotation (Line(points={{-247.6,-8.8},
          {-252,-8.8},{-252,-84},{-90,-84},{-90,-8},{-95,-8}},
                      color={0,0,127}));
  connect(div0block.y, product.u1) annotation (Line(points={{-229.2,-4},{-202,
          -4},{-202,-3.2},{-201.6,-3.2}},
                                      color={0,0,127}));
  connect(product.u2, currentSensor.i) annotation (Line(points={{-201.6,-12.8},
          {-226,-12.8},{-226,-64},{-310,-64},{-310,-53}},
                                                color={0,0,127}));
  connect(product.y, signalCurrent.i)
    annotation (Line(points={{-183.2,-8},{-168,-8}},color={0,0,127}));
  connect(modulated_R_voltage.v, div0block1.u1) annotation (Line(points={{28,58},
          {28,58.4},{7.8,58.4}},             color={0,0,127}));
  connect(modulated_I_voltage.v, div0block2.u1) annotation (Line(points={{28,-54},
          {28,-53.6},{5.8,-53.6}},              color={0,0,127}));
  connect(div0block2.u2, voltageSensor1.v) annotation (Line(points={{5.8,-64.4},
          {8,-64.4},{8,-84},{-90,-84},{-90,-8},{-95,-8}},
        color={0,0,127}));
  connect(div0block1.u2, voltageSensor1.v) annotation (Line(points={{7.8,47.6},
          {24,47.6},{24,-84},{-90,-84},{-90,-8},{-95,-8}},
        color={0,0,127}));
  connect(realToComplex1.im, gain1.y) annotation (Line(points={{318,-36},{310,
          -36},{310,-49},{300.5,-49}},
                                  color={0,0,127}));
  connect(IgI,IgI)
    annotation (Line(points={{310,-110},{310,-110}}, color={0,0,127}));
  connect(gain1.u,IgI)  annotation (Line(points={{289,-49},{286,-49},{286,-80},
          {310,-80},{310,-110}},
        color={0,0,127}));
  connect(gain3.u,IgR)  annotation (Line(points={{289,-19},{270,-19},{270,-110}},
        color={0,0,127}));
  connect(div0block1.y, product1.u1) annotation (Line(points={{-12.9,53},{-14,
          53},{-14,16.8},{-16.4,16.8}},      color={0,0,127}));
  connect(product1.u2,IgR)  annotation (Line(points={{-16.4,7.2},{-14,7.2},{-14,
          8},{-10,8},{-10,22},{270,22},{270,-110}}, color={0,0,127}));
  connect(div0block2.y, product2.u2) annotation (Line(points={{-14.9,-59},{
          -14.9,-60},{-16,-60},{-16,-34.8},{-16.4,-34.8}},  color={0,0,
          127}));
  connect(product2.u1,IgI)  annotation (Line(points={{-16.4,-25.2},{2,-25.2},{2,
          -26},{260,-26},{260,-88},{310,-88},{310,-110}},
                                          color={0,0,127}));
  connect(modulated_R_current.i, gain.y)
    annotation (Line(points={{-56,12},{-50.6,12}}, color={0,0,127}));
  connect(product1.y, gain.u)
    annotation (Line(points={{-34.8,12},{-36.8,12}}, color={0,0,127}));
  connect(modulated_I_current.i, gain2.y)
    annotation (Line(points={{-56,-30},{-50.6,-30}}, color={0,0,127}));
  connect(product2.y, gain2.u)
    annotation (Line(points={{-34.8,-30},{-36.8,-30}}, color={0,0,127}));
  connect(IgR,IgR)
    annotation (Line(points={{270,-110},{270,-110}}, color={0,0,127}));
  connect(pwVoltage.vr, gain5.u)
    annotation (Line(points={{335,58},{233.2,58}}, color={0,0,127}));
  connect(pwVoltage.vi, gain4.u) annotation (Line(points={{335,52},{252,52},{
          252,-54},{235.2,-54}},
                             color={0,0,127}));
  connect(gain5.y, vg_R.v)
    annotation (Line(points={{219.4,58},{186,58}}, color={0,0,127}));
  connect(vg_I.v, gain4.y)
    annotation (Line(points={{188,-54},{221.4,-54}}, color={0,0,127}));
  connect(currentSensor1.p, ground2.p)
    annotation (Line(points={{100,74},{142,74}}, color={0,0,255}));
  connect(currentSensor2.p, ground3.p)
    annotation (Line(points={{100,-70},{154,-70}}, color={0,0,255}));
  connect(currentSensor1.i,IgR)  annotation (Line(points={{90,85},{90,94},{270,
          94},{270,-110}}, color={0,0,127}));
  connect(currentSensor2.i,IgI)  annotation (Line(points={{90,-81},{90,-88},{
          310,-88},{310,-110}},
                            color={0,0,127}));
  connect(wL.y, product3.u2) annotation (Line(points={{117.2,2},{110,2},{110,
          8.4},{97.2,8.4}},
                        color={0,0,127}));
  connect(product4.u1, wL.y) annotation (Line(points={{97.2,-4.4},{110,-4.4},{
          110,2},{117.2,2}},
                         color={0,0,127}));
  connect(coupling_v_R.v, product3.y)
    annotation (Line(points={{70,30},{70,12},{83.4,12}},    color={0,0,127}));
  connect(product4.y, coupling_v_I.v) annotation (Line(points={{83.4,-8},{70,-8},
          {70,-26}},       color={0,0,127}));
  connect(signalCurrent.n, modulated_R_current.p)
    annotation (Line(points={{-156,2},{-156,22},{-68,22}},
                                                         color={0,0,255}));
  connect(signalCurrent.p, modulated_I_current.n)
    annotation (Line(points={{-156,-18},{-156,-40},{-68,-40}},
                                                             color={0,0,255}));
  connect(C_eq.n, modulated_I_current.n)
    annotation (Line(points={{-134,-18},{-134,-40},{-68,-40}},
                                                             color={0,0,255}));
  connect(C_eq.p, modulated_R_current.p)
    annotation (Line(points={{-134,2},{-134,22},{-68,22}},
                                                         color={0,0,255}));
  connect(voltageSensor1.p, modulated_R_current.p)
    annotation (Line(points={{-106,2},{-106,22},{-68,22}},
                                                         color={0,0,255}));
  connect(voltageSensor1.n, modulated_I_current.n)
    annotation (Line(points={{-106,-18},{-106,-40},{-68,-40}},
                                                             color={0,0,255}));
  connect(modulated_R_current.n, modulated_I_current.n) annotation (Line(points={{-68,2},
          {-86,2},{-86,-40},{-68,-40}},         color={0,0,255}));
  connect(modulated_I_current.p, modulated_R_current.p) annotation (Line(points={{-68,-20},
          {-82,-20},{-82,22},{-68,22}},           color={0,0,255}));
  connect(VmR, div0block1.u1) annotation (Line(points={{-1,-105},{-1,-90},{14,
          -90},{14,58.4},{7.8,58.4}},         color={0,0,127}));
  connect(VmI, div0block2.u1) annotation (Line(points={{31,-105},{31,-90},{18,
          -90},{18,-53.6},{5.8,-53.6}},         color={0,0,127}));
  connect(realToComplex1.y, currentPhasor.i) annotation (Line(points={{341,-30},
          {352,-30},{352,-44.6}},          color={85,170,255}));
  connect(p, currentPhasor.n) annotation (Line(points={{384,0},{368,0},{368,
          -52.2},{361.8,-52.2}},     color={0,0,255}));
  connect(currentPhasor.p, groundPhasor.p) annotation (Line(points={{342.2,-52},
          {336,-52},{336,-66.2}},            color={0,0,255}));
  connect(Vc_eq, voltageSensor1.v) annotation (Line(points={{-70,-110},{-70,-84},
          {-90,-84},{-90,-8},{-95,-8}},            color={0,0,127}));
  connect(ground1.p, modulated_I_current.n) annotation (Line(points={{-120,-50},
          {-120,-40},{-68,-40}},     color={0,0,255}));
  connect(voltageSensor.p, R_eq_dc.p) annotation (Line(points={{-360,0},{-360,
          22},{-348,22}},    color={0,0,255}));
  connect(pin_n, currentSensor.n) annotation (Line(points={{-350,-50},{-336,-50},
          {-336,-42},{-320,-42}},        color={0,0,255}));
  connect(voltageSensor.n, currentSensor.n) annotation (Line(points={{-360,-20},
          {-360,-42},{-320,-42}},                        color={0,0,255}));
  connect(modulated_R_voltage.p, coupling_v_R.n)
    annotation (Line(points={{40,48},{40,42},{60,42}},    color={0,0,255}));
  connect(coupling_v_R.p, R_eq_ac_R.p)
    annotation (Line(points={{80,42},{106,42}},  color={0,0,255}));
  connect(product4.u2,IgR)  annotation (Line(points={{97.2,-11.6},{158,-11.6},{
          158,22},{270,22},{270,-110}}, color={0,0,127}));
  connect(VgR, gain5.y) annotation (Line(points={{190,-110},{190,-94},{204,-94},
          {204,58},{219.4,58}},
        color={0,0,127}));
  connect(VgI, gain4.y) annotation (Line(points={{230,-110},{230,-94},{214,-94},
          {214,-54},{221.4,-54}},           color={0,0,127}));
  connect(Power.u1, voltageSensor.v) annotation (Line(points={{-364.8,-66.4},{
          -364.8,-60},{-332,-60},{-332,-10},{-349,-10}},
                                                     color={0,0,127}));
  connect(Power.u2, currentSensor.i) annotation (Line(points={{-355.2,-66.4},{
          -355.2,-64},{-310,-64},{-310,-53}},
                                           color={0,0,127}));
  connect(Power.y, Pdc)
    annotation (Line(points={{-360,-84.8},{-360,-92}},
                                                     color={0,0,127}));
  connect(Idc, currentSensor.i) annotation (Line(points={{-270,-110},{-270,-64},
          {-310,-64},{-310,-53}}, color={0,0,127}));
  connect(product3.u1, IgI) annotation (Line(points={{97.2,15.6},{97.2,16},{166,
          16},{166,-26},{260,-26},{260,-88},{310,-88},{310,-110}}, color={0,0,
          127}));
  connect(gain3.y, realToComplex1.re) annotation (Line(points={{300.5,-19},{310,
          -19},{310,-24},{318,-24}}, color={0,0,127}));
  connect(V_m_dc, div0block.u1) annotation (Line(points={{-261,-109},{-261,0.8},
          {-247.6,0.8}}, color={0,0,127}));
  connect(Vm_dc.v, V_m_dc) annotation (Line(points={{-274,-8},{-261,-8},{-261,
          -109}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(                           extent={{-340,-100},
            {340,100}},
        preserveAspectRatio=false,
        grid={2,2}),           graphics={
                                                                                                                                                                                                                Text(origin={268.5,
              -85.5},                                                                                                                                                                             extent={{-10.5,
              -6.5},{10.5,6.5}},
          rotation=180,
          textString="IgR",
          textColor={0,0,0}),
                                                                                                                                                                                                        Text(origin={-311,-89},extent={{-11,-7},
              {11,7}},
          rotation=180,
          textString="Vdc",
          textColor={0,0,0}),
                                                                                                                                                                                                        Text(origin={310,-87}, extent={{-8,-7},
              {8,7}},
          rotation=180,
          textString="IgI",
          textColor={0,0,0}),
                                                                                                                                                                                                        Rectangle(origin={333,5},
                                                                                                                                                                                                  lineColor = {0, 0, 255}, fillColor = {0, 0, 255},
            fillPattern =                                                                                                                                                                                                        FillPattern.Solid, extent = {{-1, 59}, {1, -59}}),
                                                                                                                                                                                                        Rectangle(origin={-68.725,
              17.2},                                                                                                                                                                                                        lineColor={0,0,0},
            lineThickness=0.5,                                                                                                                                                                                                        extent={{
              -109.275,52.8},{246.725,-79.2}},
          pattern=LinePattern.Dash),
                                                                                                                                                                                                                Line(origin={86,-22},
                                                                                                                                                                                                  points={{0,10},{
              0,-20}},                                                                                                                                                                                                        thickness = 0.5),
                                                                                                                                                                                                        Line(origin={-73.203,
              -23.6904},                                                                                                                                                                                                        points={{-0.797,
              11.6904},{-0.797,-18.3096}},                                                                                                                                                                                                        thickness = 0.5),
                                                                                                                                                                                                        Line(origin={-113.649,
              40.1905},                                                                                                                                                                                                        points={{-0.351,
              17.8095},{-0.351,-20.1905}},                                                                                                                                                                                                        thickness = 0.5),
                                                                                                                                                                                                        Text(origin={-149,-5}, extent = {{-29, 9}, {21, -3}},
          textString="Vmdc",
          textColor={0,0,0}),
                                                                                                                                                                                                        Line(origin={4.608,
              0.2404},                                                                                                                                                                                                        points = {{-13, 0}, {13, 0}}, thickness = 0.5),
                                                                                                                                                                                                        Line(origin={4.608,
              0.2404},                                                                                                                                                                                                        points = {{-13, 0}, {13, 0}}, thickness = 0.5),
                                                                                                                                                                                                        Line(origin={4.608,
              10.1904},                                                                                                                                                                                                        points = {{-13, 0}, {13, 0}}, thickness = 0.5),
                                                                                                                                                                                                        Line(origin={4.608,
              10.1904},                                                                                                                                                                                                        points = {{-13, 0}, {13, 0}}, thickness = 0.5),
                                                                                                                                                                                                        Line(origin={5.218,
              1.6143},                                                                                                                                                                                                        points={{0.782,
              46.3857},{0.782,8.3857}},                                                                                                                                                                                                        thickness = 0.5),
                                                                                                                                                                                                        Line(origin={4.608,
              0.2404},                                                                                                                                                                                                        points = {{-13, 0}, {13, 0}}, thickness = 0.5),
                                                                                                                                                                                                        Line(origin={4.608,
              0.2404},                                                                                                                                                                                                        points = {{-13, 0}, {13, 0}}, thickness = 0.5),
                                                                                                                                                                                                        Line(origin={5.218,
              -28.3859},                                                                                                                                                                                                        points={{0.782,
              28.3859},{0.782,-13.6141}},                                                                                                                                                                                                        thickness = 0.5),
                                                                                                                                                                                                        Text(origin={159,-3},
                                                                                                                                                                                                  extent = {{-29, 9}, {21, -3}},
          textColor={0,0,0},
          textString="Vmac"),
                                                                                                                                                                                                        Text(origin={33,-5},
                                                                                                                                                                                                  extent = {{-29, 9}, {21, -3}}, textString = "Ceq"),
                                                                                                                                                                                                        Text(origin={-21,1},
                                                                                                                                                                                                  extent = {{-29, 9}, {11, -3}}, textString = "Vceq"),
                                                                                                                                                                                                        Line(origin={47.254,
              48.5502},                                                                                                                                                                                                        points={{
              -121.254,-0.5502},{38.746,-0.5502}},                                                                                                                                                                                                        thickness = 0.5),
                                                                                                                                                                                                        Line(origin={47.466,
              -42.2198},                                                                                                                                                                                                        points={{
              -121.466,0.2198},{38.534,0.2198}},                                                                                                                                                                                                        thickness = 0.5),
                                                                                                                                                                                                        Line(origin={-74.328,
              6.322},                                                                                                                                                                                                        points={{0.328,
              41.678},{0.328,13.678}},                                                                                                                                                                                                        thickness = 0.5),
                                                                                                                                                                                                        Line(origin={121.737,
              -26.3322},                                                                                                                                                                                                        points={{0.263,
              14.3322},{0.263,-55.6678}},                                                                                                                                                                                                        thickness = 0.5),
                                                                                                                                                                                                        Line(origin={84.726,
              6.322},                                                                                                                                                                                                        points={{1.274,
              41.678},{1.274,13.678}},                                                                                                                                                                                                        thickness = 0.5),
                                                                                                                                                                                                        Line(origin={-113.921,
              -34.4766},                                                                                                                                                                                                        points={{-0.079,
              22.4766},{-0.079,-15.5234}},                                                                                                                                                                                                        thickness = 0.5),
                                                                                                                                                                                                        Text(origin={-114,14},extent = {{0, 2}, {0, -10}}, textString = "+"),
                                                                                                                                                                                                        Text(origin={122,16},
                                                                                                                                                                                                  extent = {{0, 2}, {0, -10}}, textString = "+"),
                                                                                                                                                                                                        Text(origin={-114,2}, extent = {{0, 2}, {0, -10}}, textString = "-"),
                                                                                                                                                                                                        Text(origin={122,4},
                                                                                                                                                                                                  extent = {{0, 2}, {0, -10}}, textString = "-"),
                                                                                                                                                                                                        Line(origin={-72.808,
              12.0541},                                                                                                                                                                                                        points={{-1.192,
              -16.0541},{-1.192,-0.0541}},                                                                                                                                                                                                        arrow = {Arrow.None, Arrow.Filled},
          thickness=0.5),
                                                                                                                                                                                                        Line(origin={85.192,
              -3.9459},                                                                                                                                                                                                        points={{-1.192,
              -16.0541},{-1.192,-0.0541}},                                                                                                                                                                                                        arrow = {Arrow.None, Arrow.Filled},
          thickness=0.5,
          rotation=180),
                                                                                                                                                                                                        Line(origin={-180.746,
              -49.4498},                                                                                                                                                                                                        points={{
              -155.254,-0.5502},{66.746,-0.5502}},                                                                                                                                                                                                        thickness = 0.5),
                                                                                                                                                                                                        Line(origin={265.254,
              -81.4498},                                                                                                                                                                                                        points={{
              -155.254,-0.5502},{-133.254,-0.5502}},                                                                                                                                                                                                        thickness = 0.5),
                                                                                                                                                                                                        Rectangle(origin={-254,
              59.3333},
            lineThickness =                                                                                                                                                                                                        0.5, extent={{-12,
              2.66668},{34,-5.33335}}),
                                                                                                                                                                                                        Line(origin={-214.746,
              58.5502},                                                                                                                                                                                                        points={{
              -121.254,-0.5502},{-51.254,-0.5502}},                                                                                                                                                                                                        thickness = 0.5),
                                                                                                                                                                                                        Line(origin={-98.746,
              58.5502},                                                                                                                                                                                                        points={{
              -121.254,-0.5502},{-15.254,-0.5502}},                                                                                                                                                                                                        thickness = 0.5),
                                                                                                                                                                                                        Rectangle(origin={236,
              59.3333},
            lineThickness =                                                                                                                                                                                                        0.5, extent={{-12,
              2.66668},{34,-5.33335}}),
                                                                                                                                                                                                        Line(origin={132.523,
              38},                                                                                                                                                                                                        points={{-10.523,
              -18},{-10.523,20},{11.477,20},{91.477,20}},                                                                                                                                                                                                        thickness = 0.5),
                                                                                                                                                                                                        Line(origin={287.254,
              32.5502},                                                                                                                                                                                                        points={{-17.254,
              25.4498},{44.746,25.4498}},                                                                                                                                                                                                        thickness = 0.5),
                                                                                                                                                                                                        Line(origin={-300.808,
              28.0541},                                                                                                                                                                                                        points={{-1.192,
              -62.0541},{-1.192,9.9459}},                                                                                                                                                                                                        arrow = {Arrow.None, Arrow.Filled},
          thickness=0.5),
                                                                                                                                                                                                        Text(origin={-316.68,
              -1.5},                                                                                                                                                                                                       extent={{-31.32,
              13.5},{22.68,-4.5}},
          textColor={0,0,0},
          textString="Vdc"),
        Polygon(
          points={{-114,20},{-124,4},{-114,-12},{-104,4},{-114,20}},
          lineColor={0,0,0},
          lineThickness=0.5),
        Polygon(
          points={{-74,20},{-84,4},{-74,-12},{-64,4},{-74,20}},
          lineColor={0,0,0},
          lineThickness=0.5),
        Polygon(
          points={{86,20},{76,4},{86,-12},{96,4},{86,20}},
          lineColor={0,0,0},
          lineThickness=0.5),
        Polygon(
          points={{122,20},{112,4},{122,-12},{132,4},{122,20}},
          lineColor={0,0,0},
          lineThickness=0.5),
                                                                                                                                                                                                        Line(origin={-136.808,
              26.0541},                                                                                                                                                                                                        points={{-1.192,
              -62.0541},{-1.192,9.9459}},                                                                                                                                                                                                        arrow = {Arrow.None, Arrow.Filled},
          thickness=0.5),
                                                                                                                                                                                                        Line(origin={-12.808,
              26.0541},                                                                                                                                                                                                        points={{-1.192,
              -52.0541},{-1.192,9.9459}},                                                                                                                                                                                                        arrow = {Arrow.None, Arrow.Filled},
          thickness=0.5),
                                                                                                                                                                                                        Line(origin={141.192,
              24.0541},                                                                                                                                                                                                        points={{-1.192,
              -62.0541},{-1.192,9.9459}},                                                                                                                                                                                                        arrow = {Arrow.None, Arrow.Filled},
          thickness=0.5),
                                                                                                                                                                                                        Line(origin={313.192,
              22.0541},                                                                                                                                                                                                        points={{-1.192,
              -62.0541},{-1.192,9.9459}},                                                                                                                                                                                                        arrow = {Arrow.None, Arrow.Filled},
          thickness=0.5),
                                                                                                                                                                                                        Text(origin={297.32,
              -7.5},                                                                                                                                                                                                        extent={{-31.32,
              13.5},{22.68,-4.5}},
          textColor={0,0,0},
          textString="Vg"),
                                                                                                                                                                                                        Line(origin={273.192,
              70.0541},                                                                                                                                                                                                        points={{-1.192,
              -62.0541},{-1.192,9.9459}},                                                                                                                                                                                                        arrow = {Arrow.None, Arrow.Filled},
          thickness=0.5,
          rotation=270),
                                                                                                                                                                                                        Text(origin={253.32,
              78.5},                                                                                                                                                                                                        extent={{-31.32,
              13.5},{22.68,-4.5}},
          textColor={0,0,0},
          textString="ig"),
                                                                                                                                                                                                        Text(origin={-240.68,
              -59.5},                                                                                                                                                                                                        extent={{-31.32,
              13.5},{22.68,-4.5}},
          textColor={0,0,0},
          rotation=180,
          textString="idc"),
                                                                                                                                                                                                        Line(origin={-260.808,
              -53.9459},                                                                                                                                                                                                        points={{-1.192,
              -62.0541},{-1.192,9.9459}},                                                                                                                                                                                                        arrow = {Arrow.None, Arrow.Filled},
          thickness=0.5,
          rotation=90),
                                                                                                                                                                                                        Text(origin={-237,41},
                                                                                                                                                                                                        extent = {{-29, 9}, {21, -3}},
          textString="Zdc_eq",
          textColor={0,0,0}),
                                                                                                                                                                                                        Text(origin={253,41},
                                                                                                                                                                                                  extent = {{-29, 9}, {21, -3}},
          textColor={0,0,0},
          textString="Zac_eq"),
                                                                                                                                                                                                        Text(origin={-269,-89},extent={{-11,-7},
              {11,7}},
          rotation=180,
          textColor={0,0,0},
          textString="Idc"),
                                                                                                                                                                                                        Text(origin={-147.5,
              -92.5},                                                                                                                                                                                                        extent={{-16.5,
              -11.5},{16.5,11.5}},
          rotation=180,
          textColor={0,0,0},
          textString="Vmdc"),
                                                                                                                                                                                                        Text(origin={-71,-91}, extent={{-13,-7},
              {13,7}},
          rotation=180,
          textColor={0,0,0},
          textString="Vceq"),
                                                                                                                                                                                                        Text(origin={7.5,
              -91.5},                                                                                                                                                                                                        extent={{-13.5,
              -8.5},{13.5,8.5}},
          rotation=180,
          textColor={0,0,0},
          textString="VmR"),
                                                                                                                                                                                                        Text(origin={69.5,
              -91.5},                                                                                                                                                                                                        extent={{-13.5,
              -6.5},{13.5,6.5}},
          rotation=180,
          textColor={0,0,0},
          textString="VmI"),
                                                                                                                                                                                                        Text(origin={189,-87},
                                                                                                                                                                                                        extent={{-11,-7},
              {11,7}},
          rotation=180,
          textColor={0,0,0},
          textString="VgR"),
                                                                                                                                                                                                        Text(origin={230.5,
              -87.5},                                                                                                                                                                                                        extent={{-10.5,
              -6.5},{10.5,6.5}},
          rotation=180,
          textColor={0,0,0},
          textString="VgI"),
        Rectangle(
          extent={{-340,100},{340,-100}},
          lineColor={0,0,0},
          lineThickness=0.5)}), Diagram(coordinateSystem(preserveAspectRatio=false,
                   extent={{-380,-100},{380,100}},
        grid={2,2})),
    Documentation(info="<html>
<p>The AvgMMCmodel is the average model of a Modular Multilevel Converter. This model is suitable for large AC grid dynamic studies where the simulations under phasor approximation is required.</p>
</html>"));
end AvgMMCmodel;
