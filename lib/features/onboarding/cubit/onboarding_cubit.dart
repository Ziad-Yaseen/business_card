import 'package:flutter_bloc/flutter_bloc.dart';

class OnboardingCubit extends Cubit<int> {
  OnboardingCubit() : super(0);

  static const pageCount = 3;

  bool get isLast => state == pageCount - 1;

  void pageChanged(int index) => emit(index);
}