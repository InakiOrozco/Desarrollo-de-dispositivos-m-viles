part of 'account_bloc.dart';

abstract class AccountState extends Equatable {
  const AccountState();

  @override
  List<Object> get props => [];
}

class AccountInitial extends AccountState {}

class AccountError extends AccountState {
  final String errorMsg;
  AccountError({required this.errorMsg});
  @override
  // TODO: implement props
  List<Object> get props => [errorMsg];
}

class AccountSuccess extends AccountState {
  final Map successMsg;
  AccountSuccess({required this.successMsg});
  @override
  // TODO: implement props
  List<Object> get props => [];
}
