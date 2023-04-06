class TrainEmission {
  final String architecture;
  final String gpuInstance;
  final double kwh;
  final double co2PerHour;

  TrainEmission(this.architecture, this.gpuInstance, this.kwh, this.co2PerHour);
}