within MMChvdcLibrary.ComponentLibrary.BasicBlocks.PLL;
model Synchronization "Synchronization block"
  parameter Real fb;
Modelica.Blocks.Interfaces.RealInput Vq annotation (Placement(
      visible=true,
      transformation(
        origin={-120,60},
        extent={{-20,-20},{20,20}},
        rotation=0),
      iconTransformation(
        origin={-120,60},
        extent={{-20,-20},{20,20}},
        rotation=0)));
  Modelica.Blocks.Math.Add add(k2=+1)
    annotation (Placement(transformation(extent={{48,30},{68,50}})));
Modelica.Blocks.Interfaces.RealInput f_ref annotation (Placement(
      visible=true,
      transformation(
        origin={-120,-60},
        extent={{-20,-20},{20,20}},
        rotation=0),
      iconTransformation(
        origin={-120,-60},
        extent={{-20,-20},{20,20}},
        rotation=0)));
  Modelica.Blocks.Interfaces.RealOutput theta "rad/sec"
    annotation (Placement(transformation(extent={{100,30},{120,50}})));
  Modelica.Blocks.Interfaces.RealOutput freqHZ
    annotation (Placement(transformation(extent={{100,-50},{120,-30}})));

  SRFpLL sRF_PLL(
    fb=fb,
    k_filt=k_filt,
    T_filt=T_filt,
    initType_filt=initType_filt,
    y_start_filt=y_start_filt,
    k_pi=k_pi,
    T_pi=T_pi,
    initType_pi=initType_pi,
    x_start_pi=x_start_pi,
    y_start_pi=y_start_pi,
    k_i=k_i,
    initType_i=initType_i,
    y_start_i=y_start_i)
    annotation (Placement(transformation(extent={{-68,-30},{-6,28}})));
Modelica.Blocks.Interfaces.RealInput theta_ref annotation (Placement(
      visible=true,
      transformation(
        origin={0,120},
        extent={{-20,-20},{20,20}},
        rotation=270),
      iconTransformation(
        origin={0,120},
        extent={{-20,-20},{20,20}},
        rotation=270)));
  parameter Real k_filt "Gain"
    annotation (Dialog(group="1st order filter parameter"));
  parameter Modelica.Units.SI.Time T_filt "Time Constant"
    annotation (Dialog(group="1st order filter parameter"));
  parameter Modelica.Blocks.Types.Init initType_filt=Modelica.Blocks.Types.Init.NoInit
    "Type of initialization (1: no init, 2: steady state, 3/4: initial output)"
    annotation (Dialog(group="1st order filter parameter"));
  parameter Real y_start_filt "Initial or guess value of output (= state)"
    annotation (Dialog(group="1st order filter parameter"));
  parameter Real k_pi "Gain"
    annotation (Dialog(group="PI Controller Parameter"));
  parameter Modelica.Units.SI.Time T_pi "Time Constant (T>0 required)"
    annotation (Dialog(group="PI Controller Parameter"));
  parameter Modelica.Blocks.Types.Init initType_pi=Modelica.Blocks.Types.Init.NoInit
    "Type of initialization (1: no init, 2: steady state, 3: initial state, 4: initial output)"
    annotation (Dialog(group="PI Controller Parameter"));
  parameter Real x_start_pi "Initial or guess value of state"
    annotation (Dialog(group="PI Controller Parameter"));
  parameter Real y_start_pi "Initial value of output"
    annotation (Dialog(group="PI Controller Parameter"));
  parameter Real k_i "Integrator gain"
    annotation (Dialog(group="Integral parameter"));
  parameter Modelica.Blocks.Types.Init initType_i=Modelica.Blocks.Types.Init.InitialState
    "Type of initialization (1: no init, 2: steady state, 3,4: initial output)"
    annotation (Dialog(group="Integral parameter"));
  parameter Real y_start_i "Initial or guess value of output (= state)"
    annotation (Dialog(group="Integral parameter"));
equation
  connect(sRF_PLL.Vq, Vq) annotation (Line(points={{-74.2,16.4},{-74.2,16},{-90,
          16},{-90,60},{-120,60}}, color={0,0,127}));
  connect(f_ref, sRF_PLL.f_ref) annotation (Line(points={{-120,-60},{-90,-60},{-90,
          -18},{-74.2,-18},{-74.2,-18.4}}, color={0,0,127}));
  connect(add.u1, theta_ref)
    annotation (Line(points={{46,46},{36,46},{36,62},{0,62},{0,120}},
                                                      color={0,0,127}));
  connect(sRF_PLL.theta, add.u2) annotation (Line(points={{-2.9,10.6},{38,
          10.6},{38,34},{46,34}},
                            color={0,0,127}));
  connect(sRF_PLL.freqHZ, freqHZ) annotation (Line(points={{-2.9,-12.6},{96,-12.6},
          {96,-40},{110,-40}}, color={0,0,127}));
  connect(add.y, theta)
    annotation (Line(points={{69,40},{110,40}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,0},
          lineThickness=0.5),
        Text(
          extent={{-60,12},{60,-10}},
          textColor={0,0,0},
          textString="Synchronization"),
        Text(
          extent={{-86,70},{-56,48}},
          textColor={0,0,0},
          textString="Vq"),
        Text(
          extent={{-82,-44},{-42,-76}},
          textColor={0,0,0},
          textString="f_ref"),
        Text(
          extent={{36,56},{90,30}},
          textColor={0,0,0},
          textString="theta"),
        Text(
          extent={{40,-26},{86,-50}},
          textColor={0,0,0},
          textString="f_Hz"),
        Text(
          extent={{-40,94},{40,70}},
          textColor={0,0,0},
          textString="theta_ref")}),                             Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Synchronization;
