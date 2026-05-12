within MMChvdcLibrary.ComponentLibrary.Converter.Tests;
model AvgMMCmodelTest
  "Validate the average MMC model with calculated modulated AC (VmR, VmI) and modulated DC voltage (Vmdc) control inputs."
  extends Modelica.Icons.Example;
  OpenIPSL.Electrical.Buses.InfiniteBus infiniteBus(
    P_0=0,
    Q_0=0,
    S_b=1000000000,
    v_0(displayUnit="1") = 1,
    V_b=320000,
    fn=50,
    angle_0(displayUnit="deg") = 0.5235987755983)  annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={166,14})));
  AvgMMCmodel avgMMCmodel(
    Rr=0.001,
    Xr=0.18,
    L_arm=0.0758,
    R_arm=0.00758,
    C_sub=10E-3,
    N_sub=200,
    S_b=1000,
    MVAb=1000,
    fb=50,
    Vb=320,
    Vdcb=640,
    Vgd=1*320*1000,
    teta_bus(displayUnit="deg") = 0.5235987755983,
    Vdc0=1,
    Wmmc_0=1,
    P_ref=0.2*1000*1E6,
    Q_ref=0*1000*1E6,
    v_ref=1)
    annotation (Placement(transformation(extent={{-130,-26},{96,54}})));
  inner OpenIPSL.Electrical.SystemBase SysData(S_b=1000000000, fn=50)
    annotation (Placement(transformation(extent={{54,78},{120,98}})));
  Modelica.Electrical.Analog.Sources.ConstantVoltage constantVoltage(V=640E3)   annotation (
    Placement(visible = true, transformation(origin={-145,19},   extent={{-11,-11},
            {11,11}},                                                                             rotation = -90)));
  Modelica.Electrical.Analog.Basic.Ground ground
    annotation (Placement(transformation(extent={{-156,-30},{-136,-10}})));
  OpenIPSL.Electrical.Buses.Bus bus(
    v_0=1,
    angle_0=0,
    displayPF=true)
    annotation (Placement(transformation(extent={{100,4},{120,24}})));
  Modelica.Blocks.Sources.Constant VmI(k=99437)
    annotation (Placement(transformation(extent={{-112,-128},{-92,-108}})));
  Modelica.Blocks.Sources.Constant VmR(k=156128)
    annotation (Placement(transformation(extent={{-112,-98},{-92,-78}})));
  BasicBlocks.Sensor.ACpowerSensor pQ_Sensor
    annotation (Placement(transformation(extent={{124,4},{146,24}})));
  Modelica.Blocks.Sources.Constant Vmdc(k=639838)
    annotation (Placement(transformation(extent={{-112,-64},{-92,-44}})));
equation
  connect(constantVoltage.n, ground.p) annotation (Line(points={{-145,8},{
          -146,8},{-146,-10}},        color={0,0,255}));
  connect(VmR.y, avgMMCmodel.VmR) annotation (Line(points={{-91,-88},{-13.6765,
          -88},{-13.6765,-30}},            color={0,0,127}));
  connect(VmI.y, avgMMCmodel.VmI) annotation (Line(points={{-91,-118},{6.26471,
          -118},{6.26471,-30}},             color={0,0,127}));
  connect(avgMMCmodel.p, bus.p)
    annotation (Line(points={{99.3235,14},{110,14}}, color={0,0,255}));
  connect(constantVoltage.n, avgMMCmodel.pin_n) annotation (Line(points={{-145,8},
          {-146,8},{-146,-6},{-133.324,-6}},              color={0,0,
          255}));
  connect(avgMMCmodel.pin_p, constantVoltage.p) annotation (Line(points={{
          -133.324,37.2},{-145,37.2},{-145,30}},
                                              color={0,0,255}));
  connect(bus.p, pQ_Sensor.p)
    annotation (Line(points={{110,14},{124,14}}, color={0,0,255}));
  connect(infiniteBus.p, pQ_Sensor.n)
    annotation (Line(points={{156,14},{146,14}}, color={0,0,255}));
  connect(avgMMCmodel.V_m_dc, Vmdc.y) annotation (Line(points={{-66.8529,-30},{
          -66.8529,-54},{-91,-54}},         color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, grid={2,2})),
                                                                 Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-160,-140},
            {180,100}})),
    experiment(
      StopTime=10,
      Interval=0.0001,
      Tolerance=0.001,
      __Dymola_fixedstepsize=1e-05,
      __Dymola_Algorithm="Dassl"),
    Documentation(info="<html>
<p>To test the average MMC model, the control input modulated dc voltage (Vmdc) is being varied via three step inputs while other two control inputs modulated ac voltage (VmR and VmI) are kept constant.</p>
</html>"));
end AvgMMCmodelTest;
