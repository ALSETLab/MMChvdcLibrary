within MMChvdcLibrary.ComponentLibrary.BasicBlocks.PhasorModels;
model ResistorPhasor "Resistor modeled in phasor domain"
  outer OpenIPSL.Electrical.SystemBase SysData;
  import Modelica.ComplexMath.conj;
  import Modelica.ComplexMath.real;
  import Modelica.ComplexMath.imag;
  import Modelica.ComplexMath.j;
  parameter OpenIPSL.Types.ApparentPower S_b=SysData.S_b
    "System base power"
    annotation (Dialog(group="Line parameters", enable=false));
  parameter OpenIPSL.Types.Voltage Vb "Base Voltage (kV)";
  parameter Modelica.Units.SI.Resistance R(start=1) "Resistance";
  OpenIPSL.Interfaces.PwPin_p p
    annotation (Placement(transformation(extent={{-120,-10},{-100,10}}),iconTransformation(extent={{-120,-10},{-100,10}})));
  OpenIPSL.Interfaces.PwPin_n n
    annotation (Placement(transformation(extent={{100,-10},{120,10}}),
        iconTransformation(extent={{100,-10},{120,10}})));
  parameter Boolean displayPF=false "Display power flow results:" annotation (
      Dialog(
      group="Visualisation",
      __Dymola_compact=true,
      __Dymola_descriptionLabel=true), choices(checkBox=true));
  OpenIPSL.Types.ActivePower P12;
  OpenIPSL.Types.ActivePower P21;
  OpenIPSL.Types.ReactivePower Q12;
  OpenIPSL.Types.ReactivePower Q21;
  Complex vs(re=p.vr, im=p.vi);
  Complex is(re=p.ir, im=p.ii);
  Complex vr(re=n.vr, im=n.vi);
  Complex ir(re=n.ir, im=n.ii);
equation
  //Calculations for the power flow display
  P12 = real(vs*conj(is))*S_b;
  P21 = -real(vr*conj(ir))*S_b;
  Q12 = imag(vs*conj(is))*S_b;
  Q21 = -imag(vr*conj(ir))*S_b;

  // Voltage across resistor: V = R * I (phasor form)
  p.vr - n.vr = (R*(S_b/Vb^2)) * p.ir;
  p.vi - n.vi = (R*(S_b/Vb^2)) * p.ii;

  // Current continuity (flow variables)
  p.ir + n.ir = 0;
  p.ii + n.ii = 0;
  annotation (Diagram(graphics={
        Rectangle(
          extent={{-64,26},{64,-26}},
          lineColor={28,108,200},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(points={{-110,0},{-64,0}}, color={28,108,200}),
        Line(points={{110,0},{64,0}}, color={28,108,200})}), Icon(graphics={
        Rectangle(
          extent={{-60,20},{60,-20}},
          lineColor={28,108,200},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(points={{-60,0},{-110,0}}, color={28,108,200}),
        Line(points={{110,0},{60,0}}, color={28,108,200}),
        Text(
          extent={{-148,64},{152,24}},
          textString="%name",
          textColor={0,0,255}),
        Text(
          extent={{-152,-24},{148,-64}},
          textString="R=%R")}));
end ResistorPhasor;
