///
/// Poor man's Spring for Dart environment
///

abstract class IContext {
  BT get<BT>({String name, Type type, bool isOptional = false}) {}
}
