within MMC_HVDC_AMCONF2026.ComponentLibrary.ControlBlocks.OuterLoopControls.EnergyControl;
model TestVariableRefEnergyControl
  "Tests the Variable Reference Energy Controller."
  extends Modelica.Icons.Example;
  Modelica.Blocks.Sources.Constant Pac(k=1) "Active Power"
    annotation (Placement(transformation(extent={{-60,-50},{-40,-30}})));
  Modelica.Blocks.Sources.Step Vdc(
    height=3,
    offset=2,
    startTime=2) "DC voltage"
    annotation (Placement(transformation(extent={{-60,30},{-40,50}})));
  Modelica.Blocks.Sources.Constant Wtot(k=0) "Total energy"
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
  VariableRefEnergyControl EnergyController(
    k=1,
    T=5,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    x_start=0,
    y_start=0) "Variable Reference Energy Controller"
    annotation (Placement(transformation(extent={{0,-46},{72,46}})));
equation
  connect(Wtot.y, EnergyController.Wtot)
    annotation (Line(points={{-39,0},{-6,0}}, color={0,0,127}));
  connect(Pac.y, EnergyController.Pac) annotation (Line(points={{-39,-40},{-20,
          -40},{-20,-28.52},{-6,-28.52}}, color={0,0,127}));
  connect(Vdc.y, EnergyController.Vdc) annotation (Line(points={{-39,40},{-20,
          40},{-20,27.6},{-6,27.6}}, color={0,0,127}));
  annotation (experiment(StopTime=10, __Dymola_Algorithm="Dassl"));
end TestVariableRefEnergyControl;
