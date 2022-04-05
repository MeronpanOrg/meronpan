import 'package:hooks_riverpod/hooks_riverpod.dart';

final uiProvider = StateNotifierProvider<_UiStateNotifier, int>((ref) {
  return _UiStateNotifier();
});

class _UiStateNotifier extends StateNotifier<int> {
  _UiStateNotifier() : super(0);

  changeView(int newIndex) {
    state = newIndex > 0 ? newIndex : 0;
  }
}
