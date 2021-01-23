import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_app/blocs/detail_bloc/detail_event.dart';
import 'package:restaurant_app/blocs/detail_bloc/detail_state.dart';
import 'package:restaurant_app/data/api/api_repository.dart';

class DetailBloc extends Bloc<DetailEvent, DetailState> {
  final ApiRepository _apiRepository = ApiRepository();

  @override
  DetailState get initialState => DetailInitial();

  @override
  Stream<DetailState> mapEventToState(
    DetailEvent event) 
    async* {
    if (event is GetDetailList){
      try {
        yield DetailLoading();
        final mList = await _apiRepository.fetchRestoDetail();
        yield DetailLoaded(mList);
        if (mList.error) {
          yield DetailError(mList.error.toString());
        }
      }
      on NetworkError{
        yield DetailError("Failed to fetch data");
      }
    }
  }
}