class HealthChartData {

  HealthChartData(this.durationInSeconds);

  final Duration durationInSeconds;
}

const List<Map> healthInfoDataList = [
  {
    'step' : '1단계',
    'time' : '20분',
    'duration' : Duration(minutes: 20),
    'content' : '혈압과 맥박이 정상으로 돌아오고 손발의 체온이 정상 수준으로 증가합니다'
  },
  {
    'step' : '2단계',
    'time' : '12시간',
    'duration' : Duration(hours: 12),
    'content' : '혈액 속 산소량이 정상으로 올라가고 일산화탄소 양도 정상으로 떨어집니다'
  },
  {
    'step' : '3단계',
    'time' : '2주 ~ 3개월',
    'duration' : Duration(days: 90),
    'content' : '혈액순환이 좋아지고 폐기능이 좋아집니다'
  },
  {
    'step' : '4단계',
    'time' : '1 ~ 9개월',
    'duration' : Duration(days: 270),
    'content' : '기침이 줄어들고 숨쉬기 편안해지며 폐의 섬모가 정상기능을 찾아 여러 가지 감염의 위험이 줄어듭니다'
  },
  {
    'step' : '5단계',
    'time' : '1년',
    'duration' : Duration(days: 365),
    'content' : '관상동맥질환에 걸릴 위험이 흡연자의 절반으로 감소합니다'
  },
  {
    'step' : '6단계',
    'time' : '5년',
    'duration' : Duration(days: 1825),
    'content' : '금연 후 5 ~ 15년이 지나면 중풍에 걸릴 위험이 비흡연자와 같아집니다'
  },
  {
    'step' : '7단계',
    'time' : '10년',
    'duration' : Duration(days: 3650),
    'content' : '폐암 사망률이 흡연자의 절반 수준이 되며, 구강암, 후두암, 식도암, 방광암, 신장암, 췌장암의 발생위험도 감소합니다'
  },
  {
    'step' : '8단계',
    'time' : '15년',
    'duration' : Duration(days: 5475),
    'content' : '관상동맥질환에 걸릴 위험이 비흡연자와 같아집니다'
  },
  
  

];