import 'package:homevio/animation/fade_animation.dart';
import 'package:homevio/Screens/date_time_sreen.dart';
import 'package:flutter/material.dart';
import 'package:homevio/constants.dart';

class SelectRoomScreen extends StatefulWidget {
  final String? service;

  const SelectRoomScreen(this.service);

  @override
  _SelectRoomScreenState createState() => _SelectRoomScreenState();
}

class _SelectRoomScreenState extends State<SelectRoomScreen> {
  // Rooms to clean
  final List<dynamic> _rooms =[
    ['Living Room', 'https://img.icons8.com/officel/2x/living-room.png', Colors.red, 0],
    ['Bedroom', 'https://img.icons8.com/fluency/2x/bedroom.png', Colors.orange, 1],
    ['Bathroom', 'https://img.icons8.com/color/2x/bath.png', Colors.blue, 1],
    ['Kitchen', 'https://img.icons8.com/dusk/2x/kitchen.png', Colors.purple, 0],
    ['Office', 'https://img.icons8.com/color/2x/office.png', Colors.green, 0]
  ];

  String? roomName;
  int? roomTotal;
  final List<int> _selectedRooms = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: _selectedRooms.isNotEmpty ? FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DateAndTime(widget.service,roomName,roomTotal)
            ),
          );
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('${_selectedRooms.length}', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(width: 2),
            const Icon(Icons.arrow_forward_ios, size: 18,),
          ],
        ),
        backgroundColor: Constants.kPrimaryColor,
      ) : null,
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverToBoxAdapter(
              child: FadeAnimation(1, Padding(
                padding: const EdgeInsets.only(top: 120.0, right: 20.0, left: 20.0),
                child: Text(
                  'Pick area you want to be\nserviced?',
                  style: TextStyle(
                    fontSize: 35,
                    color: Colors.grey.shade900,
                    //fontWeight: FontWeight.bold,
                    fontFamily: "Brand Bold"
                  ),
                ),
              ),
            ))
          ];
        },
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _rooms.length,
            itemBuilder: (BuildContext context, int index) {
              return FadeAnimation((1.2 + index) / 4, room(_rooms[index], index));
            }
          ),
        ),
      )
    );
  }
  
  room(List room, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (_selectedRooms.contains(index)) {
            _selectedRooms.remove(index);
            roomName = room[0];
            if(roomName == "Living Room" || roomName == "Kitchen" || roomName == "Office") {
              roomTotal = 1;
            }
          } else {
            _selectedRooms.add(index);
            roomName = room[0];
            if(roomName == "Living Room" || roomName == "Kitchen" || roomName == "Office") {
              roomTotal = 1;
            }
            print(roomName);
          }
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
        margin: const EdgeInsets.only(bottom: 20.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: _selectedRooms.contains(index) ? room[2].shade50.withOpacity(0.5) : Colors.grey.shade100,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Row(
                  children: [
                    Image.network(room[1], width: 35, height: 35,),
                    const SizedBox(width: 10.0,),
                    Text(room[0], style: const TextStyle(fontSize: 18, fontFamily: "ubuntu", fontWeight: FontWeight.w500),),
                  ],
                ),
                const Spacer(),
                _selectedRooms.contains(index) ? 
                  Container(
                    padding: const EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                      color: Colors.greenAccent.shade100.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: const Icon(Icons.check, color: Colors.green, size: 20,)
                  ) : 
                  const SizedBox()
              ],
            ),
            (_selectedRooms.contains(index) && room[3] >= 1) ?
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20.0,),
                  Text("How many ${room[0]}s?", style: const TextStyle(fontSize: 15, fontFamily: "ubuntu"),),
                  const SizedBox(height: 10.0,),
                  Container(
                    height: 45,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 4,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              room[3] = index + 1;
                              roomTotal = room[3];
                              print(roomTotal);
                            });
                          },
                          child: Container(
                            margin: const EdgeInsets.only(right: 10.0),
                            padding: const EdgeInsets.all(10.0),
                            width: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: room[3] == index + 1 ? room[2].withOpacity(0.5) : room[2].shade200.withOpacity(0.5),
                            ),
                            child: Center(child: Text((index + 1).toString() , style: const TextStyle(fontSize: 22, color: Colors.white),)),
                          ),
                        );
                      }
                    ),
                  )
                ],
              ),
            ) : const SizedBox()
          ],
        )
      ),
    );
  }
}