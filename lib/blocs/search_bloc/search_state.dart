import 'package:equatable/equatable.dart';
import 'package:restaurant_app/data/models/search_model.dart';

abstract class SearchState extends Equatable {
  const SearchState();

  get search => null;
}

class SearchInitial extends SearchState {
  const SearchInitial();
  @override
  List<Object> get props => [];
}

class SearchLoading extends SearchState {
  const SearchLoading();
  @override
  List<Object> get props => null;
}

class SearchLoaded extends SearchState {
  final RestoSearch search;
  const SearchLoaded(this.search);
  @override
  List<Object> get props => [search];
}

class SearchError extends SearchState {
  final String message;
  const SearchError (this.message);
  @override
  List<Object> get props => [message];
}