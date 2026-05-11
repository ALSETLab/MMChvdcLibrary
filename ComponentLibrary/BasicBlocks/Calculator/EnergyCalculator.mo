within MMC_HVDC_AMCONF2026.ComponentLibrary.BasicBlocks.Calculator;
model EnergyCalculator "Calculates energy of the MMC"
  parameter Real C_eq;
Modelica.Blocks.Interfaces.RealInput Vceq "Equivalent Capacitor Voltage"
                                          annotation (Placement(
      visible=true,
      transformation(
        origin={-117,1},
        extent={{-17,-17},{17,17}},
        rotation=0),
      iconTransformation(
        origin={-117,1},
        extent={{-17,-17},{17,17}},
        rotation=0)));
Modelica.Blocks.Interfaces.RealOutput Wtot "Total Energy of the MMC"
                                           annotation (Placement(
      visible=true,
      transformation(
        origin={116,0},
        extent={{-16,-16},{16,16}},
        rotation=0),
      iconTransformation(
        origin={116,0},
        extent={{-16,-16},{16,16}},
        rotation=0)));
  Modelica.Blocks.Math.Gain gain(k=1)
    annotation (Placement(transformation(extent={{38,-10},{58,10}})));
  Modelica.Blocks.Math.Product product1
    annotation (Placement(transformation(extent={{-46,-10},{-26,10}})));
equation
  connect(Vceq, product1.u1) annotation (Line(points={{-117,1},{-74,1},{-74,6},{
          -48,6}}, color={0,0,127}));
  connect(product1.u2, Vceq) annotation (Line(points={{-48,-6},{-74,-6},{-74,1},
          {-117,1}}, color={0,0,127}));
  connect(product1.y, gain.u)
    annotation (Line(points={{-25,0},{36,0}}, color={0,0,127}));
  connect(gain.y, Wtot)
    annotation (Line(points={{59,0},{116,0}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, initialScale
          =2),
        graphics={
        Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,0},
          lineThickness=0.5),
        Text(
          extent={{-28,22},{26,-24}},
          textColor={0,0,0},
          textString="Energy 
Calculator"),
        Text(
          extent={{-92,14},{-72,-14}},
          textColor={0,0,0},
          textString="Vceq"),
        Text(
          extent={{70,14},{90,-14}},
          textColor={0,0,0},
          textString="Wtot")}),                                  Diagram(
        coordinateSystem(preserveAspectRatio=false, initialScale=2)));
end EnergyCalculator;
