import 'package:equatable/equatable.dart';

abstract class DetailEvent extends Equatable {
  const DetailEvent();
}

class GetDetailList extends DetailEvent {
  @override
  List<Object> get props => null;
}