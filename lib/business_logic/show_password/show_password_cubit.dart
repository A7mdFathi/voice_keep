import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class ShowPasswordCubit extends Cubit<bool> {
  ShowPasswordCubit() : super(false);

  bool _showPassword = false;

  void showPasswordToState() {
    _showPassword = !_showPassword;
    emit(_showPassword);
  }
}
