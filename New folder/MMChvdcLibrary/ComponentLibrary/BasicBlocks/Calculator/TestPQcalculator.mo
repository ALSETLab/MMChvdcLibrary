within MMChvdcLibrary.ComponentLibrary.BasicBlocks.Calculator;
model TestPQcalculator "Tests the PQ calculator"
  extends Modelica.Icons.Example;
  PQcalculator pQ_calculator
    annotation (Placement(transformation(extent={{0,-40},{80,40}})));
  Modelica.Blocks.Sources.Step igd(
    height=3,
    offset=0,
    startTime=2)
    annotation (Placement(transformation(extent={{-60,60},{-40,80}})));
  Modelica.Blocks.Sources.Step igq(height=3, offset=2)
    annotation (Placement(transformation(extent={{-60,20},{-40,40}})));
  Modelica.Blocks.Sources.Step vgd(
    height=30,
    offset=0,
    startTime=2)
    annotation (Placement(transformation(extent={{-60,-40},{-40,-20}})));
  Modelica.Blocks.Sources.Step vgq(
    height=40,
    offset=0,
    startTime=2)
    annotation (Placement(transformation(extent={{-60,-80},{-40,-60}})));
equation
  connect(pQ_calculator.igd, igd.y) annotation (Line(points={{-6.8,24.4},{-20,
          24.4},{-20,70},{-39,70}}, color={0,0,127}));
  connect(pQ_calculator.igq, igq.y) annotation (Line(points={{-6.8,7.6},{-28,
          7.6},{-28,30},{-39,30}}, color={0,0,127}));
  connect(pQ_calculator.vgd, vgd.y) annotation (Line(points={{-6.8,-8.4},{-28,
          -8.4},{-28,-30},{-39,-30}}, color={0,0,127}));
  connect(pQ_calculator.vgq, vgq.y) annotation (Line(points={{-6.8,-24.4},{-20,
          -24.4},{-20,-70},{-39,-70}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, grid={2,2})),
                                                                 Diagram(
        coordinateSystem(preserveAspectRatio=false, grid={2,2})));
end TestPQcalculator;
