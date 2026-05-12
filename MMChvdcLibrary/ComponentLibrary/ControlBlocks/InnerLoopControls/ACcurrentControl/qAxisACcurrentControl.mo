within MMChvdcLibrary.ComponentLibrary.ControlBlocks.InnerLoopControls.ACcurrentControl;
model qAxisACcurrentControl
  "Takes the reference q axis current as input and modulates the q axis voltage"
  parameter Real fb;
  parameter Real Xr;
  parameter Real L_arm;
  parameter Real Vb;
  parameter Real MVAb;
  Modelica.Blocks.Math.Add add(k2=-1)
    annotation (Placement(transformation(extent={{-68,6},{-48,26}})));
  OpenIPSL.NonElectrical.Nonlinear.Div0block
                                div0block
    annotation (Placement(transformation(extent={{40,0},{60,20}})));
  Modelica.Blocks.Continuous.PI PI(
    k=Kp,
    T=T,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    x_start=x_start,
    y_start=y_start)
    annotation (Placement(transformation(extent={{-36,6},{-16,26}})));
  Modelica.Blocks.Math.Add3 add3(k3=+1)
    annotation (Placement(transformation(extent={{4,6},{24,26}})));
  Modelica.Blocks.Interfaces.RealInput Vc_eq
    "Equivalent Capacitor Voltage"
    annotation (Placement(transformation(extent={{-140,-100},{-100,-60}})));
  Modelica.Blocks.Interfaces.RealInput igq
    "Reference AC Current of the q axis"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.RealInput igd "AC Current of the d axis"
                                           annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={-120,-40})));
  Modelica.Blocks.Interfaces.RealOutput mq
    "Modulation Index of the q axis"
    annotation (Placement(transformation(extent={{100,-50},{120,-30}}),
        iconTransformation(extent={{100,-50},{120,-30}})));
  Modelica.Blocks.Interfaces.RealInput igq_ref
    "Reference AC current of the q axis"
    annotation (Placement(transformation(extent={{-140,20},{-100,60}})));
  Modelica.Blocks.Interfaces.RealInput vgq "AC Voltage of the q axis"
                                           annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={-120,80})));
  Modelica.Blocks.Interfaces.RealOutput Vmq "Modulated AC q axis Voltage"
    annotation (Placement(transformation(extent={{100,30},{120,50}}),
        iconTransformation(extent={{100,30},{120,50}})));
  parameter Real Kp=1 "Gain"
    annotation (Dialog(group="PI Controller Parameters"));
  parameter Modelica.Units.SI.Time T "Time Constant (T>0 required)"
    annotation (Dialog(group="PI Controller Parameters"));
  parameter Modelica.Blocks.Types.Init initType=Modelica.Blocks.Types.Init.NoInit
    "Type of initialization (1: no init, 2: steady state, 3: initial state, 4: initial output)"
    annotation (Dialog(group="PI Controller Parameters"));
  parameter Real x_start=0 "Initial or guess value of state"
    annotation (Dialog(group="PI Controller Parameters"));
  parameter Real k=2*Modelica.Constants.pi*fb*(Xr + 0.5*L_arm)*Vb*Vb/(2*MVAb*fb*
      Modelica.Constants.pi) "Gain value multiplied with input signal";
  Modelica.Blocks.Math.Gain gain1(k=Xr + 0.5*L_arm)
    annotation (Placement(transformation(extent={{-40,-50},{-20,-30}})));
  parameter Real y_start=0 "Initial value of output"
    annotation (Dialog(group="PI Controller Parameters"));
equation
  connect(igq, add.u2) annotation (Line(points={{-120,0},{-78,0},{-78,10},{-70,
          10}}, color={0,0,127}));
  connect(add.y,PI. u)
    annotation (Line(points={{-47,16},{-38,16}}, color={0,0,127}));
  connect(div0block.y,mq)  annotation (Line(points={{61,10},{72,10},{72,-40},{
          110,-40}},
                 color={0,0,127}));
  connect(div0block.u2, Vc_eq) annotation (Line(points={{38,4},{30,4},{30,-80},
          {-120,-80}},                        color={0,0,127}));
  connect(igq_ref, add.u1) annotation (Line(points={{-120,40},{-78,40},{-78,22},
          {-70,22}},color={0,0,127}));
  connect(div0block.u1, add3.y) annotation (Line(points={{38,16},{25,16}},
                    color={0,0,127}));
  connect(PI.y, add3.u2)
    annotation (Line(points={{-15,16},{2,16}},   color={0,0,127}));
  connect(vgq, add3.u1) annotation (Line(points={{-120,80},{-6,80},{-6,24},{2,
          24}}, color={0,0,127}));
  connect(Vmq, add3.y) annotation (Line(points={{110,40},{30,40},{30,16},{25,16}},
        color={0,0,127}));
  connect(igd, gain1.u)
    annotation (Line(points={{-120,-40},{-42,-40}}, color={0,0,127}));
  connect(add3.u3, gain1.y) annotation (Line(points={{2,8},{-10,8},{-10,-40},{
          -19,-40}},
                 color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, grid={2,2}),
                               graphics={
        Text(
          extent={{-92,86},{-70,74}},
          textColor={0,0,0},
          textString="Vgq"),
        Text(
          extent={{-92,48},{-58,36}},
          textColor={0,0,0},
          textString="igq_ref"),
        Text(
          extent={{-96,6},{-62,-6}},
          textColor={0,0,0},
          textString="igq"),
        Text(
          extent={{-96,-36},{-54,-48}},
          textColor={0,0,0},
          textString="igd"),
        Text(
          extent={{-90,-74},{-56,-88}},
          textColor={0,0,0},
          textString="Vceq"),
        Text(
          extent={{66,46},{92,34}},
          textColor={0,0,0},
          textString="Vmq"),
        Text(
          extent={{66,-36},{96,-48}},
          textColor={0,0,0},
          textString="mq"),
        Text(
          extent={{-40,40},{40,-40}},
          textColor={0,0,0},
          textString="AC
q axis
Current
Controller"),
        Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,0},
          lineThickness=0.5)}), Diagram(coordinateSystem(preserveAspectRatio=false,
          grid={2,2})));
end qAxisACcurrentControl;
