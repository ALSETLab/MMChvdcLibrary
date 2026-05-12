within MMChvdcLibrary.ComponentLibrary.BasicBlocks.Tranformation;
model PUtoSI
    parameter Real Vb = Vb   "Line-to-Line AC voltage base power (kV)" annotation (
    Dialog(group = "Base values"));
    parameter Real Vdcb = Vdcb  "Base DC voltage (kV)" annotation (
    Dialog(group = "Base values"));
  Modelica.Blocks.Math.Gain gain17(k=Vb*1000/sqrt(3))
                                                  annotation (
    Placement(visible = true, transformation(origin={60,6},       extent={{8,-8},{
            -8,8}},                                                                                rotation=90)));
  Modelica.Blocks.Math.Gain gain14(k=Vb*1000/sqrt(3))
                                                  annotation (
    Placement(visible = true, transformation(origin={0,6},        extent={{8,-8},{
            -8,8}},                                                                                rotation=90)));
  Modelica.Blocks.Math.Gain gain10(k=(Vdcb*1E3))  annotation (
    Placement(visible = true, transformation(origin={-60,6},      extent={{8,-8},{
            -8,8}},                                                                                rotation=90)));
Modelica.Blocks.Interfaces.RealInput Vmdc_pu annotation (Placement(
      visible=true,
      transformation(
        origin={-60,60},
        extent={{-20,-20},{20,20}},
        rotation=-90),
      iconTransformation(
        origin={20,26},
        extent={{-6,-6},{6,6}},
        rotation=-90)));
Modelica.Blocks.Interfaces.RealInput Vmr_pu annotation (Placement(
      visible=true,
      transformation(
        origin={0,60},
        extent={{-20,-20},{20,20}},
        rotation=-90),
      iconTransformation(
        origin={0,26},
        extent={{-6,-6},{6,6}},
        rotation=-90)));
Modelica.Blocks.Interfaces.RealOutput Vmdc_SI annotation (Placement(
      visible=true,
      transformation(
        origin={-60,-60},
        extent={{-20,-20},{20,20}},
        rotation=270),
      iconTransformation(
        origin={20,-26},
        extent={{-6,-6},{6,6}},
        rotation=270)));
Modelica.Blocks.Interfaces.RealInput Vmi_pu annotation (Placement(
      visible=true,
      transformation(
        origin={60,60},
        extent={{-20,-20},{20,20}},
        rotation=-90),
      iconTransformation(
        origin={-22,26},
        extent={{-6,-6},{6,6}},
        rotation=-90)));
Modelica.Blocks.Interfaces.RealOutput Vmr_SI annotation (Placement(
      visible=true,
      transformation(
        origin={0,-60},
        extent={{-20,-20},{20,20}},
        rotation=270),
      iconTransformation(
        origin={0,-26},
        extent={{-6,-6},{6,6}},
        rotation=270)));
Modelica.Blocks.Interfaces.RealOutput Vmi_SI annotation (Placement(
      visible=true,
      transformation(
        origin={60,-60},
        extent={{-20,-20},{20,20}},
        rotation=270),
      iconTransformation(
        origin={-20,-26},
        extent={{-6,-6},{6,6}},
        rotation=270)));
equation
  connect(gain10.u,Vmdc_pu)  annotation (Line(points={{-60,15.6},{-60,60}},
                             color={0,0,127}));
  connect(gain10.y,Vmdc_SI)  annotation (Line(points={{-60,-2.8},{-60,-60}},
                                     color={0,0,127}));
  connect(gain14.u,Vmr_pu)  annotation (Line(points={{0,15.6},{0,60}},
                            color={0,0,127}));
  connect(gain14.y,Vmr_SI)  annotation (Line(points={{0,-2.8},{0,-60}},
                               color={0,0,127}));
  connect(gain17.u,Vmi_pu)  annotation (Line(points={{60,15.6},{60,60}},
                            color={0,0,127}));
  connect(gain17.y,Vmi_SI)  annotation (Line(points={{60,-2.8},{60,-60}},
                               color={0,0,127}));
  connect(Vmr_SI,Vmr_SI)  annotation (Line(points={{0,-60},{0,-60}},
                       color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-40,-20},
            {40,20}}),       graphics={
        Rectangle(
          extent={{-40,20},{40,-20}},
          lineColor={0,0,0},
          lineThickness=0.5),
        Text(
          extent={{-7,6},{7,0}},
          textColor={0,0,0},
          textString="Vmdc",
          origin={22,1},
          rotation=90),
        Text(
          extent={{-8.75,-3},{5.25,3}},
          textColor={0,0,0},
          rotation=90,
          textString="VmR",
          origin={1,2.75}),
        Text(
          extent={{-5,-4},{5,4}},
          textColor={0,0,0},
          origin={-20,1},
          rotation=90,
          textString="VmI")}),                                   Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-100,-40},{100,40}})));
end PUtoSI;
