///
//  Generated code. Do not modify.
//  source: PbResultDto.proto
//
// @dart = 2.3
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'google/protobuf/any.pb.dart' as $0;

class PbResultDto extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('PbResultDto', createEmptyInstance: create)
    ..aOB(1, 'success')
    ..aOS(2, 'message')
    ..aOS(3, 'code')
    ..aOM<$0.Any>(4, 'data', subBuilder: $0.Any.create)
    ..m<$core.String, ExtraMap>(5, 'extra', entryClassName: 'PbResultDto.ExtraEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OM, valueCreator: ExtraMap.create)
    ..hasRequiredFields = false
  ;

  PbResultDto._() : super();
  factory PbResultDto() => create();
  factory PbResultDto.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PbResultDto.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  PbResultDto clone() => PbResultDto()..mergeFromMessage(this);
  PbResultDto copyWith(void Function(PbResultDto) updates) => super.copyWith((message) => updates(message as PbResultDto));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static PbResultDto create() => PbResultDto._();
  PbResultDto createEmptyInstance() => create();
  static $pb.PbList<PbResultDto> createRepeated() => $pb.PbList<PbResultDto>();
  @$core.pragma('dart2js:noInline')
  static PbResultDto getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PbResultDto>(create);
  static PbResultDto _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get code => $_getSZ(2);
  @$pb.TagNumber(3)
  set code($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasCode() => $_has(2);
  @$pb.TagNumber(3)
  void clearCode() => clearField(3);

  @$pb.TagNumber(4)
  $0.Any get data => $_getN(3);
  @$pb.TagNumber(4)
  set data($0.Any v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasData() => $_has(3);
  @$pb.TagNumber(4)
  void clearData() => clearField(4);
  @$pb.TagNumber(4)
  $0.Any ensureData() => $_ensure(3);

  @$pb.TagNumber(5)
  $core.Map<$core.String, ExtraMap> get extra => $_getMap(4);
}

class ExtraMap extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('ExtraMap', createEmptyInstance: create)
    ..m<$core.String, $core.String>(1, 'extra', entryClassName: 'ExtraMap.ExtraEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  ExtraMap._() : super();
  factory ExtraMap() => create();
  factory ExtraMap.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ExtraMap.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  ExtraMap clone() => ExtraMap()..mergeFromMessage(this);
  ExtraMap copyWith(void Function(ExtraMap) updates) => super.copyWith((message) => updates(message as ExtraMap));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ExtraMap create() => ExtraMap._();
  ExtraMap createEmptyInstance() => create();
  static $pb.PbList<ExtraMap> createRepeated() => $pb.PbList<ExtraMap>();
  @$core.pragma('dart2js:noInline')
  static ExtraMap getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ExtraMap>(create);
  static ExtraMap _defaultInstance;

  @$pb.TagNumber(1)
  $core.Map<$core.String, $core.String> get extra => $_getMap(0);
}

