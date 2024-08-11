part of 'service_booking_bloc.dart';

enum FormStatus { initial, pending, success, error }

enum RequestStatus { pending, accepted, completed }

@immutable
class ServiceBookingState {
  const ServiceBookingState({
    this.address = '',
    this.serviceTitle = '',
    this.status = FormStatus.initial,
    this.errorMsg,
    this.dateTime = '',
    this.totalPrice = 0,
    this.discountPrice = 0,
    this.creatAt = '',
    this.discription = '',
    this.workType='',
    this.userId = '',
    this.requestStatus = RequestStatus.pending,
  });

  final String address;
  final String discription;
  final String userId;
  final String creatAt;
  final String serviceTitle;
  final int totalPrice;
  final int discountPrice;
  final String dateTime;
  final String workType;
  final FormStatus status;
  final RequestStatus requestStatus;
  final String? errorMsg;

  ServiceBookingState copyWith({
    String? address,
    String? workType,
    int? totalPrice,
    String? dateTime,
    int? discountPrice,
    String? serviceTitle,
    String? discription,
    String? creatAt,
    FormStatus? status,
    String? userId,
    String? errorMsg,
  }) {
    return ServiceBookingState(
        address: address ?? this.address,
        workType: workType??this.workType,
        userId: userId ?? this.userId,
        discountPrice: discountPrice ?? this.discountPrice,
        totalPrice: totalPrice ?? this.totalPrice,
        creatAt: creatAt ?? this.creatAt,
        dateTime: dateTime ?? this.dateTime,
        serviceTitle: serviceTitle ?? this.serviceTitle,
        status: status ?? this.status,
        errorMsg: errorMsg ?? this.errorMsg,
        discription: discription ?? this.discription);
  }

  factory ServiceBookingState.initial() {
    return const ServiceBookingState();
  }
}
