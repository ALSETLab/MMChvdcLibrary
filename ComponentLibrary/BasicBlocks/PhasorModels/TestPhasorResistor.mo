within MMC_HVDC_AMCONF2026.ComponentLibrary.BasicBlocks.PhasorModels;
model TestPhasorResistor "Tests phasor resistor model"
extends Modelica.Icons.Example;
  GroundPhasor groundPhasor
    annotation (Placement(transformation(extent={{44,-72},{96,-18}})));
  OpenIPSL.Electrical.Buses.Bus bus(
    displayPF=true)
    annotation (Placement(transformation(extent={{-14,-10},{6,10}})));
  inner OpenIPSL.Electrical.SystemBase SysData(S_b=1000000000, fn=50)
    annotation (Placement(transformation(extent={{20,60},{100,100}})));
  OpenIPSL.Electrical.Sources.VoltageSourceReImInput
    voltageSourceReImInput(
    P_0=1000000,
    Q_0=0,
    v_0=1,
    angle_0=0.5235987755983)
    annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
  Modelica.Blocks.Sources.Constant Vre(k=0.866)
    annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
  Modelica.Blocks.Sources.Constant Vim(k=0.5)
    annotation (Placement(transformation(extent={{-80,-40},{-60,-20}})));
  ResistorPhasor resistor(
    Vb(displayUnit="kV") = 320000,
    R=100,
    displayPF=true)
    annotation (Placement(transformation(extent={{38,-12},{62,12}})));
  Sensor.ACpowerSensor pQ_Sensor
    annotation (Placement(transformation(extent={{8,-6},{28,6}})));
equation
  connect(voltageSourceReImInput.p, bus.p)
    annotation (Line(points={{-19,0},{-4,0}},    color={0,0,255}));
  connect(Vre.y, voltageSourceReImInput.vRe) annotation (Line(points={{-59,30},
          {-52,30},{-52,4},{-42,4}}, color={0,0,127}));
  connect(Vim.y, voltageSourceReImInput.vIm) annotation (Line(points={{-59,-30},
          {-52,-30},{-52,-4},{-42,-4}}, color={0,0,127}));
  connect(pQ_Sensor.n, resistor.p)
    annotation (Line(points={{28,0},{36.8,0}}, color={0,0,255}));
  connect(pQ_Sensor.p, bus.p)
    annotation (Line(points={{8,0},{-4,0}},      color={0,0,255}));
  connect(resistor.n, groundPhasor.p)
    annotation (Line(points={{63.2,0},{70,0},{70,-18.54}},  color={0,0,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, grid={2,2})),
                                                                 Diagram(
        coordinateSystem(preserveAspectRatio=false, grid={2,2})));
end TestPhasorResistor;
