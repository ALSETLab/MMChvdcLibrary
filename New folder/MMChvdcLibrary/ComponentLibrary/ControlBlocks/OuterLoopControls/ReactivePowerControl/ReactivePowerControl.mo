within MMChvdcLibrary.ComponentLibrary.ControlBlocks.OuterLoopControls.ReactivePowerControl;
model ReactivePowerControl
  "Reactive power control block takes the AC reactive power reference as input and provides reference AC q-axis current"
  Modelica.Blocks.Math.Add add(k2=-1)
    annotation (Placement(transformation(extent={{-46,12},{-26,32}})));
  OpenIPSL.NonElectrical.Nonlinear.Div0block
                                div0block
    annotation (Placement(transformation(extent={{42,6},{62,26}})));
  Modelica.Blocks.Continuous.Integrator
                                integrator(
    k=k,
    initType=initType,
    y_start=y_start)
    annotation (Placement(transformation(extent={{-2,12},{18,32}})));
  Modelica.Blocks.Interfaces.RealInput Qac_ref
    "Reference AC Reactive Power"
    annotation (Placement(transformation(extent={{-140,40},{-100,80}}),
        iconTransformation(extent={{-140,40},{-100,80}})));
  Modelica.Blocks.Interfaces.RealInput Qac "AC Reactive Power"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.RealInput Vgd "AC Voltage of the d-axis"
                                           annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={-120,-60}), iconTransformation(extent={{-140,-80},{-100,-40}})));
  Modelica.Blocks.Interfaces.RealOutput igq_ref
    "Reference AC Current of the q-axis"
    annotation (Placement(transformation(extent={{100,-10},{120,10}}),
        iconTransformation(extent={{100,-10},{120,10}})));
  parameter Real k=k "Integrator gain"
    annotation (Dialog(group="Integrator Parameters"));
  parameter Modelica.Blocks.Types.Init initType=initType
    "Type of initialization (1: no init, 2: steady state, 3,4: initial output)"
    annotation (Dialog(group="Integrator Parameters"));
  parameter Real y_start=y_start
    "Initial or guess value of output (= state)"
    annotation (Dialog(group="Integrator Parameters"));
  Modelica.Blocks.Math.Gain gain(k=1)   annotation (
    Placement(visible = true, transformation(origin={84,0},         extent={{-6,-6},
            {6,6}},                                                                                  rotation=0)));
equation
  connect(Qac_ref, add.u1) annotation (Line(points={{-120,60},{-56,60},{-56,28},
          {-48,28}}, color={0,0,127}));
  connect(Qac, add.u2) annotation (Line(points={{-120,0},{-56,0},{-56,16},{-48,
          16}}, color={0,0,127}));
  connect(Vgd, div0block.u2) annotation (Line(points={{-120,-60},{32,-60},{32,
          10},{40,10}},          color={0,0,127}));
  connect(add.y, integrator.u)
    annotation (Line(points={{-25,22},{-4,22}}, color={0,0,127}));
  connect(div0block.u1, integrator.y)
    annotation (Line(points={{40,22},{19,22}}, color={0,0,127}));
  connect(igq_ref, gain.y)
    annotation (Line(points={{110,0},{90.6,0}}, color={0,0,127}));
  connect(div0block.y, gain.u) annotation (Line(points={{63,16},{70,16},{70,0},
          {76.8,0}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,0},
          lineThickness=0.5),
        Text(
          extent={{-94,66},{-62,54}},
          textColor={0,0,0},
          textString="Qac_ref"),
        Text(
          extent={{-100,4},{-70,-6}},
          textColor={0,0,0},
          textString="Qac"),
        Text(
          extent={{-104,-56},{-70,-66}},
          textColor={0,0,0},
          textString="Vgd"),
        Text(
          extent={{76,4},{94,-4}},
          textColor={0,0,0},
          textString="igq_ref"),
        Text(
          extent={{-54,28},{54,-28}},
          textColor={0,0,0},
          textString="Reactive
Power
Controller")}),                                                  Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end ReactivePowerControl;
