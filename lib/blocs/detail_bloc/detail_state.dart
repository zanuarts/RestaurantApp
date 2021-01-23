import 'package:equatable/equatable.dart';
import 'package:restaurant_app/data/models/detail_model.dart';


abstract class DetailState extends Equatable {
  const DetailState();
}

class DetailInitial extends DetailState {
  const DetailInitial();
  @override
  List<Object> get props => [];
}

class DetailLoading extends DetailState {
  const DetailLoading();
  @override
  List<Object> get props => null;
}

class DetailLoaded extends DetailState {
  final RestoDetail detail;
  const DetailLoaded(this.detail);
  @override
  List<Object> get props => [detail];
}

class DetailError extends DetailState {
  final String message;
  const DetailError (this.message);
  @override
  List<Object> get props => [message];
}