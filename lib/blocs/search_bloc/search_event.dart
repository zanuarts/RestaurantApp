import 'package:equatable/equatable.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();
}

class GetSearchList extends SearchEvent {
  final String query;

  const GetSearchList(this.query);

  @override
  List<Object> get props => null;
}