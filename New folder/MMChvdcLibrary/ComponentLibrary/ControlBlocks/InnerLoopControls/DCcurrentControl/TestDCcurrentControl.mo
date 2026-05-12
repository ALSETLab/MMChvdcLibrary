within MMChvdcLibrary.ComponentLibrary.ControlBlocks.InnerLoopControls.DCcurrentControl;
model TestDCcurrentControl "Tests the DC current controller"
  extends Modelica.Icons.Example;
  DCcurrentControl dCsideModulation(
    k=1,
    T=0.004/3,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    x_start=2.53125*1e-4)
    annotation (Placement(transformation(extent={{0,-40},{80,40}})));
  Modelica.Blocks.Sources.Constant Vdc(k=1)
    annotation (Placement(transformation(extent={{-80,-40},{-60,-20}})));
  Modelica.Blocks.Sources.Constant Vceq(k=1)
    annotation (Placement(transformation(extent={{-80,-80},{-60,-60}})));
  Modelica.Blocks.Sources.Step Idc_ref(
    height=0.2,
    offset=0,
    startTime=1.5)
    annotation (Placement(transformation(extent={{-80,60},{-60,80}})));
  Modelica.Blocks.Sources.Constant Idc(k=0.2001)
    annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
equation
  connect(Vceq.y, dCsideModulation.Vc_eq) annotation (Line(points={{-59,-70},{
          -30,-70},{-30,-24},{-8,-24}},             color={0,0,127}));
  connect(dCsideModulation.idc_ref, Idc_ref.y) annotation (Line(points={{-8,24},
          {-30,24},{-30,70},{-59,70}},         color={0,0,127}));
  connect(dCsideModulation.idc, Idc.y) annotation (Line(points={{-8,8},{-40,8},
          {-40,30},{-59,30}},                  color={0,0,127}));
  connect(Vdc.y, dCsideModulation.Vdc) annotation (Line(points={{-59,-30},{-40,
          -30},{-40,-8},{-8,-8}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, grid={2,2})),
                                                                 Diagram(
        coordinateSystem(preserveAspectRatio=false, grid={2,2})));
end TestDCcurrentControl;
