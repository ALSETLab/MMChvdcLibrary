within MMChvdcLibrary.ComponentLibrary;
package Converter "Converter Blocks"

  annotation (Icon(graphics={
        Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,0},
          lineThickness=0.5),
        Polygon(
          points={{-20,-20},{-20,-20}},
          lineColor={0,0,0},
          lineThickness=0.5,
          smooth=Smooth.Bezier),
        Polygon(
          points={{-30,-20},{0,20},{30,-20},{-30,-20}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Line(
          points={{0,-20},{0,-50}},
          color={0,0,0},
          thickness=1),
        Line(
          points={{0,20},{0,50}},
          color={0,0,0},
          thickness=1),
        Line(
          points={{-30,20},{30,20}},
          color={0,0,0},
          thickness=1),
        Line(
          points={{0,20},{30,40}},
          color={0,0,0},
          thickness=1)}));
end Converter;
