within MMChvdcLibrary.ComponentLibrary.BasicBlocks.PhasorModels;
model TestGroundPhasor "Tests ground phasor model"
extends Modelica.Icons.Example;
  GroundPhasor groundPhasor
    annotation (Placement(transformation(extent={{34,-74},{86,-20}})));
  OpenIPSL.Electrical.Buses.Bus bus(
    v_0=1,
    angle_0=0.5235987755983,
    displayPF=true)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  inner OpenIPSL.Electrical.SystemBase SysData(S_b=1000000000, fn=50)
    annotation (Placement(transformation(extent={{20,60},{100,100}})));
  OpenIPSL.Electrical.Sources.SourceBehindImpedance.VoltageSources.VSource
    vSource(
    P_0=1000000,
    Q_0=0,
    v_0=1,
    angle_0=0.5235987755983)
    annotation (Placement(transformation(extent={{-82,-10},{-62,10}})));
equation
  connect(bus.p, groundPhasor.p) annotation (Line(points={{0,0},{60,0},{60,
          -20.54}},        color={0,0,255}));
  connect(vSource.p, bus.p)
    annotation (Line(points={{-61,0},{0,0}},     color={0,0,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, grid={2,2})),
                                                                 Diagram(
        coordinateSystem(preserveAspectRatio=false, grid={2,2})));
end TestGroundPhasor;
