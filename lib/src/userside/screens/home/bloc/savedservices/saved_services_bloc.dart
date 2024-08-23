// ignore_for_file: avoid_print

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:metrogeniusorg/services/user/saved/saved_request.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'saved_services_event.dart';
part 'saved_services_state.dart';

class SavedServicesBloc extends Bloc<SavedServicesEvent, SavedServicesState> {
  SavedServicesBloc() : super(SavedServicesInitial()) {
    on<FetchSavedServiceData>(_fetchSavedServiceData);
    on<DataFetched>(_dataFetched);
    on<AddToSave>(_addToSave);
    on<RemoveFromSaved>(_removeFromSaved);
  }
  void _addToSave(AddToSave event, Emitter<SavedServicesState> emit) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userId = prefs.getString('userId');
      final details = SavedService.saveServiceInfo(
          id: event.data['Id'],
          name: event.data['Name'],
          image: event.data['Image'],
          discription: event.data['Discription'],
          price: event.data['Price'],
          checkboxes: event.data['Checkboxes']);
      await SavedService.addToSave(details, userId, event.data['Id']);
    } catch (e) {
      print(e.toString());
    }
  }

  void _removeFromSaved(RemoveFromSaved event, Emitter<SavedServicesState> emit) async {
    try {
      await SavedService.removeFromSaved(event.id);
    } catch (e) {
      print(e.toString());
    }
  }

void _fetchSavedServiceData(FetchSavedServiceData event, Emitter<SavedServicesState> emit) async {
    emit(SavedServicesLoading());
    try {
      final prefs = await SharedPreferences.getInstance();
      final userId = prefs.getString('userId');
      if (userId == null) {
        emit(SavedServicesFailed("User ID not found"));
        return;
      }
      Stream<QuerySnapshot> dataStream = SavedService.getSavedServices(userId);
      await emit.forEach<QuerySnapshot>(
        dataStream,
        onData: (snapshot) {
          final data = snapshot.docs;
          return SavedServicesLoaded(data);
        },
        onError: (error, stackTrace) {
          return SavedServicesFailed(error.toString());
        },
      );
    } catch (e) {
      emit(SavedServicesFailed(e.toString()));
    }
}


  void _dataFetched(DataFetched event, Emitter<SavedServicesState> emit) {
    emit(SavedServicesLoaded(event.data));
  }
}
