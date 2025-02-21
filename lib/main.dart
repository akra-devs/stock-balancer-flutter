import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'main.freezed.dart';

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
      darkTheme: ThemeData(brightness: Brightness.dark),
      home: BlocProvider(
        create: (_) => RebalancingBloc(),
        child: RebalancingHomePage(),
      ),
    );
  }
}

class RebalancingHomePage extends StatelessWidget {
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
            InvestmentInfoCard(),
            SizedBox(height: 20),
            RebalancingRatioCard(),
            SizedBox(height: 20),
            BlocBuilder<RebalancingBloc, RebalancingState>(
              builder: (context, state) {
                double totalRatio = state.cashRatio +
                    state.stockRatio +
                    (state.isBondEvaluationEnabled ? state.bondRatio : 0);
                return Text(
                    '총 비중: ${totalRatio.toStringAsFixed(0)}% (100% 필요)');
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final state = context.read<RebalancingBloc>().state;
                // 입력값을 double로 변환 (실패 시 0.0)
                double totalInvestment = double.tryParse(state.totalInvestment) ?? 0.0;
                double currentStockValue = double.tryParse(state.currentStockValue) ?? 0.0;
                double cashRatio = state.cashRatio;

                if (totalInvestment == 0) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('총 매수 원금이 0입니다.'))
                  );
                  return;
                }
                if (cashRatio >= 100) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('현금비중이 100% 이상일 수 없습니다.'))
                  );
                  return;
                }

                // 매수 당시 유추현금 계산: 총 매수원금 * (현금비중 / (100 - 현금비중))
                double impliedCash = totalInvestment * (cashRatio / (100 - cashRatio));

                // 목표 현금: (현금비중/100) * (impliedCash + 현재 주식 평가 금액)
                double targetCash = (cashRatio / 100) * (impliedCash + currentStockValue);

                // 리벨런싱 금액: 목표 현금 - 매수 당시 유추현금
                // 양수이면 주식을 매도해서 현금을 늘려야 하고, 음수이면 주식을 매수하여 현금을 줄여야 함.
                double rebalanceAmount = targetCash - impliedCash;
                String action = rebalanceAmount > 0 ? '매도' : '매수';
                double amount = rebalanceAmount.abs();

                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('리벨런싱 결과'),
                    content: Text('주식을 ${amount.toStringAsFixed(2)} 만큼 $action 하세요.'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('확인'),
                      ),
                    ],
                  ),
                );
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
  @override
  Widget build(BuildContext context) {
    final bloc = context.read<RebalancingBloc>();
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
              onChanged: (value) => bloc.add(TotalInvestmentChanged(value)),
              decoration: InputDecoration(
                labelText: '총 매수 원금 금액',
              ),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    onChanged: (value) =>
                        bloc.add(CurrentStockValueChanged(value)),
                    decoration: InputDecoration(
                      labelText: '현재 주식 평가 금액',
                    ),
                  ),
                ),
                SizedBox(width: 10),
                BlocBuilder<RebalancingBloc, RebalancingState>(
                  builder: (context, state) {
                    return Column(
                      children: [
                        Text('세부 설정'),
                        Switch(
                          value: state.isStockDetailOn,
                          onChanged: (_) {
                            bloc.add(ToggleStockDetail());
                          },
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: BlocBuilder<RebalancingBloc, RebalancingState>(
                    builder: (context, state) {
                      return TextField(
                        onChanged: (value) =>
                            bloc.add(CurrentBondValueChanged(value)),
                        enabled: state.isBondEvaluationEnabled,
                        decoration: InputDecoration(
                          labelText: '현재 채권 평가 금액',
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(width: 10),
                BlocBuilder<RebalancingBloc, RebalancingState>(
                  builder: (context, state) {
                    return Column(
                      children: [
                        Text('채권 사용'),
                        Switch(
                          value: state.isBondEvaluationEnabled,
                          onChanged: (_) {
                            bloc.add(ToggleBondEvaluation());
                          },
                        ),
                      ],
                    );
                  },
                ),
                SizedBox(width: 10),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class RebalancingRatioCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = context.read<RebalancingBloc>();
    return Card(
      elevation: 4,
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: BlocBuilder<RebalancingBloc, RebalancingState>(
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '리벨런싱 비중 입력',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Text('현금 비중 (%) : ${state.cashRatio.toStringAsFixed(0)}'),
                Slider(
                  value: state.cashRatio,
                  min: 0,
                  max: 100,
                  divisions: 100,
                  label: state.cashRatio.toStringAsFixed(0),
                  onChanged: (value) {
                    bloc.add(CashRatioChanged(value));
                  },
                ),
                SizedBox(height: 10),
                Text('주식 비중 (%) : ${state.stockRatio.toStringAsFixed(0)}'),
                Slider(
                  value: state.stockRatio,
                  min: 0,
                  max: 100,
                  divisions: 100,
                  label: state.stockRatio.toStringAsFixed(0),
                  onChanged: (value) {
                    bloc.add(StockRatioChanged(value));
                  },
                ),
                if (state.isStockDetailOn) ...[
                  SizedBox(height: 10),
                  Text(
                      '개별 주식 비중 (%) : ${state.individualStockRatio.toStringAsFixed(0)}'),
                  Slider(
                    value: state.individualStockRatio,
                    min: 0,
                    max: 100,
                    divisions: 100,
                    label: state.individualStockRatio.toStringAsFixed(0),
                    onChanged: (value) {
                      bloc.add(IndividualStockRatioChanged(value));
                    },
                  ),
                  Text(
                      '지수 주식 비중 (%) : ${state.indexStockRatio.toStringAsFixed(0)}'),
                  Slider(
                    value: state.indexStockRatio,
                    min: 0,
                    max: 100,
                    divisions: 100,
                    label: state.indexStockRatio.toStringAsFixed(0),
                    onChanged: (value) {
                      bloc.add(IndexStockRatioChanged(value));
                    },
                  ),
                ],
                SizedBox(height: 10),
                if (state.isBondEvaluationEnabled) ...[
                  Text('채권 비중 (%) : ${state.bondRatio.toStringAsFixed(0)}'),
                  Slider(
                    value: state.bondRatio,
                    min: 0,
                    max: 100,
                    divisions: 100,
                    label: state.bondRatio.toStringAsFixed(0),
                    onChanged: (value) {
                      bloc.add(BondRatioChanged(value));
                    },
                  ),
                  if (state.isBondDetailOn) ...[
                    SizedBox(height: 10),
                    Text(
                        '개별 채권 비중 (%) : ${state.individualBondRatio.toStringAsFixed(0)}'),
                    Slider(
                      value: state.individualBondRatio,
                      min: 0,
                      max: 100,
                      divisions: 100,
                      label: state.individualBondRatio.toStringAsFixed(0),
                      onChanged: (value) {
                        bloc.add(IndividualBondRatioChanged(value));
                      },
                    ),
                    Text(
                        '지수 채권 비중 (%) : ${state.indexBondRatio.toStringAsFixed(0)}'),
                    Slider(
                      value: state.indexBondRatio,
                      min: 0,
                      max: 100,
                      divisions: 100,
                      label: state.indexBondRatio.toStringAsFixed(0),
                      onChanged: (value) {
                        bloc.add(IndexBondRatioChanged(value));
                      },
                    ),
                  ],
                ],
              ],
            );
          },
        ),
      ),
    );
  }
}

// ──────────────────────────────
// Bloc 관련 코드
// ──────────────────────────────

// 이벤트 정의
abstract class RebalancingEvent {}

class TotalInvestmentChanged extends RebalancingEvent {
  final String totalInvestment;

  TotalInvestmentChanged(this.totalInvestment);
}

class CurrentStockValueChanged extends RebalancingEvent {
  final String currentStockValue;

  CurrentStockValueChanged(this.currentStockValue);
}

class CurrentBondValueChanged extends RebalancingEvent {
  final String currentBondValue;

  CurrentBondValueChanged(this.currentBondValue);
}

class CashRatioChanged extends RebalancingEvent {
  final double cashRatio;

  CashRatioChanged(this.cashRatio);
}

class StockRatioChanged extends RebalancingEvent {
  final double stockRatio;

  StockRatioChanged(this.stockRatio);
}

class BondRatioChanged extends RebalancingEvent {
  final double bondRatio;

  BondRatioChanged(this.bondRatio);
}

class IndividualStockRatioChanged extends RebalancingEvent {
  final double individualStockRatio;

  IndividualStockRatioChanged(this.individualStockRatio);
}

class IndexStockRatioChanged extends RebalancingEvent {
  final double indexStockRatio;

  IndexStockRatioChanged(this.indexStockRatio);
}

class IndividualBondRatioChanged extends RebalancingEvent {
  final double individualBondRatio;

  IndividualBondRatioChanged(this.individualBondRatio);
}

class IndexBondRatioChanged extends RebalancingEvent {
  final double indexBondRatio;

  IndexBondRatioChanged(this.indexBondRatio);
}

class ToggleStockDetail extends RebalancingEvent {}

class ToggleBondEvaluation extends RebalancingEvent {}

// 상태 정의
@freezed
class RebalancingState with _$RebalancingState {
  factory RebalancingState({
    @Default("0.0") String totalInvestment,
    @Default("0.0") String currentStockValue,
    @Default("0.0") String currentBondValue,
    @Default(0.0) double cashRatio,
    @Default(0.0) double stockRatio,
    @Default(0.0) double bondRatio,
    @Default(0.0) double individualStockRatio,
    @Default(0.0) double indexStockRatio,
    @Default(0.0) double individualBondRatio,
    @Default(0.0) double indexBondRatio,
    @Default(false) bool isStockDetailOn,
    @Default(false) bool isBondEvaluationEnabled,
  }) = _RebalancingState;
}

// ──────────────────────────────
// Bloc 관련 코드 (수정된 이벤트 핸들러)
// ──────────────────────────────

class RebalancingBloc extends Bloc<RebalancingEvent, RebalancingState> {
  RebalancingBloc() : super(RebalancingState()) {
    on<TotalInvestmentChanged>((event, emit) {
      emit(state.copyWith(totalInvestment: event.totalInvestment));
    });
    on<CurrentStockValueChanged>((event, emit) {
      emit(state.copyWith(currentStockValue: event.currentStockValue));
    });
    on<CurrentBondValueChanged>((event, emit) {
      emit(state.copyWith(currentBondValue: event.currentBondValue));
    });

    // 두 슬라이더 모드: 채권 사용이 off인 경우 (세부설정이 off일 때)
    // 세 개 모드: 채권 사용이 on인 경우 (세 개의 슬라이더: 현금, 주식, 채권)
    on<CashRatioChanged>((event, emit) {
      double newCash;
      if (state.isBondEvaluationEnabled) {
        // 채권 사용이 on인 경우: cash + stock + bond = 100
        // cash의 최대값은 100 - state.stockRatio (그 후 bond가 채워짐)
        double maxCash = 100 - state.stockRatio;
        newCash = event.cashRatio.clamp(0, maxCash);
        double newBond = 100 - (newCash + state.stockRatio);
        emit(state.copyWith(cashRatio: newCash, bondRatio: newBond));
      } else {
        // 채권 사용 off: cash + stock = 100
        double maxCash = 100;
        newCash = event.cashRatio.clamp(0, maxCash);
        double newStock = 100 - newCash;
        emit(state.copyWith(cashRatio: newCash, stockRatio: newStock));
      }
    });

    on<StockRatioChanged>((event, emit) {
      double newStock;
      if (state.isBondEvaluationEnabled) {
        // 채권 사용 on인 경우: cash + stock + bond = 100
        // stock의 최대값은 100 - state.cashRatio
        double maxStock = 100 - state.cashRatio;
        newStock = event.stockRatio.clamp(0, maxStock);
        double newBond = 100 - (state.cashRatio + newStock);
        emit(state.copyWith(stockRatio: newStock, bondRatio: newBond));
      } else {
        // 채권 사용 off: cash + stock = 100
        double maxStock = 100;
        newStock = event.stockRatio.clamp(0, maxStock);
        double newCash = 100 - newStock;
        emit(state.copyWith(stockRatio: newStock, cashRatio: newCash));
      }
    });

    on<BondRatioChanged>((event, emit) {
      if (state.isBondEvaluationEnabled) {
        // 채권 사용 on인 경우: cash + stock + bond = 100
        // bond의 최대값은 100 - (cash + stock)
        double maxBond = 100 - (state.cashRatio + state.stockRatio);
        double newBond = event.bondRatio.clamp(0, maxBond);
        double newStock = 100 - (state.cashRatio + newBond);
        emit(state.copyWith(bondRatio: newBond, stockRatio: newStock));
      }
    });

    // 주식 세부 설정 모드: 개별 주식과 지수 주식의 합이 100이 되어야 함.
    on<IndividualStockRatioChanged>((event, emit) {
      double newInd = event.individualStockRatio;
      double newIndex = 100 - newInd;
      emit(state.copyWith(
        individualStockRatio: newInd,
        indexStockRatio: newIndex,
      ));
    });

    on<IndexStockRatioChanged>((event, emit) {
      double newIndex = event.indexStockRatio;
      double newInd = 100 - newIndex;
      emit(state.copyWith(
        indexStockRatio: newIndex,
        individualStockRatio: newInd,
      ));
    });

    // 채권 세부 설정 모드: 개별 채권과 지수 채권의 합이 100이 되어야 함.
    on<IndividualBondRatioChanged>((event, emit) {
      double newIndBond = event.individualBondRatio;
      double newIndexBond = 100 - newIndBond;
      emit(state.copyWith(
        individualBondRatio: newIndBond,
        indexBondRatio: newIndexBond,
      ));
    });

    on<IndexBondRatioChanged>((event, emit) {
      double newIndexBond = event.indexBondRatio;
      double newIndBond = 100 - newIndexBond;
      emit(state.copyWith(
        indexBondRatio: newIndexBond,
        individualBondRatio: newIndBond,
      ));
    });

    on<ToggleStockDetail>((event, emit) {
      emit(state.copyWith(isStockDetailOn: !state.isStockDetailOn));
    });

    on<ToggleBondEvaluation>((event, emit) {
      emit(state.copyWith(
        isBondEvaluationEnabled: !state.isBondEvaluationEnabled,
      ));
    });
  }
}

@freezed
class MyClass with _$MyClass {
  factory MyClass({String? a, int? b}) = _MyClass;
}
