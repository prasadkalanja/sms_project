
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

final Map<DateTime, List> _holidays={
  DateTime(2022, 01, 01):['New Year\'s Day'],
  DateTime(2022, 01, 12):['Birthday of Swamivivekanandha'],
  DateTime(2022, 01, 23):['Birthday of Nethaji'],

};
class Calender extends StatefulWidget {
  @override
  _CalenderState createState() => _CalenderState();
}

class _CalenderState extends State<Calender> {

  // Map<DateTime, List> _events;
  // List _selectedEvents;
  // // @override
  // void initState() {
  //   super.initState();
  //   final _selectedDay = DateTime.now();

    // _events = {
    //   DateTime(2022, 01, 01): ["New Year\'s Day"],
    //   DateTime(2022, 01, 12): ['Birthday of Swamivivekanandha'],
    //   DateTime(2022, 01, 23): ['Birthday of Nethaji'],
    // };
    // _selectedEvents = _events[_selectedDay] ?? [];
    // _calendarController = CalendarController();
  // }
  // @override
  // void dispose() {
  //   _calendarController.dispose();
  //   super.dispose();
  // }

  // void _onDaySelected(DateTime day, List events) {
  //   setState(() {
  //     _selectedEvents = events;
  //   });
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(50),
          child: AppBar(
             leading: InkWell(
             onTap: ()=>Navigator.pop(context, false),
               child: Icon(Icons.arrow_back,size: 30),
             ),
            backgroundColor: Color(0xff002c51),
            centerTitle: true,
            title:Text('ACADEMIC CALENDAR',style: TextStyle(fontSize: 20),),
          ),
        ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox( height: 20),
             _buildTableCalendar(),
          ],
      ),
      ),
    );
  }
  Widget _buildTableCalendar(){
    return TableCalendar(focusedDay: DateTime.now(),
        firstDay: DateTime.utc(2010, 01, 20), lastDay: DateTime.utc(2030),
      availableCalendarFormats: const {CalendarFormat.month: 'Month'},

    );

  }

}

// Widget _buildTableCalendar() {
//   return TableCalendar(
//     availableCalendarFormats: const {CalendarFormat.month: 'Month'},
//     calendarController: _calendarController,
//     events: _events,
//     holidays: _holidays,
//     startingDayOfWeek: StartingDayOfWeek.monday,
//     calendarStyle: CalendarStyle(
//       outsideDaysVisible: false,
//       todayColor: Theme.of(context).primaryColor,
//       holidayStyle: TextStyle().copyWith(color: Colors.red[900]),
//       markersColor: Theme.of(context).primaryColor,
//       todayStyle: TextStyle(
//           fontWeight: FontWeight.bold, fontSize: 18.0, color: Colors.red[900]),
//     ),
//     headerStyle: HeaderStyle(
//       centerHeaderTitle: true,
//       formatButtonTextStyle:
//       TextStyle().copyWith(color: Colors.white, fontSize: 15.0),
//       formatButtonDecoration: BoxDecoration(
//         color: Colors.purpleAccent,
//         borderRadius: BorderRadius.circular(16.0),
//       ),
//     ),
//     builders: CalendarBuilders(
//       selectedDayBuilder: (context, date, events) => Container(
//         margin: const EdgeInsets.all(4.0),
//         alignment: Alignment.center,
//         decoration: BoxDecoration(
//           color:Color(0xff002c51),
//           borderRadius: BorderRadius.circular(10.0),
//         ),
//         child: Text(
//           date.day.toString(),
//           style: TextStyle(color: Theme.of(context).primaryColor),
//         ),
//       ),
//       todayDayBuilder: (context, date, events) => Container(
//         margin: const EdgeInsets.all(4.0),
//         alignment: Alignment.center,
//         decoration: BoxDecoration(
//             color: Color(0xff53c0c7),
//             borderRadius: BorderRadius.circular(10.0)),
//         child: Text(
//           date.day.toString(),
//           style: TextStyle(color: Colors.white),
//         ),
//       ),
//     ),
//     onDaySelected: (date, events, _) {
//       setState(() {
//         _selectedEvents = events;
//       });
//     },
//
//
//   );
// }
//
// Widget _buildEventList() {
//   return ListView(
//     children: _selectedEvents
//         .map((event) => Container(
//       decoration: BoxDecoration(
//         border: Border.all(width: 0.2),
//         borderRadius: BorderRadius.circular(25),
//       ),
//       margin: EdgeInsets.all(10.0),
//       child: ListTile(
//         title: Center(child: Text(event.toString())),
//         onTap: () => print('$event tapped!'),
//       ),
//     ))
//         .toList(),
//   );
// }
// }
