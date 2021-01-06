import 'package:equatable/equatable.dart';
import 'package:restaurant_app/data/models/models.dart';

abstract class RestoState extends Equatable {
  const RestoState();
}

class RestoInitial extends RestoState {
  const RestoInitial();
  @override
  List<Object> get props => [];
}

class RestoLoading extends RestoState {
  const RestoLoading();
  @override
  List<Object> get props => null;
}

class RestoLoaded extends RestoState {
  final Resto resto;
  const RestoLoaded(this.resto);
  @override
  List<Object> get props => [resto];
}

class RestoError extends RestoState {
  final String message;
  const RestoError (this.message);
  @override
  List<Object> get props => [message];
}