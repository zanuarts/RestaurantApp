import 'package:equatable/equatable.dart';

abstract class DetailEvent extends Equatable {
  const DetailEvent();
}

// tambahan property meh bisa nyokot id pas bloc call
class GetDetailList extends DetailEvent {
  final String restaurantId;

  const GetDetailList(this.restaurantId);

  @override
  List<Object> get props => null;
}
