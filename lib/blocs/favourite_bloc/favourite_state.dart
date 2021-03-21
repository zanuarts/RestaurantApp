import 'package:equatable/equatable.dart';
import 'package:restaurant_app/data/models/favourite_model.dart';

abstract class FavouriteState extends Equatable {
  const FavouriteState();
}

class FavouriteInitial extends FavouriteState {
  const FavouriteInitial();
  @override
  List<Object> get props => [];
}

class FavouriteLoading extends FavouriteState {
  const FavouriteLoading();
  @override
  List<Object> get props => null;
}

class FavouriteLoaded extends FavouriteState {
  final Favourite favourite;
  const FavouriteLoaded(this.favourite);
  @override
  List<Object> get props => [favourite];
}

class FavouriteError extends FavouriteState {
  final String message;
  const FavouriteError (this.message);
  @override
  List<Object> get props => [message];
}