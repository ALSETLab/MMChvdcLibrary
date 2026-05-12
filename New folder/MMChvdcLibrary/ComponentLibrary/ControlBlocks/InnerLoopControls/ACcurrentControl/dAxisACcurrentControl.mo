within MMChvdcLibrary.ComponentLibrary.ControlBlocks.InnerLoopControls.ACcurrentControl;
model dAxisACcurrentControl
  "Takes the reference d axis current as input and modulates the d axis voltage"
  parameter Real fb;
  parameter Real Xr;
  parameter Real L_arm;
  parameter Real Vb;
  parameter Real MVAb;
  Modelica.Blocks.Math.Add add(k2=-1)
    annotation (Placement(transformation(extent={{-72,10},{-52,30}})));
  OpenIPSL.NonElectrical.Nonlinear.Div0block
                                div0block
    annotation (Placement(transformation(extent={{48,4},{68,24}})));
  Modelica.Blocks.Interfaces.RealInput Vc_eq
    annotation (Placement(transformation(extent={{-140,-100},{-100,-60}}),
        iconTransformation(extent={{-140,-100},{-100,-60}})));
  Modelica.Blocks.Interfaces.RealInput igd "AC Current of the d-axis"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}}),
        iconTransformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.RealInput igq "AC Current of the q-axis"
                                           annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={-120,-40})));
  Modelica.Blocks.Interfaces.RealOutput md
    "Modulation Index of the d-axis"
    annotation (Placement(transformation(extent={{100,-50},{120,-30}}),
        iconTransformation(extent={{100,-50},{120,-30}})));
  Modelica.Blocks.Interfaces.RealInput igd_ref
    "Reference AC Current of the d-axis"
    annotation (Placement(transformation(extent={{-140,20},{-100,60}}),
        iconTransformation(extent={{-140,20},{-100,60}})));
  Modelica.Blocks.Interfaces.RealInput vgd "AC Voltage of the d-axis"
                                           annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={-120,80})));
  Modelica.Blocks.Math.Gain gain1(k=Xr + 0.5*L_arm)
    annotation (Placement(transformation(extent={{-52,-50},{-32,-30}})));
  Modelica.Blocks.Math.Add3 add3(k3=-1)
    annotation (Placement(transformation(extent={{4,10},{24,30}})));
  Modelica.Blocks.Interfaces.RealOutput Vmd "Modulated d-axis Voltage"
    annotation (Placement(transformation(extent={{100,30},{120,50}}),
        iconTransformation(extent={{100,30},{120,50}})));
  parameter Real k=2*Modelica.Constants.pi*fb*(Xr + 0.5*L_arm)*Vb*Vb/(2*MVAb*fb*
      Modelica.Constants.pi) "Gain value multiplied with input signal";
  Modelica.Blocks.Continuous.PI PI(
    k=Kp,
    T=T,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    x_start=x_start,
    y_start=y_start)
    annotation (Placement(transformation(extent={{-36,10},{-16,30}})));
  parameter Real Kp=k "Gain"
    annotation (Dialog(group="PI Controller Parameters"));
  parameter Modelica.Units.SI.Time T "Time Constant (T>0 required)"
    annotation (Dialog(group="PI Controller Parameters"));
  parameter Modelica.Blocks.Types.Init initType=Modelica.Blocks.Types.Init.NoInit
    "Type of initialization (1: no init, 2: steady state, 3: initial state, 4: initial output)"
    annotation (Dialog(group="PI Controller Parameters"));
  parameter Real x_start=0 "Initial or guess value of state"
    annotation (Dialog(group="PI Controller Parameters"));

  parameter Real y_start=0 "Initial value of output"
    annotation (Dialog(group="PI Controller Parameters"));
equation
  connect(igd, add.u2) annotation (Line(points={{-120,0},{-82,0},{-82,14},{-74,
          14}}, color={0,0,127}));
  connect(div0block.y,md)  annotation (Line(points={{69,14},{74,14},{74,-40},{
          110,-40}},  color={0,0,127}));
  connect(div0block.u2, Vc_eq) annotation (Line(points={{46,8},{32,8},{32,-80},
          {-120,-80}},  color={0,0,127}));
  connect(igd_ref, add.u1) annotation (Line(points={{-120,40},{-82,40},{-82,26},
          {-74,26}}, color={0,0,127}));
  connect(igq, gain1.u) annotation (Line(points={{-120,-40},{-54,-40}},
        color={0,0,127}));
  connect(div0block.u1, add3.y)
    annotation (Line(points={{46,20},{25,20}}, color={0,0,127}));
  connect(gain1.y, add3.u3) annotation (Line(points={{-31,-40},{-6,-40},{-6,12},
          {2,12}},          color={0,0,127}));
  connect(vgd, add3.u1) annotation (Line(points={{-120,80},{-6,80},{-6,28},{2,
          28}}, color={0,0,127}));
  connect(Vmd, add3.y) annotation (Line(points={{110,40},{32,40},{32,20},{25,20}},
        color={0,0,127}));
  connect(add.y, PI.u)
    annotation (Line(points={{-51,20},{-38,20}},
                                              color={0,0,127}));
  connect(add3.u2, PI.y)
    annotation (Line(points={{2,20},{-15,20}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, grid={2,2}),
                               graphics={
        Text(
          extent={{-92,88},{-70,76}},
          textColor={0,0,0},
          textString="Vgd"),
        Text(
          extent={{-92,48},{-58,36}},
          textColor={0,0,0},
          textString="igd_ref"),
        Text(
          extent={{-98,6},{-64,-6}},
          textColor={0,0,0},
          textString="igd"),
        Text(
          extent={{-100,-34},{-58,-46}},
          textColor={0,0,0},
          textString="igq"),
        Text(
          extent={{-92,-76},{-58,-90}},
          textColor={0,0,0},
          textString="Vceq"),
        Text(
          extent={{62,48},{88,36}},
          textColor={0,0,0},
          textString="Vmd"),
        Text(
          extent={{66,-34},{96,-46}},
          textColor={0,0,0},
          textString="md"),
        Text(
          extent={{-40,40},{40,-40}},
          textColor={0,0,0},
          textString="AC 
d-axis
Current 
Controller"),
        Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,0},
          lineThickness=0.5)}), Diagram(coordinateSystem(preserveAspectRatio=false,
          grid={2,2})));
end dAxisACcurrentControl;
