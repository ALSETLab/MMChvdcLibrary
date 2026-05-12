within MMChvdcLibrary.ComponentLibrary.ControlBlocks.OuterLoopControls.EnergyControl;
model VariableRefEnergyControl
  "Energy control block that takes the square of the DC voltage as input and calculates reference DC current."
  Modelica.Blocks.Math.Add add(k2=-1)
    annotation (Placement(transformation(extent={{-34,2},{-14,22}})));
  OpenIPSL.NonElectrical.Nonlinear.Div0block
                                div0block
    annotation (Placement(transformation(extent={{86,-10},{106,10}})));
  Modelica.Blocks.Continuous.PI PI(
    k=k,
    T=T,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    x_start=x_start,
    y_start=y_start)
    annotation (Placement(transformation(extent={{-2,2},{18,22}})));
  Modelica.Blocks.Interfaces.RealInput Vdc "DC Voltage"
    annotation (Placement(transformation(extent={{-160,40},{-120,80}}),
        iconTransformation(extent={{-160,40},{-120,80}})));
  Modelica.Blocks.Interfaces.RealInput Wtot "Total Energy"
    annotation (Placement(transformation(extent={{-160,-20},{-120,20}}),
        iconTransformation(extent={{-160,-20},{-120,20}})));
  Modelica.Blocks.Interfaces.RealInput Pac "AC Active Power"
                                           annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={-140,-62}), iconTransformation(extent={{-160,-82},{-120,
            -42}})));
  Modelica.Blocks.Interfaces.RealOutput idc_ref "Reference DC Current"
    annotation (Placement(transformation(extent={{120,-10},{140,10}}),
        iconTransformation(extent={{120,-10},{140,10}})));
  Modelica.Blocks.Math.Product product1
    annotation (Placement(transformation(extent={{-66,8},{-46,28}})));
  Modelica.Blocks.Math.Gain gain(k=1)
    annotation (Placement(transformation(extent={{-106,14},{-86,34}})));
  Modelica.Blocks.Math.Add add1(k2=+1)
    annotation (Placement(transformation(extent={{38,-4},{58,16}})));
  parameter Real k "Gain"
    annotation (Dialog(group="PI Controller Parameters"));
  parameter Modelica.Units.SI.Time T "Time Constant (T>0 required)"
    annotation (Dialog(group="PI Controller Parameters"));
  parameter Modelica.Blocks.Types.Init initType=Modelica.Blocks.Types.Init.InitialOutput
    "Type of initialization (1: no init, 2: steady state, 3: initial state, 4: initial output)"
    annotation (Dialog(group="PI Controller Parameters"));
  parameter Real x_start "Initial or guess value of state"
    annotation (Dialog(group="PI Controller Parameters"));
  parameter Real y_start=0 "Initial value of output"
    annotation (Dialog(group="PI Controller Parameters"));
equation
  connect(Wtot, add.u2) annotation (Line(points={{-140,0},{-44,0},{-44,6},
          {-36,6}},color={0,0,127}));
  connect(add.y,PI. u)
    annotation (Line(points={{-13,12},{-4,12}}, color={0,0,127}));
  connect(div0block.y,idc_ref)  annotation (Line(points={{107,0},{130,0}},
                               color={0,0,127}));
  connect(add.u1, product1.y) annotation (Line(points={{-36,18},{-45,18}},
                         color={0,0,127}));
  connect(Vdc, gain.u)
    annotation (Line(points={{-140,60},{-114,60},{-114,24},{-108,24}},
                                                  color={0,0,127}));
  connect(product1.u1, gain.y)
    annotation (Line(points={{-68,24},{-85,24}}, color={0,0,127}));
  connect(product1.u2, gain.y) annotation (Line(points={{-68,12},{-80,12},
          {-80,24},{-85,24}},
                         color={0,0,127}));
  connect(PI.y, add1.u1)
    annotation (Line(points={{19,12},{36,12}},   color={0,0,127}));
  connect(div0block.u1, add1.y) annotation (Line(points={{84,6},{59,6}},
                              color={0,0,127}));
  connect(Pac, add1.u2) annotation (Line(points={{-140,-62},{26,-62},{26,
          0},{36,0}},
                   color={0,0,127}));
  connect(div0block.u2, Vdc) annotation (Line(points={{84,-6},{74,-6},{74,
          60},{-140,60}},                       color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-120,
            -100},{120,100}},
        grid={2,2},
        initialScale=1.5),     graphics={
        Text(
          extent={{-116,68},{-72,50}},
          textColor={0,0,0},
          textString="Vdc"),
        Rectangle(
          extent={{-120,100},{120,-100}},
          lineColor={0,0,0},
          lineThickness=0.5),
        Text(
          extent={{-114,8},{-70,-10}},
          textColor={0,0,0},
          textString="Wtot"),
        Text(
          extent={{-116,-52},{-72,-70}},
          textColor={0,0,0},
          textString="Pac"),
        Text(
          extent={{72,10},{116,-8}},
          textColor={0,0,0},
          textString="idc_ref"),
        Text(
          extent={{-52,34},{58,-32}},
          textColor={0,0,0},
          textString="Variable
Ref
Energy
Controller")}),                 Diagram(coordinateSystem(preserveAspectRatio=false,
                   extent={{-120,-100},{120,100}},
        grid={2,2},
        initialScale=1.5)));
end VariableRefEnergyControl;
