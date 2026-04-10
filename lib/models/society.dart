import 'package:freezed_annotation/freezed_annotation.dart';

part 'society.freezed.dart';
part 'society.g.dart';

@freezed
abstract class Society with _$Society {
  const factory Society({
    @JsonKey(name: 'society_id') required String societyId,
    required String name,
    required String description,
    @JsonKey(name: 'logo_url') @Default('') String logoUrl,
    required String status,
    @Default([]) List<String> groups,
  }) = _Society;

  factory Society.fromJson(Map<String, dynamic> json) =>
      _$SocietyFromJson(json);
}

@freezed
abstract class SocietyRequest with _$SocietyRequest {
  const factory SocietyRequest({
    @JsonKey(name: 'request_id') required String requestId,
    required String action,
    @JsonKey(name: 'society_name') required String societyName,
    @JsonKey(name: 'requested_by') required String requestedBy,
    @Default([]) List<String> approvals,
    required String status,
  }) = _SocietyRequest;

  factory SocietyRequest.fromJson(Map<String, dynamic> json) =>
      _$SocietyRequestFromJson(json);
}
