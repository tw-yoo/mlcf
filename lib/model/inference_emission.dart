class InferenceEmission {
  final String architecture;
  final String gpuInstance;
  final double kwh;
  final double co2PerInference;

  InferenceEmission(
      this.architecture,
      this.gpuInstance,
      this.kwh,
      this.co2PerInference
    );
}