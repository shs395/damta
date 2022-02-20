import 'package:damta/data/models/smoking_record.dart';
import 'package:damta/view_model/smoking_record_list_view_model.dart';
import 'package:damta/view_model/user_info_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/src/provider.dart';
import 'package:damta/common/theme.dart';

class CreateSmokingRecordPage extends StatefulWidget {
  const CreateSmokingRecordPage({ Key? key }) : super(key: key);

  @override
  _CreateSmokingRecordPageState createState() => _CreateSmokingRecordPageState();
}

class _CreateSmokingRecordPageState extends State<CreateSmokingRecordPage> {
  late DateTime datePicked;
  late TextEditingController countController;
  late TextEditingController dateTimeController;

  bool _isValidCount(String value) {
    if (value == null || value.isEmpty || int.parse(value) <= 0 ) {
      return false;
    } else {
      return true;
    }
  }

  @override
  void initState() {
    super.initState();
    datePicked = DateTime.now();
    countController = TextEditingController();
    dateTimeController = TextEditingController();
    initializeDateFormatting('ko_KR, null').then((_) {
      dateTimeController.text = DateFormat('yyyy년 MM월 dd일 a h시 m분', 'ko_KR').format(datePicked);
    });

  }

  @override
  Widget build(BuildContext context) {
    SmokingRecordListViewModel smokingRecordListViewModel = context.watch<SmokingRecordListViewModel>();
    UserInfoViewModel userInfoViewModel = context.watch<UserInfoViewModel>();
    return Container(
      height: MediaQuery.of(context).size.height * 0.6,
      padding: EdgeInsetsDirectional.fromSTEB(15, 0, 15, 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0, 30, 0, 50),
            child: Center(
              child: Text(
                '추가',
                style: TextStyle(
                  fontSize: 20,
                  // fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          // SizedBox(
          //   height: 20,
          // ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(5, 0, 0, 5),
                child: Text(
                  '개수',
                  style: TextStyle(
                    color: appTheme.mainGreen
                  ),
                ),
              ),
              TextFormField(
                controller: countController,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  return _isValidCount(value ?? '') ? null : '1 이상의 정수를 입력해주세요';
                }, 
                keyboardType: TextInputType.numberWithOptions(signed:true, decimal: false),
                inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                ],
                cursorColor: appTheme.mainGreen,
                decoration: const InputDecoration( 
                  // hintText: '개', 
                  // labelText: 'Labxel Text', 
                  suffixText: '개',
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    borderSide: BorderSide( 
                      color: appTheme.mainGrey, 
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    borderSide: BorderSide(
                      color: appTheme.mainGrey
                    )
                  ),
                  filled: true, 
                  fillColor: appTheme.mainGrey,
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(5, 20, 0, 5),
                child: Text(
                  '날짜',
                  style: TextStyle(
                    color: appTheme.mainGreen
                  ),
                ),
              ),
              TextFormField(
                readOnly: true,
                controller: dateTimeController,
                decoration: const InputDecoration( 
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    borderSide: BorderSide( 
                      color: appTheme.mainGrey, 
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    borderSide: BorderSide(
                      color: appTheme.mainGrey
                    )
                  ),
                  filled: true, 
                  fillColor: appTheme.mainGrey,
                ),
                onTap: () {
                  DatePicker.showDateTimePicker(
                    context,
                    currentTime: datePicked,
                    showTitleActions: true,
                    minTime: DateTime(2010, 1, 1),
                    maxTime: DateTime(2050, 1, 1),
                    locale: LocaleType.ko,
                    onConfirm: (date) {
                      setState(() {
                        datePicked = date;
                        dateTimeController.text = '${DateFormat('yyyy년 MM월 dd일 a h시 m분', 'ko_KR').format(date)}';
                      });
                    },
                  );
                },
              ),
              SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox( 
                    height:50, //height of button
                    width:MediaQuery.of(context).size.width * 0.4, //width of button
                    child:ElevatedButton(
                      onPressed: (){
                        Navigator.pop(context);
                      }, 
                      child: Text('취소'),
                      style: ElevatedButton.styleFrom(
                        primary: appTheme.mainGreen,
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(15.0),
                        ),
                      )
                    )
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.07,
                  ),
                  SizedBox( 
                    height:50, //height of button
                    width:MediaQuery.of(context).size.width * 0.4, //width of button
                    child:ElevatedButton(
                      // onPressed: (){
                        
                      //   smokingRecordListViewModel.addSmokingRecord(SmokingRecord(datePicked, int.parse(countController.text), ''));
                      //   Navigator.pop(context);
                      // }, 
                      onPressed: () {
                        if(_isValidCount(countController.text) == true) {
                          if(userInfoViewModel.userInfo.isStopSmoking == true) {
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
                                        Navigator.pop(context);
                                        smokingRecordListViewModel.addSmokingRecord(SmokingRecord(datePicked, int.parse(countController.text), ''));
                                        userInfoViewModel.endStopSmoking();
                                      },
                                    ),
                                  ],
                                );
                              },
                            ).then((_) {Navigator.pop(context); } );
                          } else {
                            Navigator.pop(context);
                            smokingRecordListViewModel.addSmokingRecord(SmokingRecord(datePicked, int.parse(countController.text), ''));
                          }
                        } else {
                          return null;
                        }
                      },
                      child: Text('추가'),
                      style: ElevatedButton.styleFrom(
                        primary: appTheme.mainGreen,
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(15.0),
                        ),
                      )
                    )
                  )
                ]
              )

            ],
          )
        ]
      )
    );
  }
}



// Column(
//         children: [
//           Padding(
//             padding: EdgeInsetsDirectional.fromSTEB(0, 44, 12, 12),
//             child: Row(
//               mainAxisSize: MainAxisSize.max,
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: [
//                 InkWell(
//                   onTap:() async {
//                     Navigator.pop(context);
//                   },
//                   child: Card(
//                     clipBehavior: Clip.antiAliasWithSaveLayer,
//                     color: Colors.white,
//                     elevation: 3,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(40),
//                     ),
//                     child: Padding(
//                       padding: EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
//                       child: Icon(
//                         Icons.close_rounded,
//                         color: appTheme.mainGreen,
//                         size: 24,
//                       ),
//                     ),
//                   ),
//                 )
//               ],
//             )
//           ),
//           Expanded(
//             child: Row(
//               children: [
//                 Material(
//                   color: Colors.transparent,
//                   elevation: 0,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.only(
//                       bottomLeft: Radius.circular(0),
//                       bottomRight: Radius.circular(0),
//                       topLeft: Radius.circular(16),
//                       topRight: Radius.circular(16),
//                     ),
//                   ),
//                   child: Container(
//                     width: MediaQuery.of(context).size.width,
//                     height: MediaQuery.of(context).size.height * 1,
//                     decoration: BoxDecoration(
//                       color: appTheme.backgroundColor,
//                       // boxShadow: [
//                       //   BoxShadow(
//                       //     blurRadius: 7,
//                       //     color: Color(0x5D000000),
//                       //     offset: Offset(0, -2),
//                       //   )
//                       // ],
//                       borderRadius: BorderRadius.only(
//                         bottomLeft: Radius.circular(0),
//                         bottomRight: Radius.circular(0),
//                         topLeft: Radius.circular(16),
//                         topRight: Radius.circular(16),
//                       ),
//                     ),
//                     child: Padding(
//                       padding: EdgeInsetsDirectional.fromSTEB(15, 0, 15, 0),
//                       child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.stretch,
//                       children: [
//                         Expanded(
//                           flex:1,
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Text('추가하기')
//                             ],
//                           )
//                         ),
//                         Expanded(
//                           flex:1,
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text('개수'),
//                               TextFormField(
//                                 controller: countController,
//                                 keyboardType: TextInputType.number,
//                                 inputFormatters: <TextInputFormatter>[
//                                     FilteringTextInputFormatter.digitsOnly
//                                 ],
//                                 decoration: InputDecoration(
//                                   filled: true,
//                                   fillColor: appTheme.mainGrey
//                                 )
//                               )
//                             ],
//                           )
//                         ),
//                         Expanded(
//                           flex:1,
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text('날짜'),
//                               TextFormField()
//                             ],
//                           )
//                         ),
//                         Expanded(
//                           flex:2,
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               ElevatedButton(
//                                 onPressed: () {},
//                                 child: Text('취소')
//                               ),
//                               ElevatedButton(
//                                 onPressed: () {
//                                   print(countController.text);
//                                   print(countController);
//                                   if(countController.text == '') {
//                                     Navigator.pop(context);
//                                   } else {
//                                     if(int.parse(countController.text) >= 1) {
//                                       smokingRecordList.addSmokingRecord(SmokingRecord(DateTime.now(), int.parse(countController.text), ''));
//                                       Navigator.pop(context);
//                                     } else {
//                                       Navigator.pop(context);
//                                   }
//                                   }
                                  
                                  
//                                 },
//                                 child: Text('추가하기')
//                               ),
//                             ],
//                           )
//                         ),
//                       ],
//                       // children: [
//                       //   Padding(
//                       //     padding: EdgeInsetsDirectional.fromSTEB(16, 20, 16, 0),
//                       //     child: Row(
//                       //       children: [
//                       //         Text('Add Task')
//                       //       ]
//                       //     )
//                       //   ),
//                       //   Padding(
//                       //     padding: EdgeInsetsDirectional.fromSTEB(16, 4, 16, 0),
//                       //     child: Row(
//                       //       children: [
//                       //         Expanded(
//                       //           child: Text(
//                       //             '기록하세요'
//                       //           ),
//                       //         )
//                       //       ],
//                       //     )
//                       //   ),
//                       //   Padding(
//                       //     padding: EdgeInsetsDirectional.fromSTEB(16, 16, 16, 0),
//                       //     child: TextFormField(
//                       //       controller: textController1,
//                       //       obscureText: false,
//                       //       decoration: InputDecoration(
//                       //         filled: true,
//                       //         // hoverColor: Colors.green,
//                       //         fillColor: appTheme.mainGrey,
//                       //         // labelText: '1',
//                       //         // hintText: 'dd',
//                       //         enabledBorder: OutlineInputBorder(
//                       //           borderSide: BorderSide(
//                       //             color: Colors.white,
//                       //             width: 1
//                       //           )
//                       //         ),
//                       //         focusedBorder: OutlineInputBorder(
//                       //           borderSide: BorderSide(
//                       //             color: Colors.white,
//                       //             width: 1
//                       //           )
//                       //         ),
//                       //       ),
//                       //     )
//                       //   ),
//                       //   Padding(
//                       //     padding: EdgeInsetsDirectional.fromSTEB(16, 16, 16, 0),
//                       //     child: InkWell(
//                       //       onTap: () async {
//                       //         await DatePicker.showDatePicker(
//                       //           context,
//                       //           showTitleActions: true,
//                       //           onConfirm: (date) {
//                       //             setState(() => datePicked = date);
//                       //           },
//                       //           // currentTime: getCurrentTimestamp,
//                       //         );
//                       //       },
//                       //       child: Container(
//                       //         width: MediaQuery.of(context).size.width * 0.92,
//                       //         height: 50,
//                       //         decoration: BoxDecoration(
//                       //           color: Colors.red,
//                       //           borderRadius: BorderRadius.circular(8),
//                       //           border: Border.all(
//                       //             color: Colors.black,
//                       //             width: 1,
//                       //           ),
//                       //         ),
//                       //         child: Padding(
//                       //           padding: EdgeInsetsDirectional.fromSTEB(10, 14, 0, 0),
//                       //           child: Text(
//                       //             '${datePicked}'
//                       //           ),
//                       //         ),
//                       //       ),
//                       //     ),
//                       //   ),
//                       //   FloatingActionButton(
//                       //     child: Text('추가'),
//                       //     onPressed: () {
//                       //       smokingRecordList.addSmokingRecord(SmokingRecord(datePicked, 1, ''));
//                       //       Navigator.pop(context);
//                       //     },
//                       //   )
//                       // ]
//                     ),
//                     )
//                   ),
//                 ),
//               ]
//             ),
//           )
//         ],
//       )