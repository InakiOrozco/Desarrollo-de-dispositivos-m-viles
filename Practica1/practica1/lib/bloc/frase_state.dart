part of 'frase_bloc.dart';

abstract class FraseState extends Equatable {
  const FraseState();

  @override
  List<Object> get props => [];
}

class FraseInitial extends FraseState {}

class FraseReady extends FraseState {
  final String frase;
  final String autor;
  FraseReady({required this.frase, required this.autor});
  @override
  List<Object> get props => [frase, autor];
}

class FraseError extends FraseState {
  final String error;
  FraseError({required this.error});
  @override
  List<Object> get props => [error];
}
