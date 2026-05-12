within MMChvdcLibrary.ComponentLibrary.ControlBlocks.OuterLoopControls.DCvoltageControl;
model DCvotlageControl
  "DC voltage controller that generates reference AC d-axis current and reference AC power"
  Modelica.Blocks.Math.Add add(k1=+1, k2=-1)
    annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
  OpenIPSL.NonElectrical.Nonlinear.Div0block
                                div0block
    annotation (Placement(transformation(extent={{60,-10},{80,10}})));
  Modelica.Blocks.Continuous.PI PI(
    k=k,
    T=T,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    x_start=x_start,
    y_start=y_start)
    annotation (Placement(transformation(extent={{-40,20},{-20,40}})));
  Modelica.Blocks.Interfaces.RealInput Vdc_ref "Reference DC Voltage"
    annotation (Placement(transformation(extent={{-140,40},{-100,80}}),
        iconTransformation(extent={{-140,40},{-100,80}})));
  Modelica.Blocks.Interfaces.RealInput Vdc "DC Voltage"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}}),
        iconTransformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.RealInput Vgd "AC Voltage of the d-axis"
                                           annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={-120,-60}), iconTransformation(extent={{-140,-80},{-100,
            -40}})));
  Modelica.Blocks.Interfaces.RealOutput igd_ref
    "Reference AC current of the d-axis"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  parameter Real k=1 "Gain"
    annotation (Dialog(group="PI Controllers Parameters"));
  parameter Modelica.Units.SI.Time T "Time Constant (T>0 required)"
    annotation (Dialog(group="PI Controllers Parameters"));
  parameter Modelica.Blocks.Types.Init initType=Modelica.Blocks.Types.Init.NoInit
    "Type of initialization (1: no init, 2: steady state, 3: initial state, 4: initial output)"
    annotation (Dialog(group="PI Controllers Parameters"));
  parameter Real x_start "Initial or guess value of state"
    annotation (Dialog(group="PI Controllers Parameters"));
  parameter Real y_start "Initial value of output"
    annotation (Dialog(group="PI Controllers Parameters"));
  Modelica.Blocks.Math.Add add1(k1=+1, k2=-1)
    annotation (Placement(transformation(extent={{0,26},{20,46}})));
  Modelica.Blocks.Sources.Constant Pref(k=0)
    annotation (Placement(transformation(extent={{-60,70},{-46,84}})));
equation
  connect(Vgd, div0block.u2) annotation (Line(points={{-120,-60},{40,-60},{40,-6},
          {58,-6}},              color={0,0,127}));
  connect(div0block.y,igd_ref)
    annotation (Line(points={{81,0},{110,0}}, color={0,0,127}));
  connect(Vdc_ref, add.u1) annotation (Line(points={{-120,60},{-94,60},{-94,36},
          {-82,36}},color={0,0,127}));
  connect(Vdc, add.u2) annotation (Line(points={{-120,0},{-94,0},{-94,24},{-82,
          24}},
        color={0,0,127}));
  connect(add1.u1, Pref.y) annotation (Line(points={{-2,42},{-16,42},{-16,60},{
          -40,60},{-40,77},{-45.3,77}},
                               color={0,0,127}));
  connect(add.y, PI.u)
    annotation (Line(points={{-59,30},{-42,30}}, color={0,0,127}));
  connect(PI.y, add1.u2)
    annotation (Line(points={{-19,30},{-2,30}}, color={0,0,127}));
  connect(add1.y, div0block.u1)
    annotation (Line(points={{21,36},{40,36},{40,6},{58,6}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false,
          initialScale=1.5),                                    graphics={
        Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,0},
          lineThickness=0.5),
        Text(
          extent={{-96,6},{-62,-8}},
          textColor={0,0,0},
          textString="Vdc"),
        Text(
          extent={{-90,68},{-60,54}},
          textColor={0,0,0},
          textString="Vdc_ref"),
        Text(
          extent={{-96,-54},{-58,-68}},
          textColor={0,0,0},
          textString="Vgd"),
        Text(
          extent={{50,-30},{84,-56}},
          textColor={0,0,0},
          textString="igd_ref"),
        Text(
          extent={{-30,28},{22,-20}},
          textColor={0,0,0},
          textString="DC
Voltage
Controller"),
        Text(
          extent={{50,52},{84,26}},
          textColor={0,0,0},
          textString="Pac_ref")}),                               Diagram(
        coordinateSystem(preserveAspectRatio=false, initialScale=1.5)));
end DCvotlageControl;
