
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/organiser/Organiser.dart';

final organiserProvider = StateProvider<Map<String,dynamic>>(
        (ref) {
      Map<String,dynamic> items = {};
      return items;
    });


final organiserListProvider = StateProvider<List<Organiser>>(
        (ref) {
          List<Organiser> items = [];
      return items;
    });