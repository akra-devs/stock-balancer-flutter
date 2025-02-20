import 'package:flutter/material.dart';

void main() {
  runApp(RebalancingApp());
}

class RebalancingApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '리벨런싱 앱',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
      ),
      home: RebalancingHomePage(),


    );
  }
}

class RebalancingHomePage extends StatefulWidget {
  @override
  _RebalancingHomePageState createState() => _RebalancingHomePageState();
}

class _RebalancingHomePageState extends State<RebalancingHomePage> {
  // 투자 관련 입력 컨트롤러
  final TextEditingController totalInvestmentController = TextEditingController();
  final TextEditingController currentStockValueController = TextEditingController();

  // 리벨런싱 비중 변수 (0~100)
  double cashRatio = 0.0;
  double stockRatio = 0.0;
  double bondRatio = 0.0;

  // 주식 세부 항목 on/off 여부
  bool isStockDetailOn = false;
  // 채권 사용 on/off (기본 off)
  bool isBondOn = false;

  // 주식 세부 비중
  double individualStockRatio = 0.0;
  double indexStockRatio = 0.0;

  // 총 비중 계산 (실시간 업데이트)
  double get totalRatio => cashRatio + stockRatio + bondRatio;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('리벨런싱 앱'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            // 투자 정보 입력 카드
            Card(
              elevation: 4,
              margin: EdgeInsets.symmetric(vertical: 8),
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '투자 정보 입력',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      controller: totalInvestmentController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: '총 매수 원금 금액',
                      ),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      controller: currentStockValueController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: '현재 주식 평가 금액',
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            // 리벨런싱 비중 입력 카드
            Card(
              elevation: 4,
              margin: EdgeInsets.symmetric(vertical: 8),
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '리벨런싱 비중 입력',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    // 현금 비중 슬라이더
                    Text('현금 비중 (%) : ${cashRatio.toStringAsFixed(0)}'),
                    Slider(
                      value: cashRatio,
                      min: 0,
                      max: 100,
                      divisions: 100,
                      label: cashRatio.toStringAsFixed(0),
                      onChanged: (value) {
                        setState(() {
                          cashRatio = value;
                        });
                      },
                    ),
                    SizedBox(height: 10),
                    // 주식 비중 슬라이더 및 상세 옵션 스위치
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('주식 비중 (%) : ${stockRatio.toStringAsFixed(0)}'),
                        Row(
                          children: [
                            Text('세부 설정'),
                            Switch(
                              value: isStockDetailOn,
                              onChanged: (value) {
                                setState(() {
                                  isStockDetailOn = value;
                                });
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                    Slider(
                      value: stockRatio,
                      min: 0,
                      max: 100,
                      divisions: 100,
                      label: stockRatio.toStringAsFixed(0),
                      onChanged: (value) {
                        setState(() {
                          stockRatio = value;
                        });
                      },
                    ),
                    // 주식 세부 항목 (세부 설정이 켜진 경우)
                    if (isStockDetailOn) ...[
                      SizedBox(height: 10),
                      Text('개별 주식 비중 (%) : ${individualStockRatio.toStringAsFixed(0)}'),
                      Slider(
                        value: individualStockRatio,
                        min: 0,
                        max: 100,
                        divisions: 100,
                        label: individualStockRatio.toStringAsFixed(0),
                        onChanged: (value) {
                          setState(() {
                            individualStockRatio = value;
                          });
                        },
                      ),
                      Text('지수 주식 비중 (%) : ${indexStockRatio.toStringAsFixed(0)}'),
                      Slider(
                        value: indexStockRatio,
                        min: 0,
                        max: 100,
                        divisions: 100,
                        label: indexStockRatio.toStringAsFixed(0),
                        onChanged: (value) {
                          setState(() {
                            indexStockRatio = value;
                          });
                        },
                      ),
                    ],
                    SizedBox(height: 10),
                    // 채권 비중 슬라이더 및 스위치
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('채권 비중 (%) : ${bondRatio.toStringAsFixed(0)}'),
                        Row(
                          children: [
                            Text('채권 사용'),
                            Switch(
                              value: isBondOn,
                              onChanged: (value) {
                                setState(() {
                                  isBondOn = value;
                                  if (!isBondOn) {
                                    bondRatio = 0;
                                  }
                                  // 채권 사용 시 자동 조정 로직 추가 가능
                                });
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                    if (isBondOn)
                      Slider(
                        value: bondRatio,
                        min: 0,
                        max: 100,
                        divisions: 100,
                        label: bondRatio.toStringAsFixed(0),
                        onChanged: (value) {
                          setState(() {
                            bondRatio = value;
                          });
                        },
                      ),
                    SizedBox(height: 10),
                    // 총 비중 확인
                    Text('총 비중: ${totalRatio.toStringAsFixed(0)}% (100% 필요)'),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            // 계산 버튼 (비중 검증 및 리벨런싱 로직 실행)
            ElevatedButton(
              onPressed: () {
                if (totalRatio != 100) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('총 비중이 100%가 되어야 합니다.'))
                  );
                } else {
                  // 리벨런싱 계산 로직 구현 부분
                  print("리벨런싱 계산 진행...");
                }
              },
              child: Text('리벨런싱 계산'),
            ),
          ],
        ),
      ),
    );
  }
}
