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
    annotation (Placement(transformation(extent={{-56,-16},{-48,-8}})));
  OpenIPSL.Electrical.Buses.Bus bus1(
    v_0=1,
    angle_0=0,
    displayPF=true)
    annotation (Placement(transformation(extent={{34,24},{54,44}})));
  MMC_HVDC_BlackStart.ComponentLibrary.BasicBlocks.Sensor.ACpowerSensor pQ_Sensor
    annotation (Placement(transformation(extent={{26,30},{38,38}})));
  MMC_HVDCstation.MasterHVDCstationWithoutBlocking      mMC_CompactControlBLock_withblocking(
    Vdc_Pac_flag=true,
    Vac_Qac_flag=false,
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
    Wmmc_0=1) annotation (Placement(transformation(extent={{-20,0},{20,48}})));
  Modelica.Blocks.Sources.Constant theta_ref(k=30) "Reference angle (degree)"
    annotation (Placement(transformation(extent={{-56,-52},{-48,-44}})));
  Modelica.Blocks.Sources.Ramp     VacRef(
    height=1,
    duration=1,
    offset=0,
    startTime=1) "Reference AC voltage magnitude (pu)"
    annotation (Placement(transformation(extent={{-56,-34},{-48,-26}})));
  Modelica.Blocks.Sources.Constant f_ref(k=50) "Reference frequency (Hz)"
    annotation (Placement(transformation(extent={{-56,-72},{-48,-64}})));
  Modelica.Electrical.Analog.Basic.Ground ground1
    annotation (Placement(transformation(extent={{-70,-6},{-50,14}})));
  Modelica.Electrical.Analog.Sources.ConstantVoltage
                                                   constantVoltage(V(
        displayUnit="kV") = 640000)                              annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-80,40})));
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
equation
  connect(pQ_Sensor.n, bus1.p)
    annotation (Line(points={{38,34},{44,34}}, color={0,0,255}));
  connect(Pref.y, mMC_CompactControlBLock_withblocking.Pref)
    annotation (Line(points={{-47.6,-12},{-10,-12},{-10,2}}, color={0,0,127}));
  connect(mMC_CompactControlBLock_withblocking.pwPin, pQ_Sensor.p) annotation (
      Line(points={{20,34.2},{20,34},{26,34}},             color={0,0,255}));
  connect(VacRef.y, mMC_CompactControlBLock_withblocking.Vac_ref)
    annotation (Line(points={{-47.6,-30},{4,-30},{4,2}},     color={0,0,127}));
  connect(theta_ref.y, mMC_CompactControlBLock_withblocking.theta_ref)
    annotation (Line(points={{-47.6,-48},{10,-48},{10,2}},   color={0,0,127}));
  connect(f_ref.y, mMC_CompactControlBLock_withblocking.f_ref)
    annotation (Line(points={{-47.6,-68},{16,-68},{16,2}},
                                                         color={0,0,127}));
  connect(pwLine1.n,bus2. p)
    annotation (Line(points={{66,-15},{66,-36}},color={0,0,255}));
  connect(constantVoltage.n, mMC_CompactControlBLock_withblocking.pin_n)
    annotation (Line(points={{-80,30},{-80,20},{-40,20},{-40,26},{-20,26}},
                                                 color={0,0,255}));
  connect(ground1.p, mMC_CompactControlBLock_withblocking.pin_n)
    annotation (Line(points={{-60,14},{-60,20},{-40,20},{-40,26},{-20,26}},
                                                          color={0,0,255}));
  connect(constantVoltage.p, mMC_CompactControlBLock_withblocking.pin_p)
    annotation (Line(points={{-80,50},{-80,54},{-40,54},{-40,46},{-20,46}},
                                                 color={0,0,255}));
  connect(bus1.p, pwLine1.p)
    annotation (Line(points={{44,34},{66,34},{66,3}}, color={0,0,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, grid={2,2})),
                                                                 Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-120,-100},{100,100}})),
    experiment(
      StopTime=10,
      Interval=0.0001,
      __Dymola_fixedstepsize=0.001,
      __Dymola_Algorithm="Dassl"));
end VacModeTestInMasterHVDCstation;
