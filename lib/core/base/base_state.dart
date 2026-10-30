import 'package:equatable/equatable.dart';

abstract class BaseState extends Equatable {
  const BaseState();

  @override
  List<Object?> get props => [];
}

class ButtonEnabledState extends BaseState {
  const ButtonEnabledState();
}

class ButtonDisabledState extends BaseState {
  const ButtonDisabledState();
}

class ButtonLoadingState extends BaseState {
  const ButtonLoadingState();
}

class InitialState extends BaseState {
  const InitialState();
}

class LoadingState extends BaseState {
  LoadingState() : timestamp = DateTime.now();

  final DateTime timestamp;

  @override
  List<Object?> get props => [timestamp];
}

class ErrorState extends BaseState {
  const ErrorState(this.data);

  final dynamic data;

  @override
  List<Object?> get props => [data];
}

class LoadedState<T> extends BaseState {
  const LoadedState(
    this.data, {
    this.mappedData,
    this.canPop = false,
    this.isHidden = true,
  });

  final T? data;
  final dynamic mappedData;
  final bool? canPop;
  final bool isHidden;

  @override
  List<Object?> get props => [data, mappedData, canPop, isHidden];
}
