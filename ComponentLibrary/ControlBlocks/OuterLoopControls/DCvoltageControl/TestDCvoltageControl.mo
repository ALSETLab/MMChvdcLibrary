within MMC_HVDC_AMCONF2026.ComponentLibrary.ControlBlocks.OuterLoopControls.DCvoltageControl;
model TestDCvoltageControl "Tests the DC voltage controller"
  extends Modelica.Icons.Example;
  Modelica.Blocks.Sources.Constant Vgd(k=1) "d axis AC voltage"
    annotation (Placement(transformation(extent={{-60,-60},{-40,-40}})));
  Modelica.Blocks.Sources.Step Vdc_ref(
    height=4,
    offset=1,
    startTime=2) "Reference DC voltage (pu)"
    annotation (Placement(transformation(extent={{-60,40},{-40,60}})));
  DCvotlageControl     votlageControl(
    k=1,
    T=5,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    x_start=0,
    y_start=0)
    annotation (Placement(transformation(extent={{0,-40},{80,40}})));
  Modelica.Blocks.Sources.Constant Vdc(k=0) "DC voltage"
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
equation
  connect(votlageControl.Vgd, Vgd.y) annotation (Line(points={{-8,-24},{-34,-24},
          {-34,-50},{-39,-50}}, color={0,0,127}));
  connect(votlageControl.Vdc, Vdc.y)
    annotation (Line(points={{-8,0},{-39,0}}, color={0,0,127}));
  connect(votlageControl.Vdc_ref, Vdc_ref.y) annotation (Line(points={{-8,24},{
          -34,24},{-34,50},{-39,50}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, grid={2,2})),
                                                                 Diagram(
        coordinateSystem(preserveAspectRatio=false, grid={2,2})));
end TestDCvoltageControl;
