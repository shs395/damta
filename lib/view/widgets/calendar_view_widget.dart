import 'dart:collection';
import 'dart:ffi';
import 'package:damta/data/models/smoking_record.dart';
import 'package:damta/view/screens/create_smoking_record_page.dart';
import 'package:damta/view/screens/modify_smoking_record_page.dart';
import 'package:damta/view/widgets/custom_appbar.dart';
import 'package:damta/view_model/smoking_record_list_view_model.dart';
import 'package:damta/view_model/user_info_view_model.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/src/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:damta/common/theme.dart';

class CalendarViewWidget extends StatefulWidget {
  const CalendarViewWidget({ Key? key }) : super(key: key);

  @override
  _CalendarViewWidgetState createState() => _CalendarViewWidgetState();
}

class _CalendarViewWidgetState extends State<CalendarViewWidget> {
  late SmokingRecordListViewModel smokingRecordList;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode.disabled;
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();

  TextEditingController _eventController = TextEditingController();

  @override 
  void didChangeDependencies() {
    super.didChangeDependencies(); 
    initializeDateFormatting(Localizations.localeOf(context).languageCode); 
  }

  @override
  void initState() {
    super.initState();
    // _selectedDay = _focusedDay;    
    // _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay));
    // _selectedEvents.value = _getEventsForDay(_selectedDay);
    // print(_selectedEvents);
  }

  @override
  void dispose() {
    // _selectedEvents.dispose();
    _eventController.dispose();
    super.dispose();
  }


  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;

      });
      // _selectedEvents.value = _getEventsForDay(selectedDay);
      // print(_selectedEvents);
    }
  }

  Widget _buildEventsMarkerNum(List<SmokingRecord> events) {
    int _count = 0;
    events.forEach((element) {
      _count = _count + element.count;
    });
    return Text('${_count}', style: const TextStyle(color: Color(0xFFF28F38)),);
  }

  @override
  Widget build(BuildContext context) {
    smokingRecordList = Provider.of<SmokingRecordListViewModel>(context);
    UserInfoViewModel _userInfoViewModel = Provider.of<UserInfoViewModel>(context);
    return Scaffold(
      backgroundColor: appTheme.backgroundColor,
      appBar: CustomAppbar('달력'),
      body: Column(
        children: [
          TableCalendar<SmokingRecord>(
            // 달력의 시작점
            firstDay: calendarFirstDay,
            // 달력의 마지막점
            lastDay: calendarLastDay,
            // focus(색칠)되어 있는 곳
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            calendarFormat: _calendarFormat,
            // 기간 선택 가능한지
            rangeSelectionMode: _rangeSelectionMode,
            eventLoader: smokingRecordList.getSmokingRecordsForDay,
            startingDayOfWeek: StartingDayOfWeek.monday,
            // ui  꾸미기
            calendarStyle: CalendarStyle(
              // canMarkersOverflow: false,
              outsideDaysVisible: false,
              markerDecoration: BoxDecoration(
                color: const Color(0xFF263238),
                shape: BoxShape.circle
              ),
              selectedDecoration: BoxDecoration(
                color: appTheme.mainGreen, 
                shape: BoxShape.circle,
                // borderRadius: BorderRadius.circular(1),
              ),
              todayDecoration: BoxDecoration(
                color: appTheme.lightMainGreen, 
                shape: BoxShape.circle,
              ),
              // tableBorder: TableBorder.all(
              //   color: Colors.black, 
              //   width: 0.1
              // )
            ),
            onDaySelected: _onDaySelected,
            // year,month -> 년,월 표기
            locale: 'ko_KR',
            // 헤더 꾸미기
            headerStyle: const HeaderStyle(
              titleCentered: true,
              formatButtonVisible: false,
              headerPadding: const EdgeInsets.symmetric(vertical: 0.0),
              decoration: const BoxDecoration(
                // color: Colors.red 
              )
            ),
            calendarBuilders: CalendarBuilders(
              markerBuilder: (context, date, events) {
                    return events.isNotEmpty ?  _buildEventsMarkerNum(events) : Container();
              },
            ),
            daysOfWeekStyle: const DaysOfWeekStyle(), 
            // rowHeight: 30,
            
          ),
          const SizedBox(height: 8.0),
          Expanded(
            child: Stack(
              children: [
                ListView.builder(
                  itemCount: smokingRecordList.smokingRecordLinkedHashMap[_selectedDay] == null ? 0 : smokingRecordList.smokingRecordLinkedHashMap[_selectedDay]?.length,
                  itemBuilder: (context, index) {
                    if(smokingRecordList.smokingRecordLinkedHashMap[_selectedDay]?.length == null) {
                      return Container(
                        child: Text('none')
                      );
                    } else {
                      return Container(
                        child: ListTile(
                          onTap: () {
                            showBarModalBottomSheet(
                              context: context,
                              builder: (context) => ModifySmokingRecordPage(smokingRecord: smokingRecordList.smokingRecordLinkedHashMap[_selectedDay]![index]),
                            );
                          },
                          title: 
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0, 0, 5, 0),
                            child: Row(
                              children: [
                                Text('${DateFormat("M월 dd일").format(smokingRecordList.smokingRecordLinkedHashMap[_selectedDay]![index].dateTime)}'),
                                Text('    '),
                                Text('${DateFormat.jm('ko_KR').format(smokingRecordList.smokingRecordLinkedHashMap[_selectedDay]![index].dateTime)}'),  
                                Spacer(), 
                                // Icon(Icons.smoking_rooms),
                                // Text('  '),
                                // Text('${smokingRecordList.smokingRecordLinkedHashMap[_selectedDay]?[index].count}개'),                                
                                Text('${smokingRecordList.smokingRecordLinkedHashMap[_selectedDay]?[index].count}'),
                                Text('  '),
                                Icon(Icons.smoking_rooms, color: Color(0xFF5E778C),),
                              ]
                            ),
                          )
                          // 
                        )
                      );
                    }
                  }
                ),
                Positioned(
                  right: 20,
                  bottom: 20,
                  child: Row(
                    children: [
                      FloatingActionButton(
                        heroTag: 'd',
                        backgroundColor: appTheme.buttonAddBackgrounColor,
                        foregroundColor: appTheme.buttonAddForegroundColor,
                        child: Icon(Icons.add),
                        onPressed: () {
                                if(_userInfoViewModel.userInfo.isStopSmoking == true) {
                                  showDialog(
                                    context: context,
                                    barrierDismissible: true,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text('금연 기록 초기화'),
                                        content: SingleChildScrollView(
                                          child: ListBody(
                                            children: const <Widget>[
                                              Text('현재 금연 중입니다'),
                                              Text('금연을 포기하고 기록하시겠습니까?'),
                                            ],
                                          ),
                                        ),
                                        actions: <Widget>[
                                          TextButton(
                                            child: const Text(
                                                '취소',
                                                style: TextStyle(
                                                  color: Colors.black
                                                )
                                              ),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                          TextButton(
                                            child: const Text(
                                              '기록',
                                              style: TextStyle(
                                                color: Colors.red
                                              )
                                            ),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                              _userInfoViewModel.endStopSmoking();
                                              smokingRecordList.addSmokingRecord(SmokingRecord(DateTime.now(), 1, ''));
                                            },
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                } else {
                                  smokingRecordList.addSmokingRecord(SmokingRecord(DateTime.now(), 1, ''));
                                }
                                
                              }
                      ),
                      FloatingActionButton(
                        heroTag: 'gd',
                        backgroundColor: appTheme.buttonMoreBackgrounColor,
                        foregroundColor: appTheme.buttonMoreForegroundColor,
                        child: Icon(Icons.more_horiz),
                        onPressed: () {
                          showBarModalBottomSheet(
                            context: context,
                            builder: (context) => CreateSmokingRecordPage(),
                          );
                        }
                      ),              
                    ],
                  )
                ),

              ]
            )
          ),
          
          
          
        ],
      )
    );
  }
}