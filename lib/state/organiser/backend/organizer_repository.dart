import 'package:clickk/state/organiser/backend/organizer_datastore_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../models/organiser/Organiser.dart';


final organiserRepositoryProvider = Provider<OrganiserRepository>((ref) {
  final organiserDatastoreService = ref.read(organiserDatastoreServiceProvider);
  return OrganiserRepository(organiserDatastoreService);
});
class OrganiserRepository {

  final OrganiserDatastoreService organiserDatastoreServic;

  OrganiserRepository(this.organiserDatastoreServic);
  Future<void> getOrganisersList() {
    return organiserDatastoreServic.retrieveOrganisers();
  }
  Future<void>  addOrganiser(Organiser organiser) async {
    organiserDatastoreServic.addNewOrganiser( organiser);
  }

}
