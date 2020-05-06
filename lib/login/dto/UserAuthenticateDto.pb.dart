///
//  Generated code. Do not modify.
//  source: UserAuthenticateDto.proto
//
// @dart = 2.3
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class UserAuthenticateReqDto extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('UserAuthenticateReqDto', createEmptyInstance: create)
    ..aOS(1, 'userName', protoName: 'userName')
    ..aOS(2, 'password')
    ..hasRequiredFields = false
  ;

  UserAuthenticateReqDto._() : super();
  factory UserAuthenticateReqDto() => create();
  factory UserAuthenticateReqDto.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UserAuthenticateReqDto.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  UserAuthenticateReqDto clone() => UserAuthenticateReqDto()..mergeFromMessage(this);
  UserAuthenticateReqDto copyWith(void Function(UserAuthenticateReqDto) updates) => super.copyWith((message) => updates(message as UserAuthenticateReqDto));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static UserAuthenticateReqDto create() => UserAuthenticateReqDto._();
  UserAuthenticateReqDto createEmptyInstance() => create();
  static $pb.PbList<UserAuthenticateReqDto> createRepeated() => $pb.PbList<UserAuthenticateReqDto>();
  @$core.pragma('dart2js:noInline')
  static UserAuthenticateReqDto getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UserAuthenticateReqDto>(create);
  static UserAuthenticateReqDto _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userName => $_getSZ(0);
  @$pb.TagNumber(1)
  set userName($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasUserName() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserName() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get password => $_getSZ(1);
  @$pb.TagNumber(2)
  set password($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasPassword() => $_has(1);
  @$pb.TagNumber(2)
  void clearPassword() => clearField(2);
}

class UserAuthenticateRespDto extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('UserAuthenticateRespDto', createEmptyInstance: create)
    ..aOS(1, 'token')
    ..pPS(2, 'resourceCodes', protoName: 'resourceCodes')
    ..hasRequiredFields = false
  ;

  UserAuthenticateRespDto._() : super();
  factory UserAuthenticateRespDto() => create();
  factory UserAuthenticateRespDto.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UserAuthenticateRespDto.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  UserAuthenticateRespDto clone() => UserAuthenticateRespDto()..mergeFromMessage(this);
  UserAuthenticateRespDto copyWith(void Function(UserAuthenticateRespDto) updates) => super.copyWith((message) => updates(message as UserAuthenticateRespDto));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static UserAuthenticateRespDto create() => UserAuthenticateRespDto._();
  UserAuthenticateRespDto createEmptyInstance() => create();
  static $pb.PbList<UserAuthenticateRespDto> createRepeated() => $pb.PbList<UserAuthenticateRespDto>();
  @$core.pragma('dart2js:noInline')
  static UserAuthenticateRespDto getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UserAuthenticateRespDto>(create);
  static UserAuthenticateRespDto _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get token => $_getSZ(0);
  @$pb.TagNumber(1)
  set token($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasToken() => $_has(0);
  @$pb.TagNumber(1)
  void clearToken() => clearField(1);

  @$pb.TagNumber(2)
  $core.List<$core.String> get resourceCodes => $_getList(1);
}

