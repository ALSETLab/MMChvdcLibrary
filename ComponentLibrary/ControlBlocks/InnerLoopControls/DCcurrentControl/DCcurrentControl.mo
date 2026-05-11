within MMC_HVDC_AMCONF2026.ComponentLibrary.ControlBlocks.InnerLoopControls.DCcurrentControl;
model DCcurrentControl
  "Takes reference DC current as input and generates modulated DC voltage"
  Modelica.Blocks.Math.Add add(k2=-1)
    annotation (Placement(transformation(extent={{-76,30},{-56,50}})));
  OpenIPSL.NonElectrical.Nonlinear.Div0block
                                div0block
    annotation (Placement(transformation(extent={{40,0},{60,20}})));
  Modelica.Blocks.Continuous.PI PI(
    k=k,
    T=T,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    x_start=x_start,
    y_start=y_start)
    annotation (Placement(transformation(extent={{-46,30},{-26,50}})));
  Modelica.Blocks.Math.Add add1(k1=-1, k2=+1)
    annotation (Placement(transformation(extent={{-10,6},{10,26}})));
  Modelica.Blocks.Interfaces.RealInput Vc_eq
    "Equivalent Capacitor Votlage"
    annotation (Placement(transformation(extent={{-140,-80},{-100,-40}}),
        iconTransformation(extent={{-140,-80},{-100,-40}})));
  Modelica.Blocks.Interfaces.RealInput idc "DC Current"
    annotation (Placement(transformation(extent={{-140,0},{-100,40}}),
        iconTransformation(extent={{-140,0},{-100,40}})));
  Modelica.Blocks.Interfaces.RealInput Vdc "DC Voltage"
                                           annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={-120,-20}), iconTransformation(extent={{-140,-40},{-100,0}})));
  Modelica.Blocks.Interfaces.RealOutput mdc "DC Moduilation Index"
    annotation (Placement(transformation(extent={{100,-30},{120,-10}}),
        iconTransformation(extent={{100,-30},{120,-10}})));
  Modelica.Blocks.Interfaces.RealInput idc_ref "Reference DC Current"
    annotation (Placement(transformation(extent={{-140,40},{-100,80}}),
        iconTransformation(extent={{-140,40},{-100,80}})));
  Modelica.Blocks.Interfaces.RealOutput Vmdc "Modulat4ed DC Voltage"
    annotation (Placement(transformation(extent={{100,10},{120,30}}),
        iconTransformation(extent={{100,10},{120,30}})));
  parameter Real k=1 "Gain"
    annotation (Dialog(group="PI Controller Parameters"));
  parameter Modelica.Units.SI.Time T "Time Constant (T>0 required)"
    annotation (Dialog(group="PI Controller Parameters"));
  parameter Modelica.Blocks.Types.Init initType=Modelica.Blocks.Types.Init.NoInit
    "Type of initialization (1: no init, 2: steady state, 3: initial state, 4: initial output)"
    annotation (Dialog(group=
          "PI Controller Parameters"));
  parameter Real x_start=0 "Initial or guess value of state"
    annotation (Dialog(group=
          "PI Controller Parameters"));
  parameter Real y_start=0 "Initial value of output"
    annotation (Dialog(group="PI Controller Parameters"));
equation
  connect(idc, add.u2) annotation (Line(points={{-120,20},{-82,20},{-82,34},{
          -78,34}},
                color={0,0,127}));
  connect(add.y,PI. u)
    annotation (Line(points={{-55,40},{-48,40}},color={0,0,127}));
  connect(div0block.y, mdc) annotation (Line(points={{61,10},{68,10},{68,-20},{
          110,-20}},            color={0,0,127}));
  connect(PI.y, add1.u1)
    annotation (Line(points={{-25,40},{-20,40},{-20,22},{-12,22}},
                                                 color={0,0,127}));
  connect(div0block.u1, add1.y) annotation (Line(points={{38,16},{11,16}},
                                color={0,0,127}));
  connect(Vdc, add1.u2) annotation (Line(points={{-120,-20},{-20,-20},{-20,10},
          {-12,10}},
                   color={0,0,127}));
  connect(div0block.u2, Vc_eq) annotation (Line(points={{38,4},{30,4},{30,-60},
          {-120,-60}},              color={0,0,127}));
  connect(idc_ref, add.u1) annotation (Line(points={{-120,60},{-82,60},{-82,46},
          {-78,46}}, color={0,0,127}));
  connect(Vmdc, add1.y) annotation (Line(points={{110,20},{80,20},{80,34},{18,
          34},{18,16},{11,16}},                           color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, grid={2,2}),
                               graphics={
        Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,0},
          lineThickness=0.5),
        Text(
          extent={{-86,66},{-54,54}},
          textColor={0,0,0},
          textString="idc_ref"),
        Text(
          extent={{-92,26},{-54,12}},
          textColor={0,0,0},
          textString="idc"),
        Text(
          extent={{-88,-16},{-56,-30}},
          textColor={0,0,0},
          textString="Vdc"),
        Text(
          extent={{-86,-64},{-52,-78}},
          textColor={0,0,0},
          textString="Vceq"),
        Text(
          extent={{60,30},{92,14}},
          textColor={0,0,0},
          textString="Vmdc"),
        Text(
          extent={{56,-10},{92,-26}},
          textColor={0,0,0},
          textString="mdc"),
        Text(
          extent={{-40,40},{40,-40}},
          textColor={0,0,0},
          textString="DC
Current
Controller")}),                                                  Diagram(
        coordinateSystem(preserveAspectRatio=false, grid={2,2})));
end DCcurrentControl;
