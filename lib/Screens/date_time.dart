import 'package:homevio/animation/fade_animation.dart';
import 'package:homevio/Screens/home.dart';
import 'package:flutter/material.dart';
import 'package:homevio/constants.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:intl/intl.dart';

import 'checkout_screen.dart';

class DateAndTime extends StatefulWidget {
  final String? service;
  final String? room;
  final int? roomTot;
  const DateAndTime(this.service, this.room, this.roomTot);

  @override
  _DateAndTimeState createState() => _DateAndTimeState();
}

class _DateAndTimeState extends State<DateAndTime> {
  int _selectedRepeat = 0;
  String _selectedHour = '13:30';
  final List<int> _selectedExteraCleaning = [];

  final ItemScrollController _scrollController = ItemScrollController();

  String date = "";
  DateTime selectedDate = DateTime.now();

  final List<String> _hours = <String>[
    '01:00',
    '01:30',
    '02:00',
    '02:30',
    '03:00',
    '03:30',
    '04:00',
    '04:30',
    '05:00',
    '05:30',
    '06:00',
    '06:30',
    '07:00',
    '07:30',
    '08:00',
    '08:30',
    '09:00',
    '09:30',
    '10:00',
    '10:30',
    '11:00',
    '11:30',
    '12:00',
    '12:30',
    '13:00',
    '13:30',
    '14:00',
    '14:30',
    '15:00',
    '15:30',
    '16:00',
    '16:30',
    '17:00',
    '17:30',
    '18:00',
    '18:30',
    '19:00',
    '19:30',
    '20:00',
    '20:30',
    '21:00',
    '21:30',
    '22:00',
    '22:30',
    '23:00',
    '23:30',
  ];

  final List<String> _repeat = [
    'No repeat',
    'Every day',
    'Every week',
    'Every month'
  ];

  final List<dynamic> _exteraCleaning = [
    ['Washing', 'https://img.icons8.com/office/2x/washing-machine.png', '10'],
    ['Fridge', 'https://img.icons8.com/cotton/2x/fridge.png', '8'],
    ['Oven', 'https://img.icons8.com/external-becris-lineal-color-becris/2x/external-oven-kitchen-cooking-becris-lineal-color-becris.png', '8'],
    ['Vehicle', 'https://img.icons8.com/external-vitaliy-gorbachev-blue-vitaly-gorbachev/2x/external-bycicle-carnival-vitaliy-gorbachev-blue-vitaly-gorbachev.png', '20'],
    ['Windows', 'https://img.icons8.com/external-kiranshastry-lineal-color-kiranshastry/2x/external-window-interiors-kiranshastry-lineal-color-kiranshastry-1.png', '20'],
  ];

  String? addService;
  String? dateSelected;

  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 500), () {
      _scrollController.scrollTo(
        index: 24,
        duration: const Duration(seconds: 3),
        curve: Curves.easeInOut,
      );
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CheckoutOnePage(widget.service,widget.room,widget.roomTot,dateSelected,addService,_selectedHour),
            ),
          );
        },
        child: const Icon(Icons.arrow_forward_ios),
        backgroundColor: Constants.kPrimaryColor,
      ),
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverToBoxAdapter(
              child: FadeAnimation(1, Padding(
                padding: const EdgeInsets.only(top: 120.0, right: 20.0, left: 20.0),
                child: Text(
                  'Select Date \nand Time',
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.grey.shade900,
                    fontFamily: "Brand Bold",
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ))
          ];
        },
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10,),
              FadeAnimation(1, Row(
                children: [
                  Text("${selectedDate.day}/0${selectedDate.month}/${selectedDate.year}", style: const TextStyle(fontFamily: "ubuntu", fontWeight: FontWeight.w600)),
                  const Spacer(),
                  IconButton(
                    padding: const EdgeInsets.all(0),
                    onPressed: () {
                      _selectDate(context);
                    },
                    icon: Icon(Icons.arrow_drop_down_circle_outlined, color: Colors.grey.shade700,),
                  )
                ],
              )),
              const SizedBox(height: 10,),
              FadeAnimation(1.2, Container(
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  border: Border.all(width: 1.5, color: Colors.grey.shade200),
                ),
                child: ScrollablePositionedList.builder(
                  itemScrollController: _scrollController,
                  scrollDirection: Axis.horizontal,
                  itemCount: _hours.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedHour = _hours[index];
                          dateSelected = "${selectedDate.year}-0${selectedDate.month}-${selectedDate.day}";
                          String dateNow = "$dateSelected $_selectedHour";
                          DateTime? dt = DateTime.tryParse(dateNow);
                          dateSelected = DateFormat('yyyy-MM-dd – kk:mm').format(dt!);
                        });
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        width: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: _selectedHour == _hours[index] ? Colors.orange.shade100.withOpacity(0.5) : Colors.orange.withOpacity(0),
                          border: Border.all(
                            color: _selectedHour == _hours[index] ? Colors.orange : Colors.white.withOpacity(0),
                            width: 1.5,
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(_hours[index], style: const TextStyle(fontSize: 20, fontFamily: "ubuntu", fontWeight: FontWeight.w600),),
                          ],
                        ),
                      ),
                    );
                  }
                ),
              )),
              const SizedBox(height: 40,),
              FadeAnimation(1.2, const Text("Repeat", style: TextStyle(fontSize: 18, fontFamily: "Brand Bold", fontWeight: FontWeight.w600),)),
              const SizedBox(height: 10,),
              Container(
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _repeat.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedRepeat = index;
                        });
                      },
                      child: FadeAnimation((1.2 + index) / 4, Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: _selectedRepeat == index ? Constants.kAccentColor : Colors.grey.shade100,
                        ),
                        margin: const EdgeInsets.only(right: 20),
                        child: Center(child: Text(_repeat[index], 
                          style: TextStyle(fontSize: 18, fontFamily: "ubuntu", color: _selectedRepeat == index ? Colors.white : Colors.grey.shade800),)
                        ),
                      )),
                    );
                  },
                )
              ),
              const SizedBox(height: 40,),
              FadeAnimation(1.4, const Text("Additional Service", style: TextStyle(fontSize: 18, fontFamily: "Brand Bold", fontWeight: FontWeight.w600),)),
              const SizedBox(height: 10,),
              Container(
                height: 120,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _exteraCleaning.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          if (_selectedExteraCleaning.contains(index)) {
                            _selectedExteraCleaning.remove(index);
                          } else {
                            _selectedExteraCleaning.add(index);
                          }
                        });
                      },
                      child: FadeAnimation((1.4 + index) / 4, Container(
                        width: 110,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: _selectedExteraCleaning.contains(index) ? Constants.MenuColor : Colors.transparent,
                        ),
                        margin: const EdgeInsets.only(right: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.network(_exteraCleaning[index][1], height: 40,),
                            const SizedBox(height: 10,),
                            Text(_exteraCleaning[index][0], style: TextStyle(fontSize: 15, fontFamily: "ubuntu", fontWeight: FontWeight.w600, color: _selectedExteraCleaning.contains(index) ? Colors.white : Colors.grey.shade800),),
                            const SizedBox(height: 5,),
                            Text("+Ksh ${_exteraCleaning[index][2]}", style: const TextStyle(color: Colors.black, fontFamily: "ubuntu"),)
                          ],
                        )
                      ))
                    );
                  },  
                )
              ),
            ],
          ), 
        ),
      )
    );
  }
  _selectDate(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2010),
      lastDate: DateTime(2025),
    );
    if (selected != null && selected != selectedDate) {
      setState(() {
        selectedDate = selected;
      });
    }
  }
}