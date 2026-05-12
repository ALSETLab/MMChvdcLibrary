within MMChvdcLibrary.ComponentLibrary.ControlBlocks.OuterLoopControls.ACvoltageControl;
model qAxisACvoltageControlTest "Tests the q axis AC voltage controller"
extends Modelica.Icons.Example;
  qAxisACvoltageControl aCq_axisVoltageControl(
    k=1,
    T(displayUnit="s") = (10/3),
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    x_start=0,
    y_start=0)
    annotation (Placement(transformation(extent={{-30,-30},{32,34}})));
  Modelica.Blocks.Sources.Constant Vgq(k=2)
    annotation (Placement(transformation(extent={{-86,-44},{-66,-24}})));
  Modelica.Blocks.Sources.Step Vgq_ref(
    height=5,
    offset=0,
    startTime=1)
    annotation (Placement(transformation(extent={{-88,32},{-68,52}})));
equation
  connect(Vgq.y, aCq_axisVoltageControl.Vgq) annotation (Line(points={{
          -65,-34},{-48,-34},{-48,-17.2},{-36.2,-17.2}}, color={0,0,127}));
  connect(Vgq_ref.y, aCq_axisVoltageControl.Vgq_ref) annotation (Line(
        points={{-67,42},{-50,42},{-50,21.2},{-36.2,21.2}}, color={0,0,
          127}));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false)),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    experiment(__Dymola_NumberOfIntervals=5000, __Dymola_Algorithm="Dassl"));
end qAxisACvoltageControlTest;
