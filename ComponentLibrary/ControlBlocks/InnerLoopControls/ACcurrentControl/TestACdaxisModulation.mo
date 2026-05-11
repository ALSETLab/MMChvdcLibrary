within MMC_HVDC_AMCONF2026.ComponentLibrary.ControlBlocks.InnerLoopControls.ACcurrentControl;
model TestACdaxisModulation "Tests the AC d axis modulation"
  extends Modelica.Icons.Example;
  Modelica.Blocks.Sources.Constant igq(k=1)
    annotation (Placement(transformation(extent={{-80,-46},{-60,-26}})));
  Modelica.Blocks.Sources.Constant Vceq(k=10)
    annotation (Placement(transformation(extent={{-80,-80},{-60,-60}})));
  Modelica.Blocks.Sources.Step igd_ref(
    height=4,
    offset=1,
    startTime=2)
    annotation (Placement(transformation(extent={{-80,26},{-60,46}})));
  dAxisACcurrentControl aCside_R_Modulation(
    fb=50,
    Xr=0.18,
    L_arm=0.0758,
    Vb=320*1e3,
    MVAb=1000*1e6,
    T=5,
    initType=Modelica.Blocks.Types.Init.NoInit,
    Kp=1) annotation (Placement(transformation(extent={{0,-40},{80,40}})));
  Modelica.Blocks.Sources.Constant igd(k=0)
    annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));
  Modelica.Blocks.Sources.Constant Vgd(k=1)
    annotation (Placement(transformation(extent={{-80,60},{-60,80}})));
equation
  connect(Vceq.y, aCside_R_Modulation.Vc_eq) annotation (Line(points={{-59,-70},
          {-30,-70},{-30,-32},{-8,-32}}, color={0,0,127}));
  connect(aCside_R_Modulation.igq, igq.y) annotation (Line(points={{-8,-16},{
          -40,-16},{-40,-36},{-59,-36}}, color={0,0,127}));
  connect(aCside_R_Modulation.igd, igd.y)
    annotation (Line(points={{-8,0},{-59,0}}, color={0,0,127}));
  connect(aCside_R_Modulation.vgd, Vgd.y) annotation (Line(points={{-8,32},{-30,
          32},{-30,70},{-59,70}}, color={0,0,127}));
  connect(aCside_R_Modulation.igd_ref, igd_ref.y) annotation (Line(points={{-8,
          16},{-40,16},{-40,36},{-59,36}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, grid={2,2})),
                                                                 Diagram(
        coordinateSystem(preserveAspectRatio=false, grid={2,2})));
end TestACdaxisModulation;
