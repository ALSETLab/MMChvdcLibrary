within MMChvdcLibrary.ComponentLibrary.BasicBlocks.Sensor;
model ACpowerSensor "Measure the AC power"
  outer OpenIPSL.Electrical.SystemBase SysData;
  import Modelica.ComplexMath.conj;
  import Modelica.ComplexMath.real;
  import Modelica.ComplexMath.imag;
  import Modelica.ComplexMath.j;
  parameter Real S_b=SysData.S_b "System base power (MVA)"
    annotation (Dialog(group="Line parameters"));
  Real P12PU;
  Real P21PU;
  Real Q12PU;
  Real Q21PU;
    //annotation (Dialog(group="Line parameters", enable=false));
  OpenIPSL.Types.ActivePower P12;
  OpenIPSL.Types.ActivePower P21;
  OpenIPSL.Types.ReactivePower Q12;
  OpenIPSL.Types.ReactivePower Q21;
  Complex zero_i(re = 0, im = 0);
  Complex zero_v(re = 0, im = 0);
  Complex vs(re=p.vr, im=p.vi);
  Complex is(re=p.ir, im=p.ii);
  Complex vr(re=n.vr, im=n.vi);
  Complex ir(re=n.ir, im=n.ii);
OpenIPSL.Interfaces.PwPin p annotation (
    Placement(visible = true, transformation(origin={-40,0},    extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin={-40,0},    extent = {{-10, -10}, {10, 10}}, rotation = 0)));
OpenIPSL.Interfaces.PwPin n annotation (
    Placement(visible = true, transformation(origin={40,0},    extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin={40,0},    extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  P12PU = real(vs * conj(is));
  P21PU = real(vr*conj(ir));
  Q12PU = imag(vs * conj(is));
  Q21PU = imag(vr*conj(ir));
  P12 = real(vs * conj(is)) * S_b;
  P21 = real(vr*conj(ir))*S_b;
  Q12 = imag(vs * conj(is)) * S_b;
  Q21 = imag(vr*conj(ir))*S_b;
  zero_i = is + ir;
  zero_v = vs - vr;

//Calculations for the power flow display
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-40,-20},
            {40,20}}), graphics={
        Rectangle(
          extent={{-40,20},{40,-20}},
          lineColor={28,108,200},
          lineThickness=0.5),
        Text(
          extent={{-24,4},{22,-6}},
          textColor={28,108,200},
          textString="PQ")}),
                        Diagram(coordinateSystem(preserveAspectRatio=false,
          extent={{-40,-40},{40,40}})));
end ACpowerSensor;
