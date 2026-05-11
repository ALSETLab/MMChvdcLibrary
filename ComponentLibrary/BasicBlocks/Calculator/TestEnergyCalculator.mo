within MMC_HVDC_AMCONF2026.ComponentLibrary.BasicBlocks.Calculator;
model TestEnergyCalculator "Tests the energy calculator"
  extends Modelica.Icons.Example;
  MMC_HVDC_AMCONF2026.ComponentLibrary.BasicBlocks.Calculator.EnergyCalculator EnergyCalculator
    annotation (Placement(transformation(extent={{0,-40},{80,40}})));
  Modelica.Blocks.Sources.Step Vceq(
    height=3,
    offset=2,
    startTime=2)
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
equation
  connect(Vceq.y, EnergyCalculator.Vceq) annotation (Line(points={{-39,0},{
          -22.9,0},{-22.9,0.4},{-6.8,0.4}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, grid={2,2})),
                                                                 Diagram(
        coordinateSystem(preserveAspectRatio=false, grid={2,2})));
end TestEnergyCalculator;
