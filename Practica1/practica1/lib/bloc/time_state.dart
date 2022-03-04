part of 'time_bloc.dart';

abstract class TimeState extends Equatable {
  const TimeState();

  @override
  List<Object> get props => [];
}

class TimeInitial extends TimeState {}

class TimeReady extends TimeState {
  final String time;
  TimeReady({required this.time});
  @override
  List<Object> get props => [time];
}

class TimeError extends TimeState {
  final String error;
  TimeError({required this.error});
  @override
  List<Object> get props => [error];
}
