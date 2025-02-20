import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
                return Text('총 비중: ${totalRatio.toStringAsFixed(0)}% (100% 필요)');
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final state = context.read<RebalancingBloc>().state;
                double totalRatio = state.cashRatio +
                    state.stockRatio +
                    (state.isBondEvaluationEnabled ? state.bondRatio : 0);
                if (totalRatio != 100) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('총 비중이 100%가 되어야 합니다.')),
                  );
                } else {
                  // 리벨런싱 계산 로직 추가
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
              onChanged: (value) =>
                  bloc.add(TotalInvestmentChanged(value)),
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
                BlocBuilder<RebalancingBloc, RebalancingState>(
                  builder: (context, state) {
                    if (!state.isBondEvaluationEnabled) return SizedBox();
                    return Column(
                      children: [
                        Text('세부 설정'),
                        Switch(
                          value: state.isBondDetailOn,
                          onChanged: (_) {
                            bloc.add(ToggleBondDetail());
                          },
                        ),
                      ],
                    );
                  },
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
                  Text('개별 주식 비중 (%) : ${state.individualStockRatio.toStringAsFixed(0)}'),
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
                  Text('지수 주식 비중 (%) : ${state.indexStockRatio.toStringAsFixed(0)}'),
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
                    Text('개별 채권 비중 (%) : ${state.individualBondRatio.toStringAsFixed(0)}'),
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
                    Text('지수 채권 비중 (%) : ${state.indexBondRatio.toStringAsFixed(0)}'),
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

class ToggleBondDetail extends RebalancingEvent {}

// 상태 정의
class RebalancingState {
  final String totalInvestment;
  final String currentStockValue;
  final String currentBondValue;
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

  RebalancingState({
    this.totalInvestment = '',
    this.currentStockValue = '',
    this.currentBondValue = '',
    this.cashRatio = 0.0,
    this.stockRatio = 0.0,
    this.bondRatio = 0.0,
    this.individualStockRatio = 0.0,
    this.indexStockRatio = 0.0,
    this.individualBondRatio = 0.0,
    this.indexBondRatio = 0.0,
    this.isStockDetailOn = false,
    this.isBondEvaluationEnabled = false,
    this.isBondDetailOn = false,
  });

  RebalancingState copyWith({
    String? totalInvestment,
    String? currentStockValue,
    String? currentBondValue,
    double? cashRatio,
    double? stockRatio,
    double? bondRatio,
    double? individualStockRatio,
    double? indexStockRatio,
    double? individualBondRatio,
    double? indexBondRatio,
    bool? isStockDetailOn,
    bool? isBondEvaluationEnabled,
    bool? isBondDetailOn,
  }) {
    return RebalancingState(
      totalInvestment: totalInvestment ?? this.totalInvestment,
      currentStockValue: currentStockValue ?? this.currentStockValue,
      currentBondValue: currentBondValue ?? this.currentBondValue,
      cashRatio: cashRatio ?? this.cashRatio,
      stockRatio: stockRatio ?? this.stockRatio,
      bondRatio: bondRatio ?? this.bondRatio,
      individualStockRatio: individualStockRatio ?? this.individualStockRatio,
      indexStockRatio: indexStockRatio ?? this.indexStockRatio,
      individualBondRatio: individualBondRatio ?? this.individualBondRatio,
      indexBondRatio: indexBondRatio ?? this.indexBondRatio,
      isStockDetailOn: isStockDetailOn ?? this.isStockDetailOn,
      isBondEvaluationEnabled: isBondEvaluationEnabled ?? this.isBondEvaluationEnabled,
      isBondDetailOn: isBondDetailOn ?? this.isBondDetailOn,
    );
  }
}

// Bloc 구현
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
    on<CashRatioChanged>((event, emit) {
      emit(state.copyWith(cashRatio: event.cashRatio));
    });
    on<StockRatioChanged>((event, emit) {
      emit(state.copyWith(stockRatio: event.stockRatio));
    });
    on<BondRatioChanged>((event, emit) {
      emit(state.copyWith(bondRatio: event.bondRatio));
    });
    on<IndividualStockRatioChanged>((event, emit) {
      emit(state.copyWith(individualStockRatio: event.individualStockRatio));
    });
    on<IndexStockRatioChanged>((event, emit) {
      emit(state.copyWith(indexStockRatio: event.indexStockRatio));
    });
    on<IndividualBondRatioChanged>((event, emit) {
      emit(state.copyWith(individualBondRatio: event.individualBondRatio));
    });
    on<IndexBondRatioChanged>((event, emit) {
      emit(state.copyWith(indexBondRatio: event.indexBondRatio));
    });
    on<ToggleStockDetail>((event, emit) {
      emit(state.copyWith(isStockDetailOn: !state.isStockDetailOn));
    });
    on<ToggleBondEvaluation>((event, emit) {
      emit(state.copyWith(
          isBondEvaluationEnabled: !state.isBondEvaluationEnabled,
          isBondDetailOn: false));
    });
    on<ToggleBondDetail>((event, emit) {
      emit(state.copyWith(isBondDetailOn: !state.isBondDetailOn));
    });
  }
}
