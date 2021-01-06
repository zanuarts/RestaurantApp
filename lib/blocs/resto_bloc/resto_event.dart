import 'package:equatable/equatable.dart';

abstract class RestoEvent extends Equatable {
  const RestoEvent();
}

class GetRestoList extends RestoEvent {
  @override
  List<Object> get props => null;
}