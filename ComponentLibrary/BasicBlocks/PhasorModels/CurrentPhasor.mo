within MMC_HVDC_AMCONF2026.ComponentLibrary.BasicBlocks.PhasorModels;
model CurrentPhasor

  import Modelica.ComplexMath.conj;
  import Modelica.ComplexMath.real;
  import Modelica.ComplexMath.imag;
  import Modelica.ComplexMath.j;
  OpenIPSL.Interfaces.PwPin p annotation (
    Placement(visible = true, transformation(origin={-110,2},    extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin={-98,0},     extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OpenIPSL.Interfaces.PwPin n annotation (
    Placement(visible = true, transformation(origin={110,2},    extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin={98,-2},     extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.ComplexBlocks.Interfaces.ComplexInput i "unit = A" annotation (
    Placement(visible = true, transformation(origin={0,80},    extent = {{-20, -20}, {20, 20}}, rotation = -90), iconTransformation(origin={0,74},    extent = {{-20, -20}, {20, 20}}, rotation=270)));
  Complex zero(re = 0, im = 0);
  Complex vs(re = p.vr, im = p.vi);
  Complex is(re = p.ir, im = p.ii);
  Complex vr(re = n.vr, im = n.vi);
  Complex ir(re = n.ir, im = n.ii);
  Complex v;
  Modelica.Units.SI.Voltage V "Voltage drop between the two pins (= p.v - n.v)";
equation
  v = vs - vr;
  V = sqrt(real(v) ^ 2 + imag(v) ^ 2);
  zero = is + ir;
  i = is;
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
                                                           Ellipse(lineColor = {0, 0, 255}, fillColor = {255, 255, 255},
            fillPattern =                                                                                                              FillPattern.Solid, extent={{-50,50},
              {50,-50}},                                                                                                                                                                   endAngle = 360), Line(points={{-90,0},
              {-50,0}},                                                                                                                                                                                                        color = {0, 0, 255}), Line(points={{50,0},{
              90,0}},                                                                                                                                                                                                        color = {0, 0, 255}), Line(points={{0,-50},
              {0,50}},                                                                                                                                                                                                        color = {0, 0, 255}),                                                                                           Polygon(lineColor = {0, 0, 255}, fillColor = {0, 0, 255},
            fillPattern =                                                                                                                                                                                                        FillPattern.Solid, points={{90,0},{
              60,10},{60,-10},{90,0}}),                                                                                                                                                                                                        Text(lineColor = {0, 0, 255}, extent={{-150,
              -106},{150,-66}},                                                                                                                                                                                                        textString = "%name")}),
                                                                 Diagram(
        coordinateSystem(preserveAspectRatio=false), graphics={
                                                              Ellipse(lineColor = {0, 0, 255}, fillColor = {255, 255, 255},
            fillPattern =                                                                                                                 FillPattern.Solid, extent={{-50,52},
              {50,-48}},                                                                                                                                                                      endAngle = 360), Line(points={{0,-48},
              {0,52}},                                                                                                                                                                                                        color = {0, 0, 255})}));
end CurrentPhasor;
