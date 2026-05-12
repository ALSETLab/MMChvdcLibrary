within MMChvdcLibrary.ComponentLibrary.BasicBlocks.Tranformation;
model SItoPU

    parameter Real Vb = Vb  "Line-to-Line AC voltage base power (kV)" annotation (
    Dialog(group = "Base values"));
    parameter Real MVAb = MVAb "Converter rated power (MVA)" annotation (
    Dialog(group = "Base values"));
    parameter Real Vdcb = Vdcb "Base DC voltage (kV)" annotation (
    Dialog(group = "Base values"));
  Modelica.Blocks.Math.Gain gain5(k=sqrt(3)/(Vb*1000))       annotation (
    Placement(visible = true, transformation(origin={0,12},       extent={{-8,-8},
            {8,8}},                                                                            rotation = -90)));
  Modelica.Blocks.Math.Gain gain1(k=sqrt(3)/(Vb*1000))       annotation (
    Placement(visible = true, transformation(origin={40,12},      extent={{-8,-8},
            {8,8}},                                                                            rotation = -90)));
  Modelica.Blocks.Math.Gain gain3(k=sqrt(3)*Vb/(1000*MVAb))         annotation (
    Placement(visible = true, transformation(origin={80,12},      extent={{-8,-8},
            {8,8}},                                                                            rotation = -90)));
  Modelica.Blocks.Math.Gain gain2(k=sqrt(3)*Vb/(1000*MVAb))         annotation (
    Placement(visible = true, transformation(origin={120,12},     extent={{-8,-8},
            {8,8}},                                                                            rotation = -90)));
  Modelica.Blocks.Math.Gain gain17(k=1/(Vdcb*1E3))
                                                  annotation (
    Placement(visible = true, transformation(origin={-50,14},     extent={{8,-8},{
            -8,8}},                                                                                rotation=90)));
  Modelica.Blocks.Math.Gain gain14(k=(Vdcb*1E3)/(MVAb*1E6))
                                                  annotation (
    Placement(visible = true, transformation(origin={-100,12},    extent={{8,-8},{
            -8,8}},                                                                                rotation=90)));
  Modelica.Blocks.Math.Gain gain10(k=1/(Vdcb*1E3))
                                                  annotation (
    Placement(visible = true, transformation(origin={-140,12},    extent={{8,-8},{
            -8,8}},                                                                                rotation=90)));
Modelica.Blocks.Interfaces.RealInput Vdc_SI annotation (Placement(
      visible=true,
      transformation(
        origin={-140,60},
        extent={{-20,-20},{20,20}},
        rotation=-90),
      iconTransformation(
        origin={-52,24},
        extent={{-4,-4},{4,4}},
        rotation=-90)));
Modelica.Blocks.Interfaces.RealInput Idc_SI annotation (Placement(
      visible=true,
      transformation(
        origin={-100,60},
        extent={{-20,-20},{20,20}},
        rotation=-90),
      iconTransformation(
        origin={-36,24},
        extent={{-4,-4},{4,4}},
        rotation=-90)));
Modelica.Blocks.Interfaces.RealOutput Vdc_pu annotation (Placement(
      visible=true,
      transformation(
        origin={-140,-60},
        extent={{-20,-20},{20,20}},
        rotation=270),
      iconTransformation(
        origin={-52,-24},
        extent={{-4,4},{4,-4}},
        rotation=270)));
Modelica.Blocks.Interfaces.RealInput Vceq_SI annotation (Placement(
      visible=true,
      transformation(
        origin={-50,60},
        extent={{-20,-20},{20,20}},
        rotation=-90),
      iconTransformation(
        origin={-18,24},
        extent={{-4,-4},{4,4}},
        rotation=-90)));
Modelica.Blocks.Interfaces.RealInput Vgi_SI annotation (Placement(
      visible=true,
      transformation(
        origin={40,60},
        extent={{-20,-20},{20,20}},
        rotation=-90),
      iconTransformation(
        origin={18,24},
        extent={{-4,-4},{4,4}},
        rotation=-90)));
Modelica.Blocks.Interfaces.RealInput Vgr_SI annotation (Placement(
      visible=true,
      transformation(
        origin={0,60},
        extent={{-20,-20},{20,20}},
        rotation=-90),
      iconTransformation(
        origin={-8.88178e-16,24},
        extent={{-4,-4},{4,4}},
        rotation=-90)));
Modelica.Blocks.Interfaces.RealInput Igr_SI annotation (Placement(
      visible=true,
      transformation(
        origin={80,60},
        extent={{-20,-20},{20,20}},
        rotation=-90),
      iconTransformation(
        origin={36,24},
        extent={{-4,-4},{4,4}},
        rotation=-90)));
Modelica.Blocks.Interfaces.RealInput Igi_SI annotation (Placement(
      visible=true,
      transformation(
        origin={120,60},
        extent={{-20,-20},{20,20}},
        rotation=-90),
      iconTransformation(
        origin={52,24},
        extent={{-4,-4},{4,4}},
        rotation=-90)));
Modelica.Blocks.Interfaces.RealOutput Idc_pu annotation (Placement(
      visible=true,
      transformation(
        origin={-100,-60},
        extent={{-20,-20},{20,20}},
        rotation=270),
      iconTransformation(
        origin={-36,-24},
        extent={{-4,-4},{4,4}},
        rotation=270)));
Modelica.Blocks.Interfaces.RealOutput Vceq_pu annotation (Placement(
      visible=true,
      transformation(
        origin={-50,-60},
        extent={{-20,-20},{20,20}},
        rotation=270),
      iconTransformation(
        origin={-18,-24},
        extent={{-4,-4},{4,4}},
        rotation=270)));
Modelica.Blocks.Interfaces.RealOutput Vgi_pu annotation (Placement(
      visible=true,
      transformation(
        origin={40,-60},
        extent={{-20,-20},{20,20}},
        rotation=270),
      iconTransformation(
        origin={18,-24},
        extent={{-4,-4},{4,4}},
        rotation=270)));
Modelica.Blocks.Interfaces.RealOutput Vgr_pu annotation (Placement(
      visible=true,
      transformation(
        origin={0,-60},
        extent={{-20,-20},{20,20}},
        rotation=270),
      iconTransformation(
        origin={4.44089e-16,-24},
        extent={{-4,-4},{4,4}},
        rotation=270)));
Modelica.Blocks.Interfaces.RealOutput Igr_pu annotation (Placement(
      visible=true,
      transformation(
        origin={80,-60},
        extent={{-20,-20},{20,20}},
        rotation=270),
      iconTransformation(
        origin={36,-24},
        extent={{-4,-4},{4,4}},
        rotation=270)));
Modelica.Blocks.Interfaces.RealOutput Igi_pu annotation (Placement(
      visible=true,
      transformation(
        origin={120,-60},
        extent={{-20,-20},{20,20}},
        rotation=270),
      iconTransformation(
        origin={52,-24},
        extent={{-4,-4},{4,4}},
        rotation=270)));

equation
  connect(gain10.u,Vdc_SI)  annotation (Line(points={{-140,21.6},{-140,60}},
                             color={0,0,127}));
  connect(gain10.y,Vdc_pu)  annotation (Line(points={{-140,3.2},{-140,-60}},
                                color={0,0,127}));
  connect(gain14.u,Idc_SI)  annotation (Line(points={{-100,21.6},{-100,60}},
                            color={0,0,127}));
  connect(gain14.y,Idc_pu)  annotation (Line(points={{-100,3.2},{-100,-60}},
                               color={0,0,127}));
  connect(gain17.u,Vceq_SI)  annotation (Line(points={{-50,23.6},{-50,60}},
                            color={0,0,127}));
  connect(gain17.y,Vceq_pu)  annotation (Line(points={{-50,5.2},{-50,-60}},
                                   color={0,0,127}));
  connect(gain5.u,Vgr_SI)  annotation (Line(points={{0,21.6},{0,60}},
                     color={0,0,127}));
  connect(gain5.y,Vgr_pu)  annotation (Line(points={{0,3.2},{0,-60}},
        color={0,0,127}));
  connect(gain1.u,Vgi_SI)  annotation (Line(points={{40,21.6},{40,60}},
                     color={0,0,127}));
  connect(gain1.y,Vgi_pu)  annotation (Line(points={{40,3.2},{40,-60}},
                      color={0,0,127}));
  connect(gain3.u,Igr_SI)  annotation (Line(points={{80,21.6},{80,60}},
                      color={0,0,127}));
  connect(gain3.y,Igr_pu)  annotation (Line(points={{80,3.2},{80,-60}},
                               color={0,0,127}));
  connect(gain2.u,Igi_SI)  annotation (Line(points={{120,21.6},{120,60}},
                      color={0,0,127}));
  connect(gain2.y,Igi_pu)  annotation (Line(points={{120,3.2},{120,-60}},
                               color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-60,-20},
            {60,20}}),   graphics={
        Rectangle(
          extent={{-60,20},{60,-20}},
          lineColor={0,0,0},
          lineThickness=0.5),
        Text(
          extent={{-6,3},{6,-3}},
          textColor={0,0,0},
          textString="Vdc",
          origin={-51,0},
          rotation=90),
        Text(
          extent={{-6,3},{6,-3}},
          textColor={0,0,0},
          origin={-37,0},
          rotation=90,
          textString="Idc"),
        Text(
          extent={{-8,3},{8,-3}},
          textColor={0,0,0},
          origin={-19,0},
          rotation=90,
          textString="Vceq"),
        Text(
          extent={{-6,3},{6,-3}},
          textColor={0,0,0},
          origin={17,0},
          rotation=90,
          textString="VgI"),
        Text(
          extent={{-10,4},{6,-2}},
          textColor={0,0,0},
          rotation=90,
          textString="VgR"),
        Text(
          extent={{-5,3},{5,-3}},
          textColor={0,0,0},
          origin={51,-1},
          rotation=90,
          textString="igI"),
        Text(
          extent={{-6,3},{6,-3}},
          textColor={0,0,0},
          origin={35,0},
          rotation=90,
          textString="igR")}), Diagram(coordinateSystem(preserveAspectRatio=false,
          extent={{-160,-40},{140,40}})));
end SItoPU;
