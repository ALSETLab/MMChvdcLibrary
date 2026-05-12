within MMChvdcLibrary.ComponentLibrary.BasicBlocks.Tranformation;
model ComplexToPolar
Modelica.Blocks.Interfaces.RealInput xr annotation (
    Placement(visible = true, transformation(origin={-100,60},    extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin={-120,60},    extent = {{-20, -20}, {20, 20}}, rotation = 0)));
Modelica.Blocks.Interfaces.RealInput xi annotation (
    Placement(visible = true, transformation(origin={-100,-60},    extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin={-120,-60},    extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput mag
    annotation (Placement(transformation(extent={{100,50},{120,70}})));
  Modelica.Blocks.Interfaces.RealOutput angle annotation (Placement(
        transformation(extent={{100,-70},{120,-50}}), iconTransformation(extent
          ={{100,-70},{120,-50}})));
  Modelica.Blocks.Math.RectangularToPolar rectangularToPolar
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
equation
  connect(rectangularToPolar.u_re, xr) annotation (Line(points={{-12,6},{-74,6},
          {-74,60},{-100,60}}, color={0,0,127}));
  connect(rectangularToPolar.u_im, xi) annotation (Line(points={{-12,-6},{-74,
          -6},{-74,-60},{-100,-60}}, color={0,0,127}));
  connect(rectangularToPolar.y_abs, mag) annotation (Line(points={{11,6},{96,6},
          {96,60},{110,60}}, color={0,0,127}));
  connect(rectangularToPolar.y_arg, angle) annotation (Line(points={{11,-6},{96,
          -6},{96,-60},{110,-60}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,0},
          lineThickness=0.5),
        Line(
          points={{-100,100},{100,-100}},
          color={0,0,0},
          thickness=0.5),
        Text(
          extent={{-58,8},{-20,-8}},
          textColor={0,0,0},
          textString="RI"),
        Text(
          extent={{18,6},{64,-8}},
          textColor={0,0,0},
          textString="Polar"),
        Text(
          extent={{-100,70},{-64,48}},
          textColor={28,108,200},
          textString="R"),
        Text(
          extent={{-96,-48},{-66,-72}},
          textColor={28,108,200},
          textString="I"),
        Text(
          extent={{54,-46},{92,-72}},
          textColor={28,108,200},
          textString="angle"),
        Text(
          extent={{56,72},{92,50}},
          textColor={28,108,200},
          textString="mag")}), Diagram(coordinateSystem(preserveAspectRatio=
            false)));
end ComplexToPolar;
