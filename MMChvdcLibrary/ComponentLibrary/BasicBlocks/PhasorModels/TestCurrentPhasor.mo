within MMChvdcLibrary.ComponentLibrary.BasicBlocks.PhasorModels;
model TestCurrentPhasor "Tests Current Phasor Model"
  extends Modelica.Icons.Example;
  CurrentPhasor currentPhasor
    annotation (Placement(transformation(extent={{-40,-40},{40,40}})));
  GroundPhasor groundPhasor annotation (Placement(transformation(extent={{-90,-40},
            {-70,-20}})));
  OpenIPSL.Electrical.Buses.Bus bus(
    v_0=1,
    angle_0=0.5235987755983,
    displayPF=true)
    annotation (Placement(transformation(extent={{48,-10},{68,10}})));
  OpenIPSL.Electrical.Sources.SourceBehindImpedance.VoltageSources.VSource
    vSource1(
    P_0=1000000,
    Q_0=0,
    v_0=1,
    angle_0=0.5235987755983)
    annotation (Placement(transformation(extent={{60,-60},{80,-40}})));
  Modelica.ComplexBlocks.Sources.ComplexStep complexStep(
    height=Complex(re=1, im=1),
    offset=Complex(re=0, im=0),
    startTime=2)
    annotation (Placement(transformation(extent={{-80,40},{-40,80}})));
equation
  connect(currentPhasor.p, groundPhasor.p) annotation (Line(points={{-39.2,0},{
          -80,0},{-80,-20.2}},                color={0,0,255}));
  connect(currentPhasor.n, bus.p) annotation (Line(points={{39.2,-0.8},{58,-0.8},
          {58,0}},                                color={0,0,255}));
  connect(complexStep.y, currentPhasor.i) annotation (Line(points={{-38,60},{0,
          60},{0,29.6}},                 color={85,170,255}));
  connect(bus.p, vSource1.p) annotation (Line(points={{58,0},{84,0},{84,-50},{
          81,-50}}, color={0,0,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, grid={2,2})),
                                                                 Diagram(
        coordinateSystem(preserveAspectRatio=false, grid={2,2})));
end TestCurrentPhasor;
