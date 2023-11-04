import 'package:clickk/models/organiser/Organiser.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../state/organiser/backend/organizer_controller.dart';
import '../../state/organiser/providers/organiserProviders.dart';


class UiPlayGround extends ConsumerStatefulWidget {
  const UiPlayGround({super.key});

  @override
  UiPlayGroundState createState() => UiPlayGroundState();
}

class UiPlayGroundState extends ConsumerState<UiPlayGround> {

  fetchOrganisers() async {
    final organisersController = ref.read(organiserControllerProvider);
    Future<void>? fetchedOrganisers = organisersController.listenToOrganiserList();
  }


  @override
  void initState() {
    super.initState();
  }
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {

    addOrganiser( Organiser organiser) {
      final oranisersController = ref.read(organiserControllerProvider);
      oranisersController.addToOrganiser(organiser);
      final organisers = ref.watch(organiserControllerProvider);
      print('These are organisers : $organisers');
      final organisersList =
      ref.read(organiserProvider);
      return organisersList;
    }

    Organiser newOrganiser =
    Organiser(
        eventsList: ['event1','event2','event3'],
        oDomain: 'Payment',
        oInstitute: 'NEw Horizon',
        oLocation: 'Mumbai',
        oName: 'Revergon',
        oSuccessRate: 96,
        oUrl: 'https://www.revergon.com/',
        uid: 'uid1weq1e423')  ;

    return Scaffold(
      body: Column(children: [
        Container(
          decoration: const BoxDecoration(
            color: Colors.redAccent,
            shape: BoxShape.circle,
          ),),
        ElevatedButton(
            onPressed: (){
              addOrganiser(newOrganiser);
            },
            child:Text('Add Button ') ),
        ElevatedButton(
            onPressed: (){
              fetchOrganisers();
            },
            child:Text('Fetch Button ') ),
      ]),
    );
  }


}
