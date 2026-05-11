within MMC_HVDC_AMCONF2026.ComponentLibrary.ControlBlocks.OuterLoopControls.ActivePowerControl;
model TestActivePowerControl "Tests the active power controller."
  extends Modelica.Icons.Example;
  Modelica.Blocks.Sources.Constant Vgd(k=1) "d axis AC voltage"
    annotation (Placement(transformation(extent={{-60,-50},{-40,-30}})));
  Modelica.Blocks.Sources.Step Pac_ref(
    height=3,
    offset=2,
    startTime=2) "Reference Active Power"
    annotation (Placement(transformation(extent={{-60,30},{-40,50}})));
  Modelica.Blocks.Sources.Constant Pac(k=0) "Active Power"
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
  ActivePowerControl powerControl(
    k=1,
    T(displayUnit="ms") = 0.001*(50/3),
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    x_start=0,
    y_start=0) annotation (Placement(transformation(extent={{0,-34},{68,34}})));
equation
  connect(Pac_ref.y, powerControl.Pac_ref) annotation (Line(points={{-39,40},{
          -34,40},{-34,20.4},{-6.8,20.4}}, color={0,0,127}));
  connect(powerControl.Pac, Pac.y)
    annotation (Line(points={{-6.8,0},{-39,0}}, color={0,0,127}));
  connect(powerControl.Vgd, Vgd.y) annotation (Line(points={{-6.8,-20.4},{-34,
          -20.4},{-34,-40},{-39,-40}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, grid={2,2})),
                                                                 Diagram(
        coordinateSystem(preserveAspectRatio=false, grid={2,2})));
end TestActivePowerControl;
