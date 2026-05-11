within MMC_HVDC_AMCONF2026.ComponentLibrary.ControlBlocks.OuterLoopControls.ACvoltageControl;
model dAxisACvoltageControl
  "d axis AC voltage control generates q axis AC reference current"
  Modelica.Blocks.Math.Add add(k2=-1)
    annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
  Modelica.Blocks.Continuous.PI PI(
    k=k,
    T=T,
    initType=initType,
    x_start=x_start,
    y_start=y_start)
    annotation (Placement(transformation(extent={{20,-10},{40,10}})));
  Modelica.Blocks.Interfaces.RealInput Vgd_ref
    "Reference d-axis AC Voltage"
    annotation (Placement(transformation(extent={{-140,40},{-100,80}})));
  Modelica.Blocks.Interfaces.RealInput Vgd "AC d-axis Voltage"
    annotation (Placement(transformation(extent={{-140,-80},{-100,-40}})));
  Modelica.Blocks.Interfaces.RealOutput igq_ref
    "Reference q-axis AC Current"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  parameter Real k=k "Gain"
    annotation (Dialog(group="PI Controller Paramerters"));
  parameter Modelica.Units.SI.Time T=T "Time Constant (T>0 required)"
    annotation (Dialog(group="PI Controller Paramerters"));
  parameter Modelica.Blocks.Types.Init initType=initType
    "Type of initialization (1: no init, 2: steady state, 3: initial state, 4: initial output)"
    annotation (Dialog(group="PI Controller Paramerters"));
  parameter Real x_start=x_start "Initial or guess value of state"
    annotation (Dialog(group="PI Controller Paramerters"));
  parameter Real y_start=y_start "Initial value of output"
    annotation (Dialog(group="PI Controller Paramerters"));
equation
  connect(Vgd_ref,add. u1) annotation (Line(points={{-120,60},{-60,60},{
          -60,6},{-42,6}},
                     color={0,0,127}));
  connect(Vgd,add. u2)
    annotation (Line(points={{-120,-60},{-60,-60},{-60,-6},{-42,-6}},
                                                color={0,0,127}));
  connect(add.y,PI. u)
    annotation (Line(points={{-19,0},{18,0}}, color={0,0,127}));
  connect(PI.y, igq_ref)
    annotation (Line(points={{41,0},{110,0}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Text(
          extent={{-96,74},{-38,46}},
          textColor={0,0,0},
          textString="vgd_ref"),
        Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,0},
          lineThickness=0.5),
        Text(
          extent={{-96,-46},{-34,-72}},
          textColor={0,0,0},
          textString="vgd"),
        Text(
          extent={{-28,12},{28,-18}},
          textColor={0,0,0},
          textString="AC d-axis
Voltage
Control"),
        Text(
          extent={{42,14},{96,-14}},
          textColor={0,0,0},
          textString="igq_ref")}), Diagram(coordinateSystem(
          preserveAspectRatio=false)));
end dAxisACvoltageControl;
