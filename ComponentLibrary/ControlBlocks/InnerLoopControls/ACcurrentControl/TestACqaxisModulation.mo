within MMC_HVDC_AMCONF2026.ComponentLibrary.ControlBlocks.InnerLoopControls.ACcurrentControl;
model TestACqaxisModulation "Tests the AC q axis modulation"
  extends Modelica.Icons.Example;
  qAxisACcurrentControl aCside_I_Modulation(
    fb=50,
    Xr=0.18,
    L_arm=0.0758,
    Vb=320*1e3,
    MVAb=1000*1e6,
    Kp=1,
    T=5,
    initType=Modelica.Blocks.Types.Init.NoInit)
    annotation (Placement(transformation(extent={{0,-40},{80,40}})));
  Modelica.Blocks.Sources.Constant igd(k=1)
    annotation (Placement(transformation(extent={{-80,-46},{-60,-26}})));
  Modelica.Blocks.Sources.Constant Vceq(k=10)
    annotation (Placement(transformation(extent={{-80,-80},{-60,-60}})));
  Modelica.Blocks.Sources.Step igq_ref(
    height=4,
    offset=1,
    startTime=2)
    annotation (Placement(transformation(extent={{-80,26},{-60,46}})));
  Modelica.Blocks.Sources.Constant igq(k=0)
    annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));
  Modelica.Blocks.Sources.Constant Vgq(k=1)
    annotation (Placement(transformation(extent={{-80,60},{-60,80}})));
equation
  connect(igq.y, aCside_I_Modulation.igq)
    annotation (Line(points={{-59,0},{-8,0}}, color={0,0,127}));
  connect(igq_ref.y, aCside_I_Modulation.igq_ref) annotation (Line(points={{-59,
          36},{-40,36},{-40,16},{-8,16}}, color={0,0,127}));
  connect(Vgq.y, aCside_I_Modulation.vgq) annotation (Line(points={{-59,70},{
          -30,70},{-30,32},{-8,32}}, color={0,0,127}));
  connect(igd.y, aCside_I_Modulation.igd) annotation (Line(points={{-59,-36},{
          -40,-36},{-40,-16},{-8,-16}}, color={0,0,127}));
  connect(Vceq.y, aCside_I_Modulation.Vc_eq) annotation (Line(points={{-59,-70},
          {-30,-70},{-30,-32},{-8,-32}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, grid={2,2})),
                                                                 Diagram(
        coordinateSystem(preserveAspectRatio=false, grid={2,2})));
end TestACqaxisModulation;
