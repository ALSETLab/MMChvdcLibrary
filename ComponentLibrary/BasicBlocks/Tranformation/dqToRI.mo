within MMC_HVDC_AMCONF2026.ComponentLibrary.BasicBlocks.Tranformation;
model dqToRI
Modelica.Blocks.Interfaces.RealInput xd annotation (
    Placement(visible = true, transformation(origin={-120,54},    extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin={-120,54},    extent = {{-20, -20}, {20, 20}}, rotation = 0)));
Modelica.Blocks.Interfaces.RealInput xq annotation (
    Placement(visible = true, transformation(origin={-120,-48},    extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin={-120,-48},    extent = {{-20, -20}, {20, 20}}, rotation = 0)));
Modelica.Blocks.Interfaces.RealInput angle annotation (
    Placement(visible = true, transformation(origin={0,-120},     extent = {{-20, -20}, {20, 20}}, rotation=90),    iconTransformation(origin={0,-120},     extent = {{-20, -20}, {20, 20}}, rotation=90)));
Modelica.Blocks.Interfaces.RealOutput xr annotation (
    Placement(visible = true, transformation(origin={119,57},    extent = {{-19, -19}, {19, 19}}, rotation = 0), iconTransformation(origin={119,57},    extent = {{-19, -19}, {19, 19}}, rotation = 0)));
Modelica.Blocks.Interfaces.RealOutput xi annotation (
    Placement(visible = true, transformation(origin={119,-47},    extent = {{-19, -19}, {19, 19}}, rotation = 0), iconTransformation(origin={119,-47},    extent = {{-19, -19}, {19, 19}}, rotation = 0)));
import PI = Modelica.Constants.pi;
equation
xr = (xd * cos(angle) + xq * sin(angle));
xi = (xd * sin(angle) - xq * cos(angle));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,0},
          lineThickness=0.5),
        Line(
          points={{-100,-100},{100,100}},
          color={0,0,0},
          thickness=0.5),
        Text(
          extent={{-62,28},{-6,8}},
          textColor={0,0,0},
          textString="dq"),
        Text(
          extent={{2,-8},{56,-30}},
          textColor={0,0,0},
          textString="RI"),
        Text(
          extent={{-90,64},{-68,44}},
          textColor={28,108,200},
          textString="d"),
        Text(
          extent={{-90,-36},{-68,-56}},
          textColor={28,108,200},
          textString="q"),
        Text(
          extent={{70,58},{92,38}},
          textColor={28,108,200},
          textString="R"),
        Text(
          extent={{68,-40},{90,-60}},
          textColor={28,108,200},
          textString="I"),
        Text(
          extent={{-20,-66},{18,-92}},
          textColor={28,108,200},
          textString="angle")}),                                 Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end dqToRI;
