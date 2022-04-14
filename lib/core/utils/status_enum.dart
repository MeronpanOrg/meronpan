import 'package:freezed_annotation/freezed_annotation.dart';

@JsonEnum()
enum statusEnum {
  @JsonValue(0)
  unknown,
  @JsonValue(1)
  ongoing,
  @JsonValue(2)
  completed,
  @JsonValue(3)
  licensed,
  @JsonValue(4)
  publishingFinished,
  @JsonValue(5)
  cancelled,
  @JsonValue(6)
  onHiatus,
}

extension StatusEnumExtension on statusEnum {
  String get displayTitle {
    switch (this) {
      case statusEnum.unknown:
        return 'Desconocido';
      case statusEnum.ongoing:
        return 'Publicándose';
      case statusEnum.completed:
        return 'Finalizado';
      case statusEnum.cancelled:
        return 'Cancelado';
      default:
        return 'Desconocido';
    }
  }
}
