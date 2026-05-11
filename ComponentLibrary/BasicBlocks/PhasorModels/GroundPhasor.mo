within MMC_HVDC_AMCONF2026.ComponentLibrary.BasicBlocks.PhasorModels;
model GroundPhasor

  import Modelica.ComplexMath.conj;
  import Modelica.ComplexMath.real;
  import Modelica.ComplexMath.imag;
  import Modelica.ComplexMath.j;
  OpenIPSL.Interfaces.PwPin p annotation (
    Placement(visible = true, transformation(origin={0,48},    extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {0, 98}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Complex vs(re = p.vr, im = p.vi);
equation
  vs = Complex(re = 0, im = 0);
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={                              Line(points={{-60,48},
              {60,48}},                                                                                                                      color = {0, 0, 255}), Line(points={{-40,28},
              {40,28}},                                                                                                                                                                                 color = {0, 0, 255}), Line(points={{-20,8},
              {20,8}},                                                                                                                                                                                                        color = {0, 0, 255}), Line(points={{0,88},{
              0,48}},                                                                                                                                                                                                        color = {0, 0, 255}),                                       Text(lineColor = {0, 0, 255}, extent={{-148,
              -50},{152,-10}},                                                                                                                                                                                                        textString = "%name")}),
                                                                 Diagram(
        coordinateSystem(preserveAspectRatio=false), graphics={                                            Line(points={{-60,0},
              {60,0}},                                                                                                                          thickness = 0.5, color = {0, 0, 255}), Line(points={{-40,-20},
              {40,-20}},                                                                                                                                                                                                    thickness = 0.5, color = {0, 0, 255}), Line(points={{-20,-40},
              {20,-40}},                                                                                                                                                                                                        thickness = 0.5, color = {0, 0, 255}), Line(points={{0,46},{
              0,0}},                                                                                                                                                                                                        thickness = 0.5, color = {0, 0, 255}), Text(extent={{-24,-88},
              {22,-56}},                                                                                                                                                                                                        textString = "p.v=0", lineColor = {0, 0, 255})}));
end GroundPhasor;
