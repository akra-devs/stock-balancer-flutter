import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:intl/intl.dart';

part 'portfolio_tab.freezed.dart';

/// 포트폴리오 항목 모델 (Freezed 사용)
@freezed
class PortfolioItem with _$PortfolioItem {
  factory PortfolioItem({
    required DateTime savedAt,
    required double rebalanceAmount, // 양수: 매도, 음수: 매수
    required double totalInvestment,
    required double currentStockValue,
  }) = _PortfolioItem;
}

/// 포트폴리오 이벤트 정의
@freezed
class PortfolioEvent with _$PortfolioEvent {
  const factory PortfolioEvent.add(PortfolioItem item) = _AddPortfolioItem;

  const factory PortfolioEvent.remove(PortfolioItem item) =
      _RemovePortfolioItem;
// 추후 수정 이벤트도 추가 가능
}

/// 포트폴리오 상태 정의
@freezed
class PortfolioState with _$PortfolioState {
  factory PortfolioState({
    @Default([]) List<PortfolioItem> items,
  }) = _PortfolioState;
}

/// 포트폴리오 Bloc: 이벤트에 따라 항목을 추가/삭제하며 상태를 관리
class PortfolioBloc extends Bloc<PortfolioEvent, PortfolioState> {
  PortfolioBloc() : super(PortfolioState()) {
    on<_AddPortfolioItem>((event, emit) {
      final newList = List<PortfolioItem>.from(state.items)..add(event.item);
      newList.sort((a, b) => b.savedAt.compareTo(a.savedAt));
      emit(state.copyWith(items: newList));
    });
    on<_RemovePortfolioItem>((event, emit) {
      final newList = List<PortfolioItem>.from(state.items)..remove(event.item);
      emit(state.copyWith(items: newList));
    });
  }
}

/// 포트폴리오 탭 페이지: 저장된 리벨런싱 결과 목록을 카드 형태로 표시
class PortfolioPage extends StatelessWidget {
  const PortfolioPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PortfolioBloc(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('포트폴리오'),
        ),
        body: BlocBuilder<PortfolioBloc, PortfolioState>(
          builder: (context, state) {
            if (state.items.isEmpty) {
              return Center(child: Text('저장된 리벨런싱 결과가 없습니다.'));
            }
            return ListView.builder(
              itemCount: state.items.length,
              itemBuilder: (context, index) {
                final item = state.items[index];
                final dateStr =
                    DateFormat('yyyy-MM-dd HH:mm').format(item.savedAt);
                final isPositive = item.rebalanceAmount > 0;
                final action = isPositive ? '매도' : '매수';
                final amountStr =
                    '${isPositive ? '+' : '-'}${item.rebalanceAmount.abs().toStringAsFixed(2)}';

                return Dismissible(
                  key: Key(item.savedAt.toString()),
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
                      subtitle: Text('총 자산 변화: $amountStr ($action)'),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  PortfolioDetailPage(item: item)),
                        );
                      },
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

/// 포트폴리오 상세보기 페이지: 선택한 항목의 세부 정보를 표시
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
            Text('총 매수원금: ${item.totalInvestment}',
                style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            Text('현재 주식 평가 금액: ${item.currentStockValue}',
                style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            Text(
                '리벨런싱 결과: 주식을 ${item.rebalanceAmount.abs().toStringAsFixed(2)} 만큼 $action 하세요.',
                style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
