within MMC_HVDC_AMCONF2026.Examples;
model VacModeTestInMasterHVDCstation
  "Tests the AC voltage mode (Vac control) in the 'MasterHVDCstation'."
  extends Modelica.Icons.Example;
  inner OpenIPSL.Electrical.SystemBase SysData(S_b=1000000000, fn=50)
    annotation (Placement(transformation(extent={{32,70},{98,90}})));
  Modelica.Blocks.Sources.Step Pref(
    height=0.1,
    offset=0.2,
    startTime=1.5) "Reference active power (pu)"
    annotation (Placement(transformation(extent={{-56,-26},{-48,-18}})));
  OpenIPSL.Electrical.Buses.Bus bus1(
    v_0=1,
    angle_0=0,
    displayPF=true)
    annotation (Placement(transformation(extent={{34,26},{54,46}})));
  MMC_HVDC_BlackStart.ComponentLibrary.BasicBlocks.Sensor.ACpowerSensor pQ_Sensor
    annotation (Placement(transformation(extent={{18,32},{30,40}})));
  MMC_HVDC_BlackStart.MMC_HVDCstation.MasterHVDCstation mMC_CompactControlBLock_withblocking(
    Rr=0.001,
    Xr=0.18,
    L_arm=0.0758,
    R_arm=0.00758,
    C_sub=10e-3,
    N_sub=200,
    S_b=1000,
    MVAb=1000,
    fb=50,
    Vb=320,
    Vdcb=640,
    V_0=1,
    angle_0=0,
    P_0=0,
    Q_0=0,
    Vdc_0=1,
    Wmmc_0=1) annotation (Placement(transformation(extent={{-28,6},{12,54}})));
  Modelica.Blocks.Sources.Constant VdcRef(k=1) "Reference DC voltage (pu)"
    annotation (Placement(transformation(extent={{-56,-12},{-48,-4}})));
  Modelica.Blocks.Sources.Constant Qref(k=0.1) "Reference Reactive Power (pu)"
    annotation (Placement(transformation(extent={{-56,-40},{-48,-32}})));
  Modelica.Blocks.Sources.Constant theta_ref(k=30) "Reference angle (degree)"
    annotation (Placement(transformation(extent={{-56,-72},{-48,-64}})));
  Modelica.Blocks.Sources.Ramp     VacRef(
    height=1,
    duration=1,
    offset=0,
    startTime=1) "Reference AC voltage magnitude (pu)"
    annotation (Placement(transformation(extent={{-56,-56},{-48,-48}})));
  Modelica.Blocks.Sources.Constant f_ref(k=50) "Reference frequency (Hz)"
    annotation (Placement(transformation(extent={{-56,-88},{-48,-80}})));
  Modelica.Electrical.Analog.Basic.Ground ground1
    annotation (Placement(transformation(extent={{-80,-4},{-60,16}})));
  Modelica.Electrical.Analog.Sources.ConstantVoltage
                                                   constantVoltage(V(
        displayUnit="kV") = 640000)                              annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-80,38})));
  OpenIPSL.Electrical.Branches.PwLine pwLine1(
    R=0.0418,
    X=0.2368,
    G=0,
    B=0.0000895,
    opening=3,
    displayPF=true)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=270,
        origin={66,-6})));
  OpenIPSL.Electrical.Buses.Bus bus2(
    v_0=0,
    angle_0=0,
    displayPF=true)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={66,-36})));
  Modelica.Blocks.Sources.BooleanConstant booleanConstant2
    "True- Voltage source; False- Current source" annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-70,80})));
  Modelica.Blocks.Logical.Not not1 annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=270,
        origin={-8,70})));
equation
  connect(pQ_Sensor.n, bus1.p)
    annotation (Line(points={{30,36},{44,36}}, color={0,0,255}));
  connect(Pref.y, mMC_CompactControlBLock_withblocking.Pref)
    annotation (Line(points={{-47.6,-22},{-18,-22},{-18,8}}, color={0,0,127}));
  connect(mMC_CompactControlBLock_withblocking.pwPin, pQ_Sensor.p) annotation (
      Line(points={{12,40},{14,40},{14,36},{18,36}},       color={0,0,255}));
  connect(VacRef.y, mMC_CompactControlBLock_withblocking.Vac_ref)
    annotation (Line(points={{-47.6,-52},{-4,-52},{-4,8}},   color={0,0,127}));
  connect(Qref.y, mMC_CompactControlBLock_withblocking.Qref)
    annotation (Line(points={{-47.6,-36},{-12,-36},{-12,8}}, color={0,0,127}));
  connect(VdcRef.y, mMC_CompactControlBLock_withblocking.Vdc_ref)
    annotation (Line(points={{-47.6,-8},{-24,-8},{-24,8}}, color={0,0,127}));
  connect(theta_ref.y, mMC_CompactControlBLock_withblocking.theta_ref)
    annotation (Line(points={{-47.6,-68},{2,-68},{2,8}},     color={0,0,127}));
  connect(f_ref.y, mMC_CompactControlBLock_withblocking.f_ref)
    annotation (Line(points={{-47.6,-84},{8,-84},{8,8}}, color={0,0,127}));
  connect(pwLine1.n,bus2. p)
    annotation (Line(points={{66,-15},{66,-36}},color={0,0,255}));
  connect(constantVoltage.n, mMC_CompactControlBLock_withblocking.pin_n)
    annotation (Line(points={{-80,28},{-80,22},{-40,22},{-40,32},{-28,32}},
                                                 color={0,0,255}));
  connect(ground1.p, mMC_CompactControlBLock_withblocking.pin_n)
    annotation (Line(points={{-70,16},{-70,22},{-40,22},{-40,32},{-28,32}},
                                                          color={0,0,255}));
  connect(booleanConstant2.y, mMC_CompactControlBLock_withblocking.Vdc_Pac_flag)
    annotation (Line(points={{-59,80},{12,80},{12,60},{0,60},{0,52}},     color
        ={255,0,255}));
  connect(constantVoltage.p, mMC_CompactControlBLock_withblocking.pin_p)
    annotation (Line(points={{-80,48},{-80,52},{-40,52},{-40,52},{-28,52}},
                                                 color={0,0,255}));
  connect(bus1.p, pwLine1.p)
    annotation (Line(points={{44,36},{66,36},{66,3}}, color={0,0,255}));
  connect(mMC_CompactControlBLock_withblocking.Block_Deblock, booleanConstant2.y)
    annotation (Line(points={{-15.8,52},{-16,52},{-16,60},{-28,60},{-28,80},{
          -59,80}},
                color={255,0,255}));
  connect(not1.u, booleanConstant2.y) annotation (Line(points={{-8,77.2},{-8,80},
          {-59,80}},     color={255,0,255}));
  connect(not1.y, mMC_CompactControlBLock_withblocking.Vac_Qac_flag)
    annotation (Line(points={{-8,63.4},{-8,52}},   color={255,0,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, grid={2,2})),
                                                                 Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-120,-100},{100,100}})),
    experiment(
      StopTime=10,
      Interval=0.0001,
      __Dymola_fixedstepsize=0.001,
      __Dymola_Algorithm="Dassl"));
end VacModeTestInMasterHVDCstation;
