within MMC_HVDC_AMCONF2026.ComponentLibrary.BasicBlocks.Sensor;
model DCpowerSensor "Measure DC Power"
  Modelica.Electrical.Analog.Sensors.PowerSensor powerSensor
    annotation (Placement(transformation(extent={{-10,-12},{10,8}})));
  Modelica.Electrical.Analog.Interfaces.PositivePin pin_p annotation (Placement(
        transformation(extent={{-34,46},{-14,66}}),    iconTransformation(
          extent={{-60,50},{-40,70}})));
  Modelica.Electrical.Analog.Interfaces.NegativePin pin_n annotation (Placement(
        transformation(extent={{-34,-66},{-14,-46}}),   iconTransformation(
          extent={{-60,-70},{-40,-50}})));
  Modelica.Electrical.Analog.Interfaces.PositivePin pin_p1
                                                          annotation (Placement(
        transformation(extent={{14,46},{34,66}}),      iconTransformation(
          extent={{40,50},{60,70}})));
  Modelica.Electrical.Analog.Interfaces.NegativePin pin_n1
                                                          annotation (Placement(
        transformation(extent={{14,-66},{34,-46}}),     iconTransformation(
          extent={{40,-70},{60,-50}})));
equation
  connect(pin_p, powerSensor.pv)
    annotation (Line(points={{-24,56},{0,56},{0,8}}, color={0,0,255}));
  connect(powerSensor.pc, powerSensor.pv) annotation (Line(points={{-10,-2},
          {-12,-2},{-12,56},{0,56},{0,8}}, color={0,0,255}));
  connect(pin_n, pin_n)
    annotation (Line(points={{-24,-56},{-24,-56}}, color={0,0,255}));
  connect(pin_n, pin_n1)
    annotation (Line(points={{-24,-56},{24,-56}}, color={0,0,255}));
  connect(powerSensor.nv, pin_n1)
    annotation (Line(points={{0,-12},{0,-56},{24,-56}}, color={0,0,255}));
  connect(powerSensor.nc, pin_p1) annotation (Line(points={{10,-2},{14,-2},
          {14,56},{24,56}}, color={0,0,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-60,
            -100},{60,100}}),
                            graphics={
        Text(
          extent={{-38,70},{-18,50}},
          textColor={0,0,0},
          textString="+"),
        Text(
          extent={{18,70},{38,50}},
          textColor={0,0,0},
          textString="+"),
        Text(
          extent={{-40,-50},{-20,-70}},
          textColor={0,0,0},
          textString="-"),
        Text(
          extent={{18,-50},{38,-70}},
          textColor={0,0,0},
          textString="-"),
        Polygon(
          points={{0,8},{0,-8},{20,0},{0,8}},
          lineColor={28,108,200},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-12,0},{-4,0},{0,0}},
          color={0,0,0},
          thickness=1),
        Rectangle(
          extent={{-60,100},{60,-100}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.None,
          lineThickness=0.5)}), Diagram(coordinateSystem(
          preserveAspectRatio=false, extent={{-60,-100},{60,100}})));
end DCpowerSensor;
