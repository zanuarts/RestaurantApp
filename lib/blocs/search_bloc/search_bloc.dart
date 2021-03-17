import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_app/blocs/search_bloc/search_event.dart';
import 'package:restaurant_app/blocs/search_bloc/search_state.dart';
import 'package:restaurant_app/data/api/api_repository.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final ApiRepository _apiRepository = ApiRepository();

  @override
  SearchState get initialState => SearchInitial();

  @override
  Stream<SearchState> mapEventToState(
    SearchEvent event) 
    async* {
    if (event is GetSearchList){
      try {
        yield SearchLoading();
        final mList = await _apiRepository.fetchSearch(event.query);
        yield SearchLoaded(mList);
        if (mList.error) {
          yield SearchError(mList.error.toString());
        }
      }
       catch(e){
        yield SearchError("Failed to fetch data");
      }
    }
  }
}