within MMChvdcLibrary.ComponentLibrary.ControlBlocks.OuterLoopControls.ReactivePowerControl;
model ConstantRefReactivePowerControl
  "Reactive power control block takes the AC reactive power reference as input and provides reference AC q-axis current"
  OpenIPSL.NonElectrical.Nonlinear.Div0block
                                div0block
    annotation (Placement(transformation(extent={{28,-10},{48,10}})));
  Modelica.Blocks.Interfaces.RealInput Qac_ref
    "Reference AC Reactive Power"
    annotation (Placement(transformation(extent={{-140,40},{-100,80}}),
        iconTransformation(extent={{-140,40},{-100,80}})));
  Modelica.Blocks.Interfaces.RealInput Vgd "AC Voltage of the d-axis"
                                           annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={-120,-60}), iconTransformation(extent={{-140,-80},{-100,-40}})));
  Modelica.Blocks.Interfaces.RealOutput igq_ref
    "Reference AC Current of the q-axis"
    annotation (Placement(transformation(extent={{100,-10},{120,10}}),
        iconTransformation(extent={{100,-10},{120,10}})));
equation
  connect(Vgd, div0block.u2) annotation (Line(points={{-120,-60},{-30,-60},{-30,
          -6},{26,-6}},          color={0,0,127}));
  connect(div0block.y,igq_ref)  annotation (Line(points={{49,0},{110,0}},
                               color={0,0,127}));
  connect(Qac_ref, div0block.u1) annotation (Line(points={{-120,60},{-30,60},{
          -30,6},{26,6}},                 color={0,0,127}));
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
          textString="Constant
Ref
Reactive
Power
Controller")}),                                                  Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end ConstantRefReactivePowerControl;
