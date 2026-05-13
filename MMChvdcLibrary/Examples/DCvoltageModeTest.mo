within MMChvdcLibrary.Examples;
model DCvoltageModeTest
  "Tests the DC Voltage control of the MMC HVDC by using the 'DCvoltageModeMMCstation'."
  extends Modelica.Icons.Example;
  OpenIPSL.Electrical.Buses.InfiniteBus infiniteBus(
    P_0=0,
    Q_0=0,
    S_b=1000000000,
    v_0(displayUnit="1") = 1,
    V_b=320000,
    fn=50,
    angle_0(displayUnit="deg") = 0.5235987755983,
    displayPF=true)                                annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={90,34})));
  inner OpenIPSL.Electrical.SystemBase SysData(S_b=1000000000,
                                                         fn=50)
    annotation (Placement(transformation(extent={{32,78},{98,98}})));
  Modelica.Blocks.Sources.Step Vdc_ref(
    height=0.5,
    offset=1,
    startTime(displayUnit="s") = 1) "Reference DC voltage"
    annotation (Placement(transformation(extent={{-40,-40},{-20,-20}})));
  Modelica.Electrical.Analog.Basic.Ground ground
    annotation (Placement(transformation(extent={{-60,-14},{-40,6}})));
  ComponentLibrary.BasicBlocks.Sensor.ACpowerSensor                     pQ_Sensor(S_b=
        SysData.S_b)
    annotation (Placement(transformation(extent={{30,30},{44,38}})));
  MMC_HVDCstation.MasterHVDCstation mMC_voltage_Mode(
    Vdc_Pac_flag=false,
    Rr=0.001,
    Xr=0.18,
    L_arm=0.078,
    R_arm=0.00758,
    C_dc=195E-6,
    C_sub=10e-3,
    N_sub=200,
    S_b=1000,
    MVAb=1000,
    fb=50,
    Vb=320,
    Vdcb=640,
    V_0=1,
    angle_0=0.5235987755983,
    P_0=0.498303,
    Q_0=0.2,
    Vdc_0=1,
    Wmmc_0=1) annotation (Placement(transformation(extent={{-20,0},{20,48}})));
  Modelica.Electrical.Analog.Basic.Capacitor capacitor(v(start=640E3, fixed=
          true), C=195*1E-6)   annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-50,40})));
  Modelica.Blocks.Sources.Step     Qref(
    height=0.1,
    offset=0.2,
    startTime=1.5) "Reference reactive power"
    annotation (Placement(transformation(extent={{-40,-80},{-20,-60}})));
  OpenIPSL.Electrical.Buses.Bus bus1(
    S_b=1000000000,
    V_b=320000,
    displayPF=true)
    annotation (Placement(transformation(extent={{50,24},{70,44}})));
  Modelica.Electrical.Analog.Sources.SignalCurrent signalCurrent annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-68,40})));
  Modelica.Blocks.Sources.Step CurrentStep(
    height=1*0.1*1.5625e03,
    offset=1*(0.5)*1.5625e+03,
    startTime=1)
    annotation (Placement(transformation(extent={{-116,30},{-96,50}})));
equation
  connect(capacitor.p, mMC_voltage_Mode.pin_p) annotation (Line(points={{-50,50},
          {-50,60},{-32,60},{-32,46},{-20,46}},
                                              color={0,0,255}));
  connect(capacitor.n, mMC_voltage_Mode.pin_n) annotation (Line(points={{-50,30},
          {-50,20},{-32,20},{-32,26},{-20,26}},        color={0,0,255}));
  connect(ground.p, mMC_voltage_Mode.pin_n) annotation (Line(points={{-50,6},{
          -50,20},{-32,20},{-32,26},{-20,26}},    color={0,0,255}));
  connect(pQ_Sensor.n, bus1.p)
    annotation (Line(points={{44,34},{60,34}},
                                             color={0,0,255}));
  connect(bus1.p, infiniteBus.p)
    annotation (Line(points={{60,34},{80,34}},
                                             color={0,0,255}));
  connect(signalCurrent.n, mMC_voltage_Mode.pin_p) annotation (Line(points={{-68,50},
          {-68,60},{-32,60},{-32,46},{-20,46}},      color={0,0,255}));
  connect(signalCurrent.p, mMC_voltage_Mode.pin_n) annotation (Line(points={{-68,30},
          {-68,20},{-32,20},{-32,26},{-20,26}},            color={0,0,255}));
  connect(CurrentStep.y, signalCurrent.i) annotation (Line(points={{-95,40},{
          -80,40}},            color={0,0,127}));
  connect(Qref.y, mMC_voltage_Mode.Qref)
    annotation (Line(points={{-19,-70},{-4,-70},{-4,2}},   color={0,0,127}));
  connect(Vdc_ref.y, mMC_voltage_Mode.Vdc_ref)
    annotation (Line(points={{-19,-30},{-16,-30},{-16,2}}, color={0,0,127}));
  connect(mMC_voltage_Mode.pwPin, pQ_Sensor.p)
    annotation (Line(points={{20,34.2},{20,34},{30,34}}, color={0,0,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, grid={2,2})),
                                                                 Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-120,-100},{100,100}})),
    experiment(
      StopTime=10,
      Interval=0.0001,
      Tolerance=0.001,
      __Dymola_fixedstepsize=1e-05,
      __Dymola_Algorithm="Dassl"));
end DCvoltageModeTest;
