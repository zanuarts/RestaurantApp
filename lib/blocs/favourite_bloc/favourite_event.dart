import 'package:equatable/equatable.dart';

abstract class FavouriteEvent extends Equatable {
  const FavouriteEvent();
}

class GetFavouriteList extends FavouriteEvent {
  @override
  List<Object> get props => null;
}