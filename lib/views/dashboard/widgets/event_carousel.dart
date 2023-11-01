import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../models/event/eventModel.dart';

class EventCarouselWidget extends StatefulWidget {
  const EventCarouselWidget({Key? key}) : super(key: key);

  @override
  _EventCarouselWidgetState createState() => _EventCarouselWidgetState();
}

class _EventCarouselWidgetState extends State<EventCarouselWidget> {



  // bool isDataFetched = false;
  late PageController _pageController;
  int _currentPage = 0;



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pageController =
        PageController(initialPage: _currentPage, viewportFraction: 0.8);
  }

  List<Map<String, dynamic>> EventDataList = [];


  // @override
  // void dispose() {
  //   // Clean up resources and break references here
  //
  //   super.dispose();
  // }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final List<Map<String, dynamic>> eventData = EventDataHolder.eventDataList;
    print(eventData);

    List<EventDataModel> newEventdataList =eventData.map((data) {
      return EventDataModel(
        data['EventId'],
        data['time'],// Assuming EventEndTime is calculated based on EventTime
        data['description'],
        data['displayName'],
        data['imageUrl'],
        data['color'],
      );
    }).toList();

    print(newEventdataList);

    Widget carouselView(int index) {
      int numberOfIds = newEventdataList.length;
      String selectedEventId;
      return AnimatedBuilder(
        animation: _pageController,
        builder: (context, child) {
          double value = 0.0;
          if (_pageController.position.haveDimensions) {
            value = index.toDouble() - (_pageController.page ?? 0);
            value = (value * 0.038).clamp(-1, 1);
            print("value $value index $index");
          }
          return Transform.rotate(
            angle: 0.1 * value,
            child: carouselCard(newEventdataList[index]),
          );
        },
      );
    }


    return Scaffold(
      body:Column(
        children: <Widget>[
          AspectRatio(
            aspectRatio: 1.9,
            child: PageView.builder(
                itemCount: newEventdataList.length,
                physics:  ClampingScrollPhysics(),
                controller: _pageController,
                itemBuilder: (context, index) {
                  return carouselView(index);
                }),
          )
        ],
      ),
    );
  }


  Widget carouselCard(EventDataModel Eventdata) {
    return Column(
      children: <Widget>[
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Hero(
              tag: Eventdata.eventId,
              child: GestureDetector(
                onTap: () {
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => EventIntroScreen(EventId: Eventdata.EventId, description:  Eventdata.description , displayName: Eventdata.displayName,)));
                },
                child:
                Container(
                  width:400,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      image: DecorationImage(
                          image: NetworkImage(
                            Eventdata.imageUrl,
                          ),colorFilter: ColorFilter.mode(Colors.white70,BlendMode.colorBurn),
                          fit: BoxFit.cover),
                      boxShadow: const [
                        BoxShadow(
                            offset: Offset(0, 4),
                            blurRadius: 4,
                            color: Colors.black26)
                      ]),
                  child: Column(
                    mainAxisAlignment:MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        constraints: BoxConstraints(maxWidth: 500),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            children: [
                              Image.asset('assets/images/Event_icon.png',
                                height: 54.0,
                                width: 54.0,
                                fit: BoxFit.fill,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child:Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(Eventdata.displayName,
                                      style: GoogleFonts.inter(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black
                                      ),
                                    ),
                                    Text(Eventdata.description,
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.inter(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 20, bottom: 20),
                        child: InkWell(
                          onTap:() {
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) => EventIntroScreen(EventId: Eventdata.eventId, description:  Eventdata.description, displayName: Eventdata.displayName, )));
                          },
                          child: Container(
                            width: 88,
                            height: 38,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment(0.9863128662109375,0.08857862800359726),
                                  end: Alignment(-0.018857860937714577,0.025981927290558815),
                                  colors: [Color.fromRGBO(239, 56, 240, 1),Color.fromRGBO(88, 185, 246, 1)]
                              ),
                              borderRadius : BorderRadius.all(Radius.circular(8)),
                            ),
                            child: Center(
                                child: Text(
                                  'Play Now',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),)
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}