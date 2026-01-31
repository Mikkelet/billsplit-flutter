import 'package:billsplit_flutter/extensions.dart';
import 'package:json_annotation/json_annotation.dart';

part '../../../generated/remote/errors/billsplit_error.g.dart';

@JsonSerializable(createToJson: false)
class BillSplitError extends Error {
  final int code;
  final String message;

  BillSplitError(this.code, this.message);

  factory BillSplitError.fromJson(Json json) => _$BillSplitErrorFromJson(json);
}