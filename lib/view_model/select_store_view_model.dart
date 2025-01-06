import 'package:flutter/material.dart';

class SelectStoreProvider with ChangeNotifier {
  // Private variable to hold the current store selection
  Store _selectedStore = Store.FOOD;

  // Getter to retrieve the current store selection
  Store get selectedStore => _selectedStore;

  // Setter to update the store selection and notify listeners
  set selectedStore(Store newStore) {
    if (_selectedStore != newStore) {
      _selectedStore = newStore;
      notifyListeners(); // Notify listeners about the change
    }
  }
}

enum Store {
  FOOD,
  COSMETICS,
}
