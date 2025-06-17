part of 'scan_cubit.dart';

sealed class ScanState extends Equatable {
  const ScanState();

  @override
  List<Object> get props => [];
}

final class ScanInitial extends ScanState {}

final class ScanProccessing extends ScanState {}

final class ScanSuccess extends ScanState {
  final AiModelResponse? modelResponse;
  const ScanSuccess({required this.modelResponse});
}

final class ScanFailure extends ScanState {
  final String errMessage;
  const ScanFailure({required this.errMessage});
}
