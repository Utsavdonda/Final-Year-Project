import 'api_endpoints.dart';

class EnvConstants {
  const EnvConstants._();

  static Flavor flavor = Flavor.values.byName(
    String.fromEnvironment(
      "ENVIRONMENT",
      defaultValue: Flavor.develop.name,
    ),
  );
}
