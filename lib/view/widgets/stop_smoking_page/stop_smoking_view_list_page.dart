import 'package:flutter/material.dart';
import 'package:damta/common/theme.dart';

class StopSmokingViewListPage extends StatefulWidget {
  const StopSmokingViewListPage({ Key? key }) : super(key: key);

  @override
  _StopSmokingViewListPageState createState() => _StopSmokingViewListPageState();
}

class _StopSmokingViewListPageState extends State<StopSmokingViewListPage> {
  List<List<String>> advanceOfStopSmokingList = [
    ['20분', '혈압과 맥박이 정상으로 돌아오고 손발의 체온이 정상 수준으로 증가합니다'],
    ['12시간','혈액 속 산소량이 정상으로 올라가고 일산화탄소 양도 정상으로 떨어집니다'],
    ['2주 ~ 3개월','혈액순환이 좋아지고 폐기능이 좋아집니다'],
    ['1 ~ 9개월','기침이 줄어들고 숨쉬기 편안해지며 폐의 섬모가 정상기능을 찾아 여러 가지 감염의 위험이 줄어듭니다'],
    ['1년','관상동맥질환에 걸릴 위험이 흡연자의 절반으로 감소합니다'],
    ['5년','금연 후 5 ~ 15년이 지나면 중풍에 걸릴 위험이 비흡연자와 같아집니다'],
    ['10년','폐암 사망률이 흡연자의 절반 수준이 되며, 구강암, 후두암, 식도암, 방광암, 신장암, 췌장암의 발생위험도 감소합니다'],
    ['15년','관상동맥질환에 걸릴 위험이 비흡연자와 같아집니다'],
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: advanceOfStopSmokingList.length,
      itemBuilder: (context, index) {
        return Container(
          width: MediaQuery.of(context).size.width * 0.92,
          decoration: BoxDecoration(
              color: appTheme.white,
              borderRadius: BorderRadius.circular(25),
            ),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.2,
            height: MediaQuery.of(context).size.height * 0.13,
            padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
            margin: EdgeInsetsDirectional.fromSTEB(15, 10, 15, 10),
            decoration: BoxDecoration(
              color: appTheme.homeInfoWidgetBackgroundColor,
              borderRadius: BorderRadius.circular(25),
            ),
            child:  ListTile(
              title: Text(
                '${advanceOfStopSmokingList[index][0]}',
                style: TextStyle(
                  color: appTheme.mainGreen
                ),
              ),
              subtitle: Text('${advanceOfStopSmokingList[index][1]}'),
            ),
          )
        );
      }
    );
  }
}