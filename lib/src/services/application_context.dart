///
/// Poor man's Spring for Dart environment
///

import 'package:flftrainingapp/utils.dart';
import 'context.dart';
import 'package:flftrainingapp/services.dart';

class ApplicationContext implements IContext {
  static ApplicationContext SELF;

  /// map of registered beans, indexed by name
  final Map<String, dynamic> _beansByName = Map();

  /// map of registered beans, indexed by type
  final Map<dynamic, dynamic> _beansByType = Map();

  ApplicationContext._() {
    // TODO find more elegant way to initialize services
    register(ProfileService(), "profileService");
    register(LocationService(), "locationService");
  }

  /// Singleton constructor
  factory ApplicationContext() {
    if (SELF == null) {
      SELF = new ApplicationContext._();
    }

    return SELF;
  }

  /// Return a requested bean instance by name or type.
  BT get<BT>({String name, Type type, bool isOptional = false}) {
    dynamic result;

    // perform lookup by name
    if (name != null)
      result = _beansByName[name];
    else
    // if no name is given, perform lookup by type
    if (type != null)
      result = _beansByType[type];
    else
      throw new AssertException(
          "Either name or type is required to lookp a bean");

    _assertBean(result, isOptional, name, type);

    // type-cast the result
    return (result as BT);
  }

  /// Register a bean
  BT register<BT>(BT bean, [String name]) {
    Assert.assertNotNull("Bean instance must not be null", bean);

    final Type typeOfBean = bean.runtimeType;
    _beansByType[typeOfBean] = bean;
    _beansByName[name] = bean;

    return bean;
  }

  /// Check if the resulting bean meets expectations of the caller.
  void _assertBean<BT>(dynamic bean, bool isOptional, String name, Type type) {
    if (!isOptional && bean == null)
      throw new AssertException("No bean '$name' of type '$type' found");
  }
}
