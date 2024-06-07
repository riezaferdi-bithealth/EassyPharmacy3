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
    endPoint: "http://10.0.2.2:3000",
    imageEndPoint: "",
    flavor: Flavor.dev,
    registerUrl: "",
    globalToken: "");

FlavorConfig flavorProduction = FlavorConfig(
    endPoint: "http://103.146.202.22:3000",
    imageEndPoint: "",
    flavor: Flavor.production,
    registerUrl: "",
    globalToken: "");
