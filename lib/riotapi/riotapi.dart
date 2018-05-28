import 'package:porosnax_dart/riotapi/static_data.dart';

export 'champion.dart';
export 'static_data.dart';

class RiotStaticApi {
  static RiotStaticApi instance = RiotStaticApi._();

  RiotStaticApi._();

  final StaticDataApi staticData = StaticDataApi();
}
