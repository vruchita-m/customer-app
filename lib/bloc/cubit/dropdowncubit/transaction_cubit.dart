import 'package:flutter_bloc/flutter_bloc.dart';

class TransactionCubitDropdown extends Cubit<String?> {
  TransactionCubitDropdown() : super(null);

  void selecMonths(String month) => emit(month);
}
