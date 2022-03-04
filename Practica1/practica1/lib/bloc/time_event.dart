part of 'time_bloc.dart';

abstract class TimeEvent extends Equatable {
  const TimeEvent();

  @override
  List<Object> get props => [];
}

class TimeGet extends TimeEvent {}
