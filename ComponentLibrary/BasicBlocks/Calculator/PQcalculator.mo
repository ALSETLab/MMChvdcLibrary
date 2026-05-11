within MMC_HVDC_AMCONF2026.ComponentLibrary.BasicBlocks.Calculator;
model PQcalculator "Calculates AC power from d-q frame voltage and current"
Modelica.Blocks.Interfaces.RealInput igd "AC Current of the d axis"
                                         annotation (
    Placement(visible = true, transformation(origin={-117,41},    extent = {{-17, -17}, {17, 17}}, rotation = 0), iconTransformation(origin = {-117, 61}, extent = {{-17, -17}, {17, 17}}, rotation = 0)));
Modelica.Blocks.Interfaces.RealInput igq "AC Current of the q axis"
                                         annotation (
    Placement(visible = true, transformation(origin={-117,-41},     extent = {{-17, -17}, {17, 17}}, rotation = 0), iconTransformation(origin = {-117, 19}, extent = {{-17, -17}, {17, 17}}, rotation = 0)));
Modelica.Blocks.Interfaces.RealInput vgd "AC Voltage of the d axis"
                                         annotation (
    Placement(visible = true, transformation(origin={-1,117},     extent = {{-17, -17}, {17, 17}}, rotation = -90), iconTransformation(origin = {-117, -21}, extent = {{-17, -17}, {17, 17}}, rotation = 0)));
Modelica.Blocks.Interfaces.RealInput vgq "AC Votlage of the q axis"
                                         annotation (
    Placement(visible = true, transformation(origin={-1,-117},     extent = {{-17, -17}, {17, 17}}, rotation = 90), iconTransformation(origin = {-117, -61}, extent = {{17, -17}, {-17, 17}}, rotation = 180)));
Modelica.Blocks.Interfaces.RealOutput Pac "AC Active Power"
                                          annotation (Placement(
      visible=true,
      transformation(
        origin={116,38},
        extent={{-16,-16},{16,16}},
        rotation=0),
      iconTransformation(
        origin={116,36},
        extent={{-16,-16},{16,16}},
        rotation=0)));
Modelica.Blocks.Interfaces.RealOutput Qac "AC Reactive Power"
                                          annotation (Placement(
      visible=true,
      transformation(
        origin={116,-40},
        extent={{-16,-16},{16,16}},
        rotation=0),
      iconTransformation(
        origin={116,-40},
        extent={{-16,-16},{16,16}},
        rotation=0)));
equation
  Pac =igd *vgd +igq *vgq;
  Qac =-igd *vgq +igq *vgd;
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
          Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,0},
          lineThickness=0.5), Text(
          extent={{-44,12},{46,-12}},
          textColor={0,0,0},
          textString="PQ
Calculator"),
        Text(
          extent={{-86,64},{-68,56}},
          textColor={0,0,0},
          horizontalAlignment=TextAlignment.Left,
          textString="igd"),
        Text(
          extent={{-86,24},{-68,16}},
          textColor={0,0,0},
          horizontalAlignment=TextAlignment.Left,
          textString="igq"),
        Text(
          extent={{-86,-18},{-72,-26}},
          textColor={0,0,0},
          horizontalAlignment=TextAlignment.Left,
          textString="vgd"),
        Text(
          extent={{-86,-56},{-68,-64}},
          textColor={0,0,0},
          horizontalAlignment=TextAlignment.Left,
          textString="vgq"),
        Text(
          extent={{76,40},{94,32}},
          textColor={0,0,0},
          horizontalAlignment=TextAlignment.Left,
          textString="Pac"),
        Text(
          extent={{76,-34},{94,-42}},
          textColor={0,0,0},
          horizontalAlignment=TextAlignment.Left,
          textString="Qac")}),                                   Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end PQcalculator;
