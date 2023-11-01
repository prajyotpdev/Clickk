
import 'package:flutter_riverpod/flutter_riverpod.dart';

final organiserProvider = StateProvider<Map<String,dynamic>>(
        (ref) {
      Map<String,dynamic> items = {};
      return items;
    });