within MMC_HVDC_AMCONF2026.ComponentLibrary.ControlBlocks.OuterLoopControls.ACvoltageControl;
model dAxisVoltageControlTest "Tests the d axis AC voltage control"
extends Modelica.Icons.Example;
  dAxisACvoltageControl aCd_axisVoltageControl(
    k=1,
    T(displayUnit="s") = 10/3,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    x_start=0,
    y_start=2)
    annotation (Placement(transformation(extent={{-30,-30},{32,34}})));
  Modelica.Blocks.Sources.Constant Vgd(k=2)
    annotation (Placement(transformation(extent={{-86,-44},{-66,-24}})));
  Modelica.Blocks.Sources.Step Vgd_ref(
    height=5,
    offset=0,
    startTime=1)
    annotation (Placement(transformation(extent={{-88,32},{-68,52}})));
equation
  connect(aCd_axisVoltageControl.Vgd_ref, Vgd_ref.y) annotation (Line(
        points={{-36.2,21.2},{-62,21.2},{-62,42},{-67,42}}, color={0,0,
          127}));
  connect(aCd_axisVoltageControl.Vgd, Vgd.y) annotation (Line(points={{
          -36.2,-17.2},{-62,-17.2},{-62,-34},{-65,-34}}, color={0,0,127}));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false)),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=5,
      Interval=0.0001,
      __Dymola_Algorithm="Dassl"));
end dAxisVoltageControlTest;
