within MMC_HVDC_AMCONF2026.ComponentLibrary.ControlBlocks.OuterLoopControls.EnergyControl;
model ConstantRefEnergyControl
  "Energy control block for constant reference input that calculates reference DC current."
  Modelica.Blocks.Math.Add add(k2=-1) "Addition"
    annotation (Placement(transformation(extent={{-70,-10},{-50,10}})));
  OpenIPSL.NonElectrical.Nonlinear.Div0block
                                div0block "Division"
    annotation (Placement(transformation(extent={{68,-10},{88,10}})));
  Modelica.Blocks.Continuous.PI PI(
    k=k,
    T=T,
    initType=initType,
    x_start=x_start,
    y_start=y_start) "PI Controller"
    annotation (Placement(transformation(extent={{-28,-10},{-8,10}})));
  Modelica.Blocks.Math.Add add1(k2=+1) "Addition"
    annotation (Placement(transformation(extent={{16,-16},{36,4}})));
  Modelica.Blocks.Interfaces.RealInput Vdc "DC Voltage"
    annotation (Placement(transformation(extent={{-140,60},{-100,100}}),
        iconTransformation(extent={{-140,60},{-100,100}})));
  Modelica.Blocks.Interfaces.RealInput Wtot "Total Energy"
    annotation (Placement(transformation(extent={{-140,-46},{-100,-6}}),
        iconTransformation(extent={{-140,-46},{-100,-6}})));
  Modelica.Blocks.Interfaces.RealInput Pac "AC Active Power"
                                           annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={-120,-70}), iconTransformation(extent={{-140,-100},{-100,-60}})));
  Modelica.Blocks.Interfaces.RealOutput idc_ref "Reference DC Current"
    annotation (Placement(transformation(extent={{100,-10},{120,10}}),
        iconTransformation(extent={{100,-10},{120,10}})));
  Modelica.Blocks.Interfaces.RealInput Wref "Energy Reference"
    annotation (Placement(transformation(extent={{-140,6},{-100,46}}),
        iconTransformation(extent={{-140,6},{-100,46}})));
  parameter Real k=1 "Gain"
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
  connect(Wtot, add.u2) annotation (Line(points={{-120,-26},{-82,-26},{
          -82,-6},{-72,-6}},
                    color={0,0,127}));
  connect(add.y,PI. u)
    annotation (Line(points={{-49,0},{-30,0}},  color={0,0,127}));
  connect(div0block.y,idc_ref)  annotation (Line(points={{89,0},{110,0}},
                                    color={0,0,127}));
  connect(PI.y, add1.u1)
    annotation (Line(points={{-7,0},{14,0}},     color={0,0,127}));
  connect(div0block.u1, add1.y) annotation (Line(points={{66,6},{42,6},{
          42,-6},{37,-6}},      color={0,0,127}));
  connect(Pac, add1.u2) annotation (Line(points={{-120,-70},{6,-70},{6,
          -12},{14,-12}},
               color={0,0,127}));
  connect(div0block.u2, Vdc) annotation (Line(points={{66,-6},{50,-6},{50,
          70},{-120,70}},    color={0,0,127}));
  connect(Wref, add.u1) annotation (Line(points={{-120,26},{-82,26},{-82,
          6},{-72,6}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,0},
          lineThickness=0.5),
        Text(
          extent={{-102,90},{-58,72}},
          textColor={0,0,0},
          textString="Vdc"),
        Text(
          extent={{-98,38},{-56,20}},
          textColor={0,0,0},
          textString="Wref"),
        Text(
          extent={{-100,-18},{-56,-36}},
          textColor={0,0,0},
          textString="Wtot"),
        Text(
          extent={{-102,-70},{-58,-88}},
          textColor={0,0,0},
          textString="Pac"),
        Text(
          extent={{52,10},{96,-8}},
          textColor={0,0,0},
          textString="idc_ref"),
        Text(
          extent={{-38,40},{30,-50}},
          textColor={0,0,0},
          textString="Constant
Ref
Energy
Controller")}),                                                  Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end ConstantRefEnergyControl;
