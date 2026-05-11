within MMC_HVDC_AMCONF2026.ComponentLibrary.BasicBlocks.PLL;
model TestSynchronization "Tests synchronization block"
  extends Modelica.Icons.Example;
  Synchronization synchronization02_1(
    fb=50,
    k_filt=10,
    T_filt=0.001,
    initType_filt=Modelica.Blocks.Types.Init.InitialOutput,
    y_start_filt=10,
    k_pi=(2*0.707)/(2*Modelica.Constants.pi*50*0.0005),
    T_pi=0.0005,
    initType_pi=Modelica.Blocks.Types.Init.InitialOutput,
    x_start_pi=0,
    y_start_pi=0,
    k_i=1,
    initType_i=Modelica.Blocks.Types.Init.InitialOutput,
    y_start_i=10)
    annotation (Placement(transformation(extent={{-18,-24},{36,24}})));
  Modelica.Blocks.Sources.Constant const2(k=0.5236)
    annotation (Placement(transformation(extent={{-20,40},{0,60}})));
  Modelica.Blocks.Sources.Constant const(k=50)
    annotation (Placement(transformation(extent={{-60,-40},{-40,-20}})));
  Modelica.Blocks.Sources.Step     step(
    height=0.1,
    offset=1.0,
    startTime=1)
    annotation (Placement(transformation(extent={{-60,20},{-40,40}})));
equation
  connect(const2.y, synchronization02_1.theta_ref)
    annotation (Line(points={{1,50},{9,50},{9,28.8}},   color={0,0,127}));
  connect(synchronization02_1.f_ref, const.y) annotation (Line(points={{-23.4,
          -14.4},{-36,-14.4},{-36,-30},{-39,-30}}, color={0,0,127}));
  connect(synchronization02_1.Vq, step.y) annotation (Line(points={{-23.4,14.4},
          {-36,14.4},{-36,30},{-39,30}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=5,
      Interval=0.0001,
      __Dymola_Algorithm="Dassl"));
end TestSynchronization;
