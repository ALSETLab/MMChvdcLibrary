within MMChvdcLibrary.Examples;
model ActivePowerModeTest
  "Tests the Active Power control of the MMC HVDC using the 'ActivePowerModeMMCstation'."
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
  inner OpenIPSL.Electrical.SystemBase SysData(S_b=100000000, fn=60)
    annotation (Placement(transformation(extent={{32,78},{98,98}})));
  Modelica.Blocks.Sources.Step Pref(
    height=0.1,
    offset=0.2,
    startTime=1.5) "Reference AC Power (pu)"
    annotation (Placement(transformation(extent={{-40,-50},{-20,-30}})));
  Modelica.Blocks.Sources.Constant Qref(k=0.01)
                                             "Reference AC Reactive Power (pu)"
    annotation (Placement(transformation(extent={{-40,-80},{-20,-60}})));
  Modelica.Electrical.Analog.Sources.ConstantVoltage constantVoltage(V=640E3)   annotation (
    Placement(visible = true, transformation(origin={-60,40},    extent={{-12,-12},
            {12,12}},                                                                             rotation = -90)));
  Modelica.Electrical.Analog.Basic.Ground ground
    annotation (Placement(transformation(extent={{-50,-8},{-30,12}})));
  OpenIPSL.Electrical.Buses.Bus bus(
    v_0=1,
    angle_0=0.5235987755983,
    displayPF=true)
    annotation (Placement(transformation(extent={{50,24},{70,44}})));
  MMC_HVDC_BlackStart.ComponentLibrary.BasicBlocks.Sensor.ACpowerSensor pQ_Sensor
    annotation (Placement(transformation(extent={{28,30},{42,38}})));
  MMC_HVDCstation.MasterHVDCstationWithoutBlocking              mMC_Power_Mode02(
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
    angle_0=0.5235987755983,
    P_0=0.2,
    Q_0=0.01,
    Vdc_0=1,
    Wmmc_0=1) annotation (Placement(transformation(extent={{-20,0},{20,48}})));
equation
  connect(constantVoltage.n, ground.p) annotation (Line(points={{-60,28},{-60,
          20},{-40,20},{-40,12}},     color={0,0,255}));
  connect(pQ_Sensor.n, bus.p)
    annotation (Line(points={{42,34},{60,34}},
                                             color={0,0,255}));
  connect(bus.p, infiniteBus.p)
    annotation (Line(points={{60,34},{80,34}},
                                             color={0,0,255}));
  connect(Pref.y, mMC_Power_Mode02.Pref) annotation (Line(points={{-19,-40},{
          -10,-40},{-10,2}},               color={0,0,127}));
  connect(Qref.y, mMC_Power_Mode02.Qref) annotation (Line(points={{-19,-70},{-4,
          -70},{-4,2}},                    color={0,0,127}));
  connect(mMC_Power_Mode02.pin_n, ground.p) annotation (Line(points={{-20,26},{
          -28,26},{-28,20},{-40,20},{-40,12}},  color={0,0,255}));
  connect(constantVoltage.p, mMC_Power_Mode02.pin_p) annotation (Line(points={{
          -60,52},{-60,60},{-28,60},{-28,46},{-20,46}}, color={0,0,255}));
  connect(mMC_Power_Mode02.pwPin, pQ_Sensor.p)
    annotation (Line(points={{20,34.2},{20,34},{28,34}}, color={0,0,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, grid={2,2})),
                                                                 Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-120,-100},{100,100}})),
    experiment(
      StopTime=10,
      Interval=0.0001,
      __Dymola_fixedstepsize=0.001,
      __Dymola_Algorithm="Dassl"));
end ActivePowerModeTest;
