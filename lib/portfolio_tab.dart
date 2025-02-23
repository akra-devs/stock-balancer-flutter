import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:intl/intl.dart';
import 'package:stock_rebalance/extensions.dart';
import 'package:stock_rebalance/rebalancing_tab.dart';
import 'package:uuid/uuid.dart';

part 'portfolio_tab.freezed.dart';

@freezed
class PortfolioItem with _$PortfolioItem {
  factory PortfolioItem({
    required String id,
    required DateTime savedAt,
    required double rebalanceAmount,
    required double totalInvestment,
    required double currentStockValue,
  }) = _PortfolioItem;

  factory PortfolioItem.create({
    required double rebalanceAmount,
    required double totalInvestment,
    required double currentStockValue,
  }) {
    final String generatedId = const Uuid().v4();
    return PortfolioItem(
      id: generatedId,
      savedAt: DateTime.now(),
      rebalanceAmount: rebalanceAmount,
      totalInvestment: totalInvestment,
      currentStockValue: currentStockValue,
    );
  }
}

@freezed
class PortfolioEvent with _$PortfolioEvent {
  const factory PortfolioEvent.add(PortfolioItem item) = _AddPortfolioItem;
  const factory PortfolioEvent.remove(PortfolioItem item) = _RemovePortfolioItem;
  const factory PortfolioEvent.change(PortfolioItem item) = _ChangePortfolioItem;
}

@freezed
class PortfolioState with _$PortfolioState {
  factory PortfolioState({
    @Default({}) Map<String, PortfolioItem> items,
  }) = _PortfolioState;
}

class PortfolioBloc extends Bloc<PortfolioEvent, PortfolioState> {
  PortfolioBloc() : super(PortfolioState()) {
    on<_AddPortfolioItem>((event, emit) {
      final newMap = Map<String, PortfolioItem>.from(state.items);
      newMap[event.item.id] = event.item;
      emit(state.copyWith(items: newMap));
    });
    on<_RemovePortfolioItem>((event, emit) {
      final newMap = Map<String, PortfolioItem>.from(state.items);
      newMap.remove(event.item.id);
      emit(state.copyWith(items: newMap));
    });
    on<_ChangePortfolioItem>((event, emit) {
      final newMap = Map<String, PortfolioItem>.from(state.items);
      newMap[event.item.id] = event.item;
      emit(state.copyWith(items: newMap));
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
              final dateStr = DateFormat('yyyy-MM-dd HH:mm').format(item.savedAt);
              final isPositive = item.rebalanceAmount > 0;
              final action = isPositive ? '매도' : '매수';
              final amountStr = '${isPositive ? '+' : '-'}${item.rebalanceAmount.abs().toNumberFormat()}';

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
                  context.read<PortfolioBloc>().add(PortfolioEvent.remove(item));
                },
                child: Card(
                  margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  child: ListTile(
                    leading: Icon(
                      isPositive ? Icons.arrow_upward : Icons.arrow_downward,
                      color: isPositive ? Colors.green : Colors.red,
                    ),
                    title: Text(dateStr),
                    subtitle: Text('총 자산 변화: $amountStr ($action)'),
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
    final isPositive = item.rebalanceAmount > 0;
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
            Text('총 매수원금: ${item.totalInvestment.toNumberFormat()} 원', style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            Text('현재 주식 평가 금액: ${item.currentStockValue.toNumberFormat()} 원', style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            Text(
              '리벨런싱 결과: 주식을 ${item.rebalanceAmount.abs().toNumberFormat()} 원 만큼 $action 하세요.',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
