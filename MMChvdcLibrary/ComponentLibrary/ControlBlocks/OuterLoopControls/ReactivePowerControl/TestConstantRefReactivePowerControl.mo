within MMChvdcLibrary.ComponentLibrary.ControlBlocks.OuterLoopControls.ReactivePowerControl;
model TestConstantRefReactivePowerControl
  "Tests the reactive power controller."
  extends Modelica.Icons.Example;
  Modelica.Blocks.Sources.Constant Vgd(k=2) "d axis AC voltage"
    annotation (Placement(transformation(extent={{-60,-60},{-40,-40}})));
  Modelica.Blocks.Sources.Step Qac_ref(
    height=6,
    offset=4,
    startTime=2) "Reactive power reference"
    annotation (Placement(transformation(extent={{-60,40},{-40,60}})));
  ConstantRefReactivePowerControl
                       powerControl             annotation (Placement(
        transformation(extent={{0,-40},{80,40}})));
equation
  connect(Qac_ref.y, powerControl.Qac_ref) annotation (Line(points={{-39,50},{
          -22,50},{-22,24},{-8,24}}, color={0,0,127}));
  connect(Vgd.y, powerControl.Vgd) annotation (Line(points={{-39,-50},{-22,-50},
          {-22,-24},{-8,-24}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, grid={2,2})),
                                                                 Diagram(
        coordinateSystem(preserveAspectRatio=false, grid={2,2})));
end TestConstantRefReactivePowerControl;
