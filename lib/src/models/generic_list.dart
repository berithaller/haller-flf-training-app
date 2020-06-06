///
/// Data Model: a generic, observable list of items.
///

import 'identifiable.dart';

class GenericObservableList<IT extends IIdentifiable> {
  /// private: list of items
  List<IT> _items = [];

  /// @return list of managed items
  List<IT> get items => _items.toList();

  /// Count the number of items
  int get length => _items.length;

  /// @return some description for the current object
  @override
  String toString() {
    int len = _items.length;
    return 'Items {$len}';
  }

  /// Add an item to the list
  /// returns <code>true</code> if successful, <code>false</code> if not
  bool add(IT item) {
    final existing = queryById(item.id);
    if (existing != null) {
      // do not overwrite an existing item
      return false;
    }

    _items.add(item);
    return true;
  }

  /// Query an item by its id.
  IT queryById(String id) {
    for (IT temp in _items) {
      if (id == temp.id) return temp;
    }

    // not found
    return null;
  }

  // Remove a given item
  bool remove(IT item) {
    final bool result = (item != null) ? _items.remove(item) : false;
    return result;
  }

// Remove an item by id
  bool removeById(String id) {
    final IT existing = queryById(id);
    return remove(existing);
  }
}
