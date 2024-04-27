enum Flavor { dev, staging2, beta, production }

class FlavorConfig {
  final String? endPoint;
  final String? imageEndPoint;
  final Flavor? flavor;
  final String? globalToken;
  final String? registerUrl;

  FlavorConfig(
      {this.endPoint,
      this.flavor,
      this.imageEndPoint,
      this.globalToken,
      this.registerUrl}); //
}

FlavorConfig flavorDev = FlavorConfig(
    endPoint: "",
    imageEndPoint: "",
    flavor: Flavor.dev,
    registerUrl: "",
    globalToken: "");
