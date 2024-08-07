import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:metrogeniusorg/services/user/address/address.dart';
import 'package:metrogeniusorg/src/userside/screens/home/bloc/getcategory/getcategory_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'get_address_event.dart';
part 'get_address_state.dart';

class GetAddressBloc extends Bloc<GetAddressEvent, GetAddressState> {
  GetAddressBloc() : super(GetAddressInitial()) {
   on<FetchAddresData>(_onFetchData);
    on<DataFetched>(_onDataFetched);
  }

  Future<void> _onFetchData(FetchAddresData event, Emitter<GetAddressState> emit) async {
    emit(GetAddressLoading());
    try {
      final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('userId');
      Stream<QuerySnapshot> dataStream = await Address.getAddress(userId);
      dataStream.listen((snapshot) {final data = snapshot.docs;
      add(DataFetched(data));
      });
    } catch (e) {
      emit(GetAddressFailed(e.toString()));
    }
  }

  void _onDataFetched(DataFetched event, Emitter<GetAddressState> emit) {
    emit(GetAddressLoaded(event.data));
  }
}
