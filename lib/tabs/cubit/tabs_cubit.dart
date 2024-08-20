import 'package:bloc/bloc.dart';

class TabsCubit extends Cubit<int> {
  TabsCubit() : super(0);

  void selectPage(int index) async {
    emit(index);
  }
}
