within MMC_HVDC_AMCONF2026.ComponentLibrary.BasicBlocks.PLL;
model TestSRFpLL "Tests the synchronous reference frame PLL"
  extends Modelica.Icons.Example;
  SRFpLL sRF_PLL(
    fb=50,
    k_filt=10,
    T_filt=0.0001,
    initType_filt=Modelica.Blocks.Types.Init.InitialOutput,
    y_start_filt=10,
    k_pi=(2*0.707)/(2*Modelica.Constants.pi*50*0.0005),
    T_pi=0.0005,
    initType_pi=Modelica.Blocks.Types.Init.InitialOutput,
    y_start_pi=90.018,
    x_start_pi=0,
    k_i=1.5,
    initType_i=Modelica.Blocks.Types.Init.InitialOutput,
    y_start_i=10)
    annotation (Placement(transformation(extent={{-16,-24},{38,24}})));
  Modelica.Blocks.Sources.Constant const(k=50)
    annotation (Placement(transformation(extent={{-60,-40},{-40,-20}})));
  Modelica.Blocks.Sources.Step     step(height=0.1, offset=1.0,
    startTime=1)
    annotation (Placement(transformation(extent={{-60,20},{-40,40}})));
equation
  connect(sRF_PLL.f_ref, const.y) annotation (Line(points={{-21.4,-14.4},{-26,
          -14.4},{-26,-14},{-32,-14},{-32,-30},{-39,-30}},
                                      color={0,0,127}));
  connect(sRF_PLL.Vq, step.y) annotation (Line(points={{-21.4,14.4},{-32,14.4},
          {-32,30},{-39,30}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=10, __Dymola_Algorithm="Dassl"));
end TestSRFpLL;
