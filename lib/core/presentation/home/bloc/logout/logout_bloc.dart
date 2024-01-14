import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../../data/datasources/auth_remote_datasource.dart';

part 'logout_bloc.freezed.dart';
part 'logout_event.dart';
part 'logout_state.dart';

class LogoutBloc extends Bloc<LogoutEvent, LogoutState> {
    LogoutBloc() : super(const _Initial()) {
    on<_Logout>((event, emit) async {
      emit(const LogoutState.loading());
      final response = await AuthRemoteDatasource().logout();
      response.fold(
        (l) => emit(LogoutState.error(l)),
        (r) => emit(const LogoutState.success()),
      );
    });
  }
}
