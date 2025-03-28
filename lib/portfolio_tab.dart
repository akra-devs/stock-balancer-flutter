import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:intl/intl.dart';
import 'package:stock_rebalance/extensions.dart';
import 'package:stock_rebalance/rebalancing_tab.dart';
import 'package:stock_rebalance/repository/PortfolioRepository.dart';
import 'package:uuid/uuid.dart';

part 'portfolio_tab.freezed.dart';

@freezed
class PortfolioItem with _$PortfolioItem {
  factory PortfolioItem({
    required String id,
    required DateTime savedAt,
    required double totalInvestment,
    required double beforeCashValue,
    required double beforeStockValue,
    required double? beforeBondValue,
    required double? beforeIndexValue,
    required RebalanceResult result,
  }) = _PortfolioItem;

  factory PortfolioItem.create({
    required double totalInvestment,
    required double beforeCashValue,
    required double beforeStockValue,
    required double? beforeBondValue,
    required double? beforeIndexValue,
    required RebalanceResult result,
  }) {
    final String generatedId = const Uuid().v4();
    return PortfolioItem(
      id: generatedId,
      savedAt: DateTime.now(),
      totalInvestment: totalInvestment,
      beforeCashValue: beforeCashValue,
      beforeStockValue: beforeStockValue,
      beforeBondValue: beforeBondValue,
      beforeIndexValue: beforeIndexValue,
      result: result,
    );
  }
}

extension PortfolioItemExtension on PortfolioItem {
  double getTotalInvestmentDelta() {
    final before = totalInvestment;
    final after = beforeStockValue +(beforeBondValue ?? 0);
    print('before: $before, after: $after');
    return after - before;
  }
  /*
  * 100
  * 100
  * 50
  *
  * */
}

@freezed
class PortfolioEvent with _$PortfolioEvent {
  const factory PortfolioEvent.load() = _LoadPortfolioItem; // DB 초기 로드 이벤트 추가
  const factory PortfolioEvent.add(PortfolioItem item) = _AddPortfolioItem;

  const factory PortfolioEvent.remove(PortfolioItem item) =
      _RemovePortfolioItem;

  const factory PortfolioEvent.change(PortfolioItem item) =
      _ChangePortfolioItem;
}

@freezed
class PortfolioState with _$PortfolioState {
  factory PortfolioState({
    @Default({}) Map<String, PortfolioItem> items,
  }) = _PortfolioState;
}

class PortfolioBloc extends Bloc<PortfolioEvent, PortfolioState> {
  final PortfolioRepository repository;

  PortfolioBloc({required this.repository}) : super(PortfolioState()) {
    // 앱 시작 시 DB에서 데이터를 로드하여 상태 초기화
    on<_LoadPortfolioItem>((event, emit) async {
      final items = await repository.fetchPortfolioItems();
      emit(state.copyWith(items: items));
    });
    // 아이템 추가: Repository에 추가한 후, 최신 상태를 다시 불러옴
    on<_AddPortfolioItem>((event, emit) async {
      await repository.addPortfolioItem(event.item);
      final newMap = Map<String, PortfolioItem>.from(state.items);
      newMap[event.item.id] = event.item;
      emit(state.copyWith(items: newMap));
    });
    // 아이템 삭제: Repository에 삭제한 후, 최신 상태를 다시 불러옴
    on<_RemovePortfolioItem>((event, emit) async {
      await repository.removePortfolioItem(event.item.id);
      final newMap = Map<String, PortfolioItem>.from(state.items);
      newMap.remove(event.item.id);
      emit(state.copyWith(items: newMap));
    });
    // 아이템 수정: Repository에 수정한 후, 최신 상태를 다시 불러옴
    on<_ChangePortfolioItem>((event, emit) async {
      await repository.updatePortfolioItem(event.item);
      add(const PortfolioEvent.load());
    });
  }
}

class PortfolioPage extends StatelessWidget {
  const PortfolioPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('포트폴리오'),
      ),
      body: BlocBuilder<PortfolioBloc, PortfolioState>(
        builder: (context, state) {
          if (state.items.isEmpty) {
            return Center(child: Text('저장된 리벨런싱 결과가 없습니다.'));
          }
          final itemsList = state.items.values.toList()
            ..sort((a, b) => b.savedAt.compareTo(a.savedAt));

          return ListView.builder(
            itemCount: itemsList.length,
            itemBuilder: (context, index) {
              final item = itemsList[index];
              final dateStr =
                  DateFormat('yyyy-MM-dd HH:mm').format(item.savedAt);
              final isPositive = item.result.stockAdjustmentAmount > 0;
              final amountStr = item.getTotalInvestmentDelta();

              return Dismissible(
                key: Key(item.id),
                background: Container(
                  color: Colors.red,
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Icon(Icons.delete, color: Colors.white),
                ),
                secondaryBackground: Container(
                  color: Colors.red,
                  alignment: Alignment.centerRight,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Icon(Icons.delete, color: Colors.white),
                ),
                onDismissed: (_) {
                  context
                      .read<PortfolioBloc>()
                      .add(PortfolioEvent.remove(item));
                },
                child: Card(
                  margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  child: ListTile(
                    leading: Icon(
                      isPositive ? Icons.arrow_upward : Icons.arrow_downward,
                      color: isPositive ? Colors.green : Colors.red,
                    ),
                    title: Text(dateStr),
                    subtitle: Text('총 자산 변화: $amountStr'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PortfolioDetailPage(item: item),
                        ),
                      );
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class PortfolioDetailPage extends StatelessWidget {
  final PortfolioItem item;

  const PortfolioDetailPage({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dateStr = DateFormat('yyyy-MM-dd HH:mm').format(item.savedAt);
    final isPositive = item.result.stockAdjustmentAmount > 0;
    final action = isPositive ? '매도' : '매수';

    return Scaffold(
      appBar: AppBar(
        title: Text('포트폴리오 상세'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('저장 일시: $dateStr', style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            Text('총 매수원금: ${item.totalInvestment.toNumberFormat()} 원',
                style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            Text('현재 주식 평가 금액: ${item.beforeStockValue.toNumberFormat()} 원',
                style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            const Text('리벨런싱 결과:'),
            SizedBox(height: 2),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '주식을 ${item.result.stockAdjustmentAmount.abs().toNumberFormat()} 원 만큼 $action 하세요.',
                  style: TextStyle(fontSize: 16),
                ),
                if (item.result.individualAdjustment != null)
                  Text(
                    '개별 주식을 ${item.result.individualAdjustment!.abs().toNumberFormat()} 원 만큼 '
                    '${item.result.individualAdjustment! > 0 ? '매수' : '매도'} 하세요.',
                    style: TextStyle(fontSize: 16),
                  ),
                if (item.result.indexAdjustment != null)
                  Text(
                    '지수 주식을 ${item.result.indexAdjustment!.abs().toNumberFormat()} 원 만큼 '
                    '${item.result.indexAdjustment! > 0 ? '매수' : '매도'} 하세요.',
                    style: TextStyle(fontSize: 16),
                  ),
                if (item.result.bondAdjustmentAmount != null)
                  Text(
                    '채권을 ${item.result.bondAdjustmentAmount!.abs().toNumberFormat()} 원 만큼 '
                    '${item.result.bondAdjustmentAmount! > 0 ? '매수' : '매도'} 하세요.',
                    style: TextStyle(fontSize: 16),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
