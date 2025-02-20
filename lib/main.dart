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
  // 투자 정보 컨트롤러
  final TextEditingController totalInvestmentController = TextEditingController();
  final TextEditingController currentStockValueController = TextEditingController();
  final TextEditingController currentBondValueController = TextEditingController();

  // 리벨런싱 비중 변수
  double cashRatio = 0.0;
  double stockRatio = 0.0;
  double bondRatio = 0.0;

  // 세부 설정 상태 변수
  bool isStockDetailOn = false;
  bool isBondEvaluationEnabled = false;
  bool isBondDetailOn = false;

  // 주식 세부 비중
  double individualStockRatio = 0.0;
  double indexStockRatio = 0.0;

  // 채권 세부 비중
  double individualBondRatio = 0.0;
  double indexBondRatio = 0.0;

  // 총 비중 계산 (채권 사용 여부에 따라)
  double get totalRatio => cashRatio + stockRatio + (isBondEvaluationEnabled ? bondRatio : 0);

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
            InvestmentInfoCard(
              totalInvestmentController: totalInvestmentController,
              currentStockValueController: currentStockValueController,
              currentBondValueController: currentBondValueController,
              isStockDetailOn: isStockDetailOn,
              isBondEvaluationEnabled: isBondEvaluationEnabled,
              isBondDetailOn: isBondDetailOn,
              onStockDetailChanged: (value) {
                setState(() {
                  isStockDetailOn = value;
                });
              },
              onBondEvaluationChanged: (value) {
                setState(() {
                  isBondEvaluationEnabled = value;
                  if (!value) {
                    isBondDetailOn = false;
                  }
                });
              },
              onBondDetailChanged: (value) {
                setState(() {
                  isBondDetailOn = value;
                });
              },
            ),
            SizedBox(height: 20),
            RebalancingRatioCard(
              cashRatio: cashRatio,
              stockRatio: stockRatio,
              bondRatio: bondRatio,
              individualStockRatio: individualStockRatio,
              indexStockRatio: indexStockRatio,
              individualBondRatio: individualBondRatio,
              indexBondRatio: indexBondRatio,
              isStockDetailOn: isStockDetailOn,
              isBondEvaluationEnabled: isBondEvaluationEnabled,
              isBondDetailOn: isBondDetailOn,
              onCashRatioChanged: (value) {
                setState(() {
                  cashRatio = value;
                });
              },
              onStockRatioChanged: (value) {
                setState(() {
                  stockRatio = value;
                });
              },
              onBondRatioChanged: (value) {
                setState(() {
                  bondRatio = value;
                });
              },
              onIndividualStockRatioChanged: (value) {
                setState(() {
                  individualStockRatio = value;
                });
              },
              onIndexStockRatioChanged: (value) {
                setState(() {
                  indexStockRatio = value;
                });
              },
              onIndividualBondRatioChanged: (value) {
                setState(() {
                  individualBondRatio = value;
                });
              },
              onIndexBondRatioChanged: (value) {
                setState(() {
                  indexBondRatio = value;
                });
              },
            ),
            SizedBox(height: 20),
            Text('총 비중: ${totalRatio.toStringAsFixed(0)}% (100% 필요)'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (totalRatio != 100) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('총 비중이 100%가 되어야 합니다.')),
                  );
                } else {
                  print("리벨런싱 계산 진행...");
                  // 리벨런싱 계산 로직 추가
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

class InvestmentInfoCard extends StatelessWidget {
  final TextEditingController totalInvestmentController;
  final TextEditingController currentStockValueController;
  final TextEditingController currentBondValueController;
  final bool isStockDetailOn;
  final bool isBondEvaluationEnabled;
  final bool isBondDetailOn;
  final ValueChanged<bool> onStockDetailChanged;
  final ValueChanged<bool> onBondEvaluationChanged;
  final ValueChanged<bool> onBondDetailChanged;

  const InvestmentInfoCard({
    Key? key,
    required this.totalInvestmentController,
    required this.currentStockValueController,
    required this.currentBondValueController,
    required this.isStockDetailOn,
    required this.isBondEvaluationEnabled,
    required this.isBondDetailOn,
    required this.onStockDetailChanged,
    required this.onBondEvaluationChanged,
    required this.onBondDetailChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
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
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: currentStockValueController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: '현재 주식 평가 금액',
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Column(
                  children: [
                    Text('세부 설정'),
                    Switch(
                      value: isStockDetailOn,
                      onChanged: onStockDetailChanged,
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: currentBondValueController,
                    enabled: isBondEvaluationEnabled,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: '현재 채권 평가 금액',
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Column(
                  children: [
                    Text('채권 사용'),
                    Switch(
                      value: isBondEvaluationEnabled,
                      onChanged: onBondEvaluationChanged,
                    ),
                  ],
                ),
                SizedBox(width: 10),
                if (isBondEvaluationEnabled)
                  Column(
                    children: [
                      Text('세부 설정'),
                      Switch(
                        value: isBondDetailOn,
                        onChanged: onBondDetailChanged,
                      ),
                    ],
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class RebalancingRatioCard extends StatelessWidget {
  final double cashRatio;
  final double stockRatio;
  final double bondRatio;
  final double individualStockRatio;
  final double indexStockRatio;
  final double individualBondRatio;
  final double indexBondRatio;
  final bool isStockDetailOn;
  final bool isBondEvaluationEnabled;
  final bool isBondDetailOn;
  final ValueChanged<double> onCashRatioChanged;
  final ValueChanged<double> onStockRatioChanged;
  final ValueChanged<double> onBondRatioChanged;
  final ValueChanged<double> onIndividualStockRatioChanged;
  final ValueChanged<double> onIndexStockRatioChanged;
  final ValueChanged<double> onIndividualBondRatioChanged;
  final ValueChanged<double> onIndexBondRatioChanged;

  const RebalancingRatioCard({
    Key? key,
    required this.cashRatio,
    required this.stockRatio,
    required this.bondRatio,
    required this.individualStockRatio,
    required this.indexStockRatio,
    required this.individualBondRatio,
    required this.indexBondRatio,
    required this.isStockDetailOn,
    required this.isBondEvaluationEnabled,
    required this.isBondDetailOn,
    required this.onCashRatioChanged,
    required this.onStockRatioChanged,
    required this.onBondRatioChanged,
    required this.onIndividualStockRatioChanged,
    required this.onIndexStockRatioChanged,
    required this.onIndividualBondRatioChanged,
    required this.onIndexBondRatioChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
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
            Text('현금 비중 (%) : ${cashRatio.toStringAsFixed(0)}'),
            Slider(
              value: cashRatio,
              min: 0,
              max: 100,
              divisions: 100,
              label: cashRatio.toStringAsFixed(0),
              onChanged: onCashRatioChanged,
            ),
            SizedBox(height: 10),
            Text('주식 비중 (%) : ${stockRatio.toStringAsFixed(0)}'),
            Slider(
              value: stockRatio,
              min: 0,
              max: 100,
              divisions: 100,
              label: stockRatio.toStringAsFixed(0),
              onChanged: onStockRatioChanged,
            ),
            if (isStockDetailOn) ...[
              SizedBox(height: 10),
              Text('개별 주식 비중 (%) : ${individualStockRatio.toStringAsFixed(0)}'),
              Slider(
                value: individualStockRatio,
                min: 0,
                max: 100,
                divisions: 100,
                label: individualStockRatio.toStringAsFixed(0),
                onChanged: onIndividualStockRatioChanged,
              ),
              Text('지수 주식 비중 (%) : ${indexStockRatio.toStringAsFixed(0)}'),
              Slider(
                value: indexStockRatio,
                min: 0,
                max: 100,
                divisions: 100,
                label: indexStockRatio.toStringAsFixed(0),
                onChanged: onIndexStockRatioChanged,
              ),
            ],
            SizedBox(height: 10),
            if (isBondEvaluationEnabled) ...[
              Text('채권 비중 (%) : ${bondRatio.toStringAsFixed(0)}'),
              Slider(
                value: bondRatio,
                min: 0,
                max: 100,
                divisions: 100,
                label: bondRatio.toStringAsFixed(0),
                onChanged: onBondRatioChanged,
              ),
              if (isBondDetailOn) ...[
                SizedBox(height: 10),
                Text('개별 채권 비중 (%) : ${individualBondRatio.toStringAsFixed(0)}'),
                Slider(
                  value: individualBondRatio,
                  min: 0,
                  max: 100,
                  divisions: 100,
                  label: individualBondRatio.toStringAsFixed(0),
                  onChanged: onIndividualBondRatioChanged,
                ),
                Text('지수 채권 비중 (%) : ${indexBondRatio.toStringAsFixed(0)}'),
                Slider(
                  value: indexBondRatio,
                  min: 0,
                  max: 100,
                  divisions: 100,
                  label: indexBondRatio.toStringAsFixed(0),
                  onChanged: onIndexBondRatioChanged,
                ),
              ],
            ],
          ],
        ),
      ),
    );
  }
}
