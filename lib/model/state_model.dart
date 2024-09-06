import 'dart:convert';

class StateModal {
  StateModal({
    this.indiaStateList,
  });

  factory StateModal.fromJson(String str) =>
      StateModal.fromMap(json.decode(str) as Map<String, dynamic>);

  factory StateModal.fromMap(Map<String, dynamic> json) => StateModal(
        indiaStateList: json['IndiaStateList'] == null
            ? []
            : List<IndiaStateList>.from(
                (json['IndiaStateList'] as Iterable<dynamic>).map(
                  (e) => IndiaStateList.fromMap(e as Map<String, dynamic>),
                ),
              ),
      );

  List<IndiaStateList>? indiaStateList;

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
        'IndiaStateList': indiaStateList == null
            ? []
            : List<dynamic>.from(indiaStateList!.map((x) => x.toMap())),
      };
}

class IndiaStateList {
  IndiaStateList({
    this.name,
    this.value,
  });

  factory IndiaStateList.fromJson(String str) =>
      IndiaStateList.fromMap(json.decode(str) as Map<String, dynamic>);

  factory IndiaStateList.fromMap(Map<String, dynamic> json) => IndiaStateList(
        name: json['name'] as String,
        value: json['value'] as String,
      );
  String? name;
  String? value;

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
        'name': name,
        'value': value,
      };
}
