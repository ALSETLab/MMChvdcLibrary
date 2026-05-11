within MMC_HVDC_AMCONF2026.ComponentLibrary.ControlBlocks.OuterLoopControls.EnergyControl;
model TestConstantRefEnergyControl
  "Tests the constant reference energy controller"
  extends Modelica.Icons.Example;
  ConstantRefEnergyControl constantReferenceBLock(
    k=1,
    T=5,
    initType=Modelica.Blocks.Types.Init.NoInit)
    annotation (Placement(transformation(extent={{0,-46},{74,46}})));
  Modelica.Blocks.Sources.Constant Pac(k=1) "Active Power"
    annotation (Placement(transformation(extent={{-80,-70},{-60,-50}})));
  Modelica.Blocks.Sources.Step Wref(
    height=3,
    offset=2,
    startTime=2) "Reference energy"
    annotation (Placement(transformation(extent={{-80,10},{-60,30}})));
  Modelica.Blocks.Sources.Constant Wtot(k=0) "Total energy"
    annotation (Placement(transformation(extent={{-80,-30},{-60,-10}})));
  Modelica.Blocks.Sources.Constant Vdc(k=1) "DC voltage"
    annotation (Placement(transformation(extent={{-80,50},{-60,70}})));
equation
  connect(Wtot.y, constantReferenceBLock.Wtot) annotation (Line(points={{-59,
          -20},{-22,-20},{-22,-11.96},{-7.4,-11.96}}, color={0,0,127}));
  connect(Pac.y, constantReferenceBLock.Pac) annotation (Line(points={{-59,-60},
          {-22,-60},{-22,-36.8},{-7.4,-36.8}}, color={0,0,127}));
  connect(Wref.y, constantReferenceBLock.Wref) annotation (Line(points={{-59,20},
          {-22,20},{-22,11.96},{-7.4,11.96}}, color={0,0,127}));
  connect(Vdc.y, constantReferenceBLock.Vdc) annotation (Line(points={{-59,60},
          {-22,60},{-22,36.8},{-7.4,36.8}}, color={0,0,127}));
  annotation (experiment(StopTime=10, __Dymola_Algorithm="Dassl"));
end TestConstantRefEnergyControl;
