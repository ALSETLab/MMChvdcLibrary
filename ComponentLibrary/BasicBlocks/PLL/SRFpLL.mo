within MMC_HVDC_AMCONF2026.ComponentLibrary.BasicBlocks.PLL;
model SRFpLL "Synchronous reference frame PLL"
  parameter Real fb "System base frequency";
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
    annotation (Placement(transformation(extent={{34,-50},{54,-30}})));
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
  Modelica.Blocks.Math.Gain gain1(k=2*Modelica.Constants.pi*fb)
                                           annotation(Placement(visible = true, transformation(origin={50,40},     extent = {{-10, -10}, {10, 10}}, rotation=0)));
  Modelica.Blocks.Interfaces.RealOutput theta "rad/sec"
    annotation (Placement(transformation(extent={{100,30},{120,50}})));
  Modelica.Blocks.Interfaces.RealOutput freqHZ
    annotation (Placement(transformation(extent={{100,-50},{120,-30}})));

  Modelica.Blocks.Continuous.FirstOrder firstOrder(
    k=k_filt,
    T=T_filt,
    initType=initType_filt,
    y_start=y_start_filt)
    annotation (Placement(transformation(extent={{-92,50},{-72,70}})));
  Modelica.Blocks.Math.Add add1(k1=-1, k2=+1)
    annotation (Placement(transformation(extent={{-46,30},{-26,50}})));
  Modelica.Blocks.Continuous.PI PI(
    k=k_pi,
    T=T_pi,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    x_start=x_start_pi,
    y_start=y_start_pi)
    annotation (Placement(transformation(extent={{-10,30},{10,50}})));
  Modelica.Blocks.Continuous.Integrator integrator(
    k=k_i,
    initType=initType_i,
    y_start=y_start_i)
    annotation (Placement(transformation(extent={{68,30},{88,50}})));
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
  parameter Real y_start_pi "Initial value of output"
    annotation (Dialog(group="PI Controller Parameter"));
  parameter Real x_start_pi "Initial or guess value of state"
    annotation (Dialog(group="PI Controller Parameter"));
  parameter Real k_i "Integrator gain"
    annotation (Dialog(group="Integral parameter"));
  parameter Modelica.Blocks.Types.Init initType_i=Modelica.Blocks.Types.Init.InitialState
    "Type of initialization (1: no init, 2: steady state, 3,4: initial output)"
    annotation (Dialog(group="Integral parameter"));
  parameter Real y_start_i "Initial or guess value of output (= state)"
    annotation (Dialog(group="Integral parameter"));
equation
  connect(f_ref, add.u2) annotation (Line(points={{-120,-60},{24,-60},{24,-46},{
          32,-46}},      color={0,0,127}));
  connect(freqHZ, add.y) annotation (Line(points={{110,-40},{55,-40}},
                   color={0,0,127}));
  connect(Vq, firstOrder.u)
    annotation (Line(points={{-120,60},{-94,60}}, color={0,0,127}));
  connect(firstOrder.y, add1.u2) annotation (Line(points={{-71,60},{-66,60},{-66,
          34},{-48,34}}, color={0,0,127}));
  connect(add1.y, PI.u)
    annotation (Line(points={{-25,40},{-12,40}}, color={0,0,127}));
  connect(gain1.u, PI.y)
    annotation (Line(points={{38,40},{11,40}}, color={0,0,127}));
  connect(add.u1, PI.y) annotation (Line(points={{32,-34},{24,-34},{24,40},{11,40}},
        color={0,0,127}));
  connect(theta, integrator.y)
    annotation (Line(points={{110,40},{89,40}}, color={0,0,127}));
  connect(gain1.y, integrator.u)
    annotation (Line(points={{61,40},{66,40}}, color={0,0,127}));
  connect(add1.u1, integrator.y) annotation (Line(points={{-48,46},{-52,46},{-52,
          66},{94,66},{94,40},{89,40}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,0},
          lineThickness=0.5),
        Text(
          extent={{-20,20},{20,-20}},
          textColor={0,0,0},
          textString="SRF
PLL"),  Text(
          extent={{-84,70},{-48,42}},
          textColor={0,0,0},
          textString="Vq"),
        Text(
          extent={{-88,-40},{-32,-84}},
          textColor={0,0,0},
          textString="f_ref"),
        Text(
          extent={{34,56},{92,26}},
          textColor={0,0,0},
          textString="theta"),
        Text(
          extent={{48,-22},{90,-58}},
          textColor={0,0,0},
          textString="f_Hz")}),                                  Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end SRFpLL;
