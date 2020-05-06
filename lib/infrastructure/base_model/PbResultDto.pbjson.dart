///
//  Generated code. Do not modify.
//  source: PbResultDto.proto
//
// @dart = 2.3
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type

const PbResultDto$json = const {
  '1': 'PbResultDto',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    const {'1': 'code', '3': 3, '4': 1, '5': 9, '10': 'code'},
    const {'1': 'data', '3': 4, '4': 1, '5': 11, '6': '.google.protobuf.Any', '10': 'data'},
    const {'1': 'extra', '3': 5, '4': 3, '5': 11, '6': '.PbResultDto.ExtraEntry', '10': 'extra'},
  ],
  '3': const [PbResultDto_ExtraEntry$json],
};

const PbResultDto_ExtraEntry$json = const {
  '1': 'ExtraEntry',
  '2': const [
    const {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    const {'1': 'value', '3': 2, '4': 1, '5': 11, '6': '.ExtraMap', '10': 'value'},
  ],
  '7': const {'7': true},
};

const ExtraMap$json = const {
  '1': 'ExtraMap',
  '2': const [
    const {'1': 'extra', '3': 1, '4': 3, '5': 11, '6': '.ExtraMap.ExtraEntry', '10': 'extra'},
  ],
  '3': const [ExtraMap_ExtraEntry$json],
};

const ExtraMap_ExtraEntry$json = const {
  '1': 'ExtraEntry',
  '2': const [
    const {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    const {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': const {'7': true},
};

