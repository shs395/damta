import 'package:damta/data/models/smoking_record.dart';
import 'package:damta/view_model/smoking_record_list_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:provider/src/provider.dart';
import 'package:damta/common/theme.dart';

class ModifySmokingRecordPage extends StatefulWidget {
  final SmokingRecord smokingRecord;
  const ModifySmokingRecordPage({ Key? key, required this.smokingRecord }) : super(key: key);

  @override
  _ModifySmokingRecordPageState createState() => _ModifySmokingRecordPageState();
}

class _ModifySmokingRecordPageState extends State<ModifySmokingRecordPage> {
  late TextEditingController countController;
  late TextEditingController dateTimeController;
  late int _count;
  late DateTime _dateTime;
  late String _cigarName;

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
    _count = widget.smokingRecord.count;
    _dateTime = widget.smokingRecord.dateTime;
    _cigarName = widget.smokingRecord.cigarName;
    countController = TextEditingController(text: '${_count.toString()}');
    dateTimeController = TextEditingController();
    initializeDateFormatting('ko_KR, null').then((_) {
      dateTimeController.text = DateFormat('yyyy년 MM월 dd일 a h시 m분', 'ko_KR').format(_dateTime);
    });
  }

  @override
  Widget build(BuildContext context) {
    SmokingRecordListViewModel smokingRecordListViewModel = context.watch<SmokingRecordListViewModel>();

    return Container(
      height: MediaQuery.of(context).size.height * 0.6,
      padding: EdgeInsetsDirectional.fromSTEB(15, 0, 15, 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0, 30, 0, 20),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Container()
                ),
                Expanded(
                  flex: 1,
                  child: Center(
                    child: Text(
                      '수정',
                      style: TextStyle(
                        fontSize: 20,
                        // fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 0, 10, 0),
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      icon: Icon(Icons.delete_outline),
                      color: Colors.red,
                      onPressed: () {
                        showDialog(
                          context: context,
                          barrierDismissible: true,
                          builder: (BuildContext context) {
                            // return Container(
                            //   child: Text('s')
                            // );
                            return AlertDialog(
                              // title: const Text('AlertDialog Title'),
                              content: SingleChildScrollView(
                                child: ListBody(
                                  children: const <Widget>[
                                    Text('삭제하시겠습니까?'),
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
                                    '삭제',
                                    style: TextStyle(
                                      color: Colors.red
                                    )
                                  ),
                                  onPressed: () {
                                    smokingRecordListViewModel.deleteSmokingRecord(widget.smokingRecord);
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        ).then((value) {
                          Navigator.of(context).pop();
                        });

                        // Navigator.of(context).pop();
                      },
                    )
                  )
                )
              ],
            )
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
                    currentTime: _dateTime,
                    showTitleActions: true,
                    minTime: DateTime(2010, 1, 1),
                    maxTime: DateTime(2050, 1, 1),
                    locale: LocaleType.ko,
                    onConfirm: (date) {
                      setState(() {
                        _dateTime = date;
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
                          smokingRecordListViewModel.modifySmokingRecord(widget.smokingRecord, SmokingRecord(_dateTime, int.parse(countController.text), ''));
                          Navigator.pop(context);
                        } else {
                          return null;
                        }
                      },
                      child: Text('수정'),
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