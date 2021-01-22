import 'dart:async';
import 'package:restaurant_app/blocs/resto_bloc/resto_event.dart';
import 'package:restaurant_app/blocs/resto_bloc/resto_state.dart';
import 'package:restaurant_app/data/api/api_repository.dart';
import 'package:bloc/bloc.dart';


class RestoBloc extends Bloc<RestoEvent, RestoState> {
  final ApiRepository _apiRepository = ApiRepository();

  @override
  RestoState get initialState => RestoInitial();

  @override
  Stream<RestoState> mapEventToState(
    RestoEvent event) 
    async* {
    if (event is GetRestoList){
      try {
        yield RestoLoading();
        final mList = await _apiRepository.fetchRestoList();
        yield RestoLoaded(mList);
        if (mList.error) {
          yield RestoError(mList.error.toString());
        }
      }
      on NetworkError{
        yield RestoError("Failed to fetch data");
      }
    }
  }
}