within MMC_HVDC_AMCONF2026.ComponentLibrary.BasicBlocks.PhasorModels;
model TestBreakerPhasor "Tests the breaker phasor model"
extends Modelica.Icons.Example;
  GroundPhasor groundPhasor
    annotation (Placement(transformation(extent={{70,-40},{90,-20}})));
  OpenIPSL.Electrical.Buses.Bus bus(
    displayPF=true)
    annotation (Placement(transformation(extent={{-26,-10},{-6,10}})));
  inner OpenIPSL.Electrical.SystemBase SysData(S_b=1000000000, fn=50)
    annotation (Placement(transformation(extent={{20,60},{100,100}})));
  OpenIPSL.Electrical.Sources.VoltageSourceReImInput
    voltageSourceReImInput(
    P_0=1000000,
    Q_0=0,
    v_0=1,
    angle_0=0.5235987755983)
    annotation (Placement(transformation(extent={{-44,-10},{-24,10}})));
  Modelica.Blocks.Sources.Constant Vre(k=0.866)
    annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
  Modelica.Blocks.Sources.Constant Vim(k=0.5)
    annotation (Placement(transformation(extent={{-80,-40},{-60,-20}})));
  ResistorPhasor resistor(
    Vb(displayUnit="kV") = 320000,
    R=100,
    displayPF=true)
    annotation (Placement(transformation(extent={{56,-10},{76,10}})));
  Sensor.ACpowerSensor pQ_Sensor
    annotation (Placement(transformation(extent={{-6,-6},{20,6}})));
  BreakerPhasor CB(
    Vb=320000,
    t_o=2,
    rc_enabled=true,
    t_rc=3,
    Ron=1E-9,
    Goff=1E-9) annotation (Placement(transformation(extent={{30,-10},{50,10}})));
equation
  connect(voltageSourceReImInput.p, bus.p)
    annotation (Line(points={{-23,0},{-16,0}},   color={0,0,255}));
  connect(Vre.y, voltageSourceReImInput.vRe) annotation (Line(points={{-59,30},
          {-54,30},{-54,4},{-46,4}}, color={0,0,127}));
  connect(Vim.y, voltageSourceReImInput.vIm) annotation (Line(points={{-59,-30},
          {-54,-30},{-54,-4},{-46,-4}}, color={0,0,127}));
  connect(pQ_Sensor.p, bus.p)
    annotation (Line(points={{-6,0},{-16,0}},    color={0,0,255}));
  connect(resistor.n, groundPhasor.p)
    annotation (Line(points={{77,0},{80,0},{80,-20.2}},     color={0,0,255}));
  connect(CB.r, resistor.p)
    annotation (Line(points={{50,0},{55,0}}, color={0,0,255}));
  connect(CB.s, pQ_Sensor.n)
    annotation (Line(points={{30,0},{20,0}}, color={0,0,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, grid={2,2})),
                                                                 Diagram(
        coordinateSystem(preserveAspectRatio=false, grid={2,2})));
end TestBreakerPhasor;
