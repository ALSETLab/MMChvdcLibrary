within MMChvdcLibrary.ComponentLibrary.BasicBlocks.Tranformation;
model RITodq
Modelica.Blocks.Interfaces.RealInput xr annotation (
    Placement(visible = true, transformation(origin={-120,60},    extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin={-120,60},    extent = {{-20, -20}, {20, 20}}, rotation = 0)));
Modelica.Blocks.Interfaces.RealInput xi annotation (
    Placement(visible = true, transformation(origin={-120,-60},    extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin={-120,-60},    extent = {{-20, -20}, {20, 20}}, rotation = 0)));
Modelica.Blocks.Interfaces.RealInput angle annotation (
    Placement(visible = true, transformation(origin={0,-120},     extent = {{-20, -20}, {20, 20}}, rotation=90),    iconTransformation(origin={0,-120},     extent = {{-20, -20}, {20, 20}}, rotation=90)));
Modelica.Blocks.Interfaces.RealOutput xd annotation (
    Placement(visible = true, transformation(origin={119,61},    extent = {{-19, -19}, {19, 19}}, rotation = 0), iconTransformation(origin={119,61},    extent = {{-19, -19}, {19, 19}}, rotation = 0)));
Modelica.Blocks.Interfaces.RealOutput xq annotation (
    Placement(visible = true, transformation(origin={119,-59},    extent = {{-19, -19}, {19, 19}}, rotation = 0), iconTransformation(origin={119,-59},    extent = {{-19, -19}, {19, 19}}, rotation = 0)));
import PI = Modelica.Constants.pi;
equation
xd = (xr * cos(angle) + xi * sin(angle));
xq = (xr * sin(angle) - xi * cos(angle));
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
          extent={{-40,-18},{-2,-34}},
          textColor={0,0,0},
          textString="RI"),
        Text(
          extent={{6,42},{52,28}},
          textColor={0,0,0},
          textString="dq"),
        Text(
          extent={{-94,56},{-58,34}},
          textColor={28,108,200},
          textString="R"),
        Text(
          extent={{-92,-58},{-62,-82}},
          textColor={28,108,200},
          textString="I"),
        Text(
          extent={{66,72},{94,50}},
          textColor={28,108,200},
          textString="d"),
        Text(
          extent={{60,-38},{96,-62}},
          textColor={28,108,200},
          textString="q"),
        Text(
          extent={{-18,-64},{20,-90}},
          textColor={28,108,200},
          textString="angle")}),                                 Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end RITodq;
