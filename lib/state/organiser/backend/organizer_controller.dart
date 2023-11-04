
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/organiser/Organiser.dart';
import 'organizer_repository.dart';


final organiserControllerProvider = Provider<OrganiserController>((ref) {
  return OrganiserController(ref);
});



class OrganiserController {
  OrganiserController(this.ref);
  final Ref ref;
  Future<void>? listenToOrganiserList() {
    print('listenToOrganiserList is running');
    final organiserDetailsRepository = ref.read(organiserRepositoryProvider);
    return organiserDetailsRepository.getOrganisersList();
  }
  Future<void> addToOrganiser(Organiser item) {
    print('addToOrganiser is running');
    final organiserDetailsRepository = ref.read(organiserRepositoryProvider);
    return organiserDetailsRepository.addOrganiser(item);
  }
}