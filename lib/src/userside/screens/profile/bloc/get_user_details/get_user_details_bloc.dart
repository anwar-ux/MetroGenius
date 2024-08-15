import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:metrogeniusorg/services/user/user_details/user_details.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'get_user_details_event.dart';
part 'get_user_details_state.dart';

class GetUserDetailsBloc extends Bloc<GetUserDetailsEvent, GetUserDetailsState> {
  GetUserDetailsBloc() : super(GetUserDeatailsInitial()) {
   on<FetchUserData>(_onFetchData);
    on<DataFetched>(_onDataFetched);
  }

 Future<void> _onFetchData(FetchUserData event, Emitter<GetUserDetailsState> emit) async {
  emit(GetUserDeatailsLoading());
  try {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('userId');
    
    if (userId != null) {
      Stream<DocumentSnapshot<Object?>> dataStream = UserDetails.getUserDetails(userId);

      dataStream.listen((snapshot) {
        add(DataFetched([snapshot]));
      });
    } else {
      emit(const GetUserDeatailsFailed('User ID not found in SharedPreferences'));
    }
  } catch (e) {
    emit(GetUserDeatailsFailed(e.toString()));
  }
}



  void _onDataFetched(DataFetched event, Emitter<GetUserDetailsState> emit) {
    emit(GetUserDeatailsLoaded(event.data));
  }
}
