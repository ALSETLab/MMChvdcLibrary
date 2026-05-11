within MMC_HVDC_AMCONF2026.ComponentLibrary.ControlBlocks.OuterLoopControls.ActivePowerControl;
model ActivePowerControl
  "Active power control block takes the AC active power reference as input and provides reference AC d-axis current"
  Modelica.Blocks.Math.Add add(k2=-1)
    annotation (Placement(transformation(extent={{-46,-4},{-26,16}})));
  Modelica.Blocks.Interfaces.RealInput Pac_ref
    "Reference AC Active Power"
    annotation (Placement(transformation(extent={{-140,40},{-100,80}})));
  Modelica.Blocks.Interfaces.RealInput Pac "AC Active Power"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  OpenIPSL.NonElectrical.Nonlinear.Div0block
                                div0block
    annotation (Placement(transformation(extent={{42,-10},{62,10}})));
  Modelica.Blocks.Interfaces.RealInput Vgd "AC Voltage of the d-axis"
                                           annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={-120,-60})));
  Modelica.Blocks.Continuous.PI PI(
    k=k,
    T=T,
    initType=initType,
    x_start=x_start,
    y_start=y_start)
    annotation (Placement(transformation(extent={{-2,-4},{18,16}})));
  Modelica.Blocks.Interfaces.RealOutput igd_ref
    "Reference AC current of the d-axis"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  parameter Real k=k "Gain"
    annotation (Dialog(group="PI Controller Parameters"));
  parameter Modelica.Units.SI.Time T "Time Constant (T>0 required)"
    annotation (Dialog(group="PI Controller Parameters"));
  parameter Modelica.Blocks.Types.Init initType=initType
    "Type of initialization (1: no init, 2: steady state, 3: initial state, 4: initial output)"
    annotation (Dialog(group="PI Controller Parameters"));
  parameter Real x_start=0 "Initial or guess value of state"
    annotation (Dialog(group="PI Controller Parameters"));
  parameter Real y_start=0 "Initial value of output"
    annotation (Dialog(group="PI Controller Parameters"));
equation
  connect(Pac_ref, add.u1) annotation (Line(points={{-120,60},{-56,60},{-56,12},
          {-48,12}}, color={0,0,127}));
  connect(Pac, add.u2)
    annotation (Line(points={{-120,0},{-48,0}}, color={0,0,127}));
  connect(Vgd, div0block.u2) annotation (Line(points={{-120,-60},{32,
          -60},{32,-6},{40,-6}}, color={0,0,127}));
  connect(add.y, PI.u)
    annotation (Line(points={{-25,6},{-4,6}}, color={0,0,127}));
  connect(div0block.u1, PI.y)
    annotation (Line(points={{40,6},{19,6}}, color={0,0,127}));
  connect(igd_ref, div0block.y)
    annotation (Line(points={{110,0},{63,0}}, color={0,0,127}));
  annotation (Icon(                                             graphics={
          Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,0},
          lineThickness=0.5), Text(
          extent={{-24,24},{26,-18}},
          textColor={0,0,0},
          textString="Active
Power
Controller"),
        Text(
          extent={{-94,64},{-60,54}},
          textColor={0,0,0},
          textString="Pac_ref"),
        Text(
          extent={{-98,4},{-68,-6}},
          textColor={0,0,0},
          textString="Pac"),
        Text(
          extent={{-98,-56},{-64,-66}},
          textColor={0,0,0},
          textString="Vgd"),
        Text(
          extent={{68,8},{92,-6}},
          textColor={0,0,0},
          textString="igd_ref")}),                 Diagram(coordinateSystem(
          preserveAspectRatio=false)));
end ActivePowerControl;
