within MMC_HVDC_AMCONF2026.ComponentLibrary.BasicBlocks.Tranformation;
model PolarToComplex
Modelica.Blocks.Interfaces.RealInput xmag annotation (Placement(
      visible=true,
      transformation(
        origin={-120,0},
        extent={{-20,-20},{20,20}},
        rotation=0),
      iconTransformation(
        origin={-120,0},
        extent={{-20,-20},{20,20}},
        rotation=0)));
Modelica.Blocks.Interfaces.RealInput angle annotation (
    Placement(visible = true, transformation(origin={0,-120},     extent = {{-20, -20}, {20, 20}}, rotation=90),    iconTransformation(origin={0,-120},     extent = {{-20, -20}, {20, 20}}, rotation=90)));
Modelica.Blocks.Interfaces.RealOutput xr annotation (
    Placement(visible = true, transformation(origin={119,61},    extent = {{-19, -19}, {19, 19}}, rotation = 0), iconTransformation(origin={119,61},    extent = {{-19, -19}, {19, 19}}, rotation = 0)));
Modelica.Blocks.Interfaces.RealOutput xi annotation (
    Placement(visible = true, transformation(origin={119,-59},    extent = {{-19, -19}, {19, 19}}, rotation = 0), iconTransformation(origin={119,-59},    extent = {{-19, -19}, {19, 19}}, rotation = 0)));
import PI = Modelica.Constants.pi;
equation
  xr
   =xmag*cos(angle);
  xi
   =xmag*sin(angle);
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
          extent={{10,26},{48,10}},
          textColor={0,0,0},
          textString="RI"),
        Text(
          extent={{-46,-8},{0,-22}},
          textColor={0,0,0},
          textString="Polar"),
        Text(
          extent={{62,72},{98,50}},
          textColor={28,108,200},
          textString="R"),
        Text(
          extent={{74,-44},{104,-68}},
          textColor={28,108,200},
          textString="I"),
        Text(
          extent={{-18,-64},{20,-90}},
          textColor={28,108,200},
          textString="angle"),
        Text(
          extent={{-94,12},{-58,-10}},
          textColor={28,108,200},
          textString="mag")}),                                   Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end PolarToComplex;
