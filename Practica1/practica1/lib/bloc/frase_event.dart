part of 'frase_bloc.dart';

abstract class FraseEvent extends Equatable {
  const FraseEvent();

  @override
  List<Object> get props => [];
}

class FraseGet extends FraseEvent {}
