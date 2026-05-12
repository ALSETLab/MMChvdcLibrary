within MMChvdcLibrary.ComponentLibrary.ControlBlocks.OuterLoopControls.ReactivePowerControl;
model TestReactivePowerControl "Tests the reactive power controller."
  extends Modelica.Icons.Example;
  Modelica.Blocks.Sources.Constant Vgd(k=0.866) "d axis AC voltage"
    annotation (Placement(transformation(extent={{-60,-60},{-40,-40}})));
  Modelica.Blocks.Sources.Step Qac_ref(
    height=0.01,
    offset=0,
    startTime=1.5) "Reactive power reference"
    annotation (Placement(transformation(extent={{-60,40},{-40,60}})));
  Modelica.Blocks.Sources.Constant Qac(k=0) "Reactive Power"
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
  ReactivePowerControl powerControl(
    k=10,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    y_start=0)                                  annotation (Placement(
        transformation(extent={{0,-40},{80,40}})));
equation
  connect(Qac_ref.y, powerControl.Qac_ref) annotation (Line(points={{-39,50},{
          -22,50},{-22,24},{-8,24}}, color={0,0,127}));
  connect(Qac.y, powerControl.Qac)
    annotation (Line(points={{-39,0},{-8,0}}, color={0,0,127}));
  connect(Vgd.y, powerControl.Vgd) annotation (Line(points={{-39,-50},{-22,-50},
          {-22,-24},{-8,-24}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, grid={2,2})),
                                                                 Diagram(
        coordinateSystem(preserveAspectRatio=false, grid={2,2})));
end TestReactivePowerControl;
