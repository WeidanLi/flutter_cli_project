import 'package:flutter_cli_project/infrastructure/base_model/PbResultDto.pb.dart';
import 'package:flutter_cli_project/infrastructure/base_model/google/protobuf/any.pb.dart';
import 'package:flutter_cli_project/login/dto/UserAuthenticateDto.pb.dart';
import 'package:protobuf/protobuf.dart' as $pb;

PbResultDto testMock<P extends $pb.GeneratedMessage>({
  P body,
  Map<String, String> param
}) {
  PbResultDto r = PbResultDto();
  r.success = true;
  r.message = 'testMock';
  return r;
}

PbResultDto userAuthenticate<P extends $pb.GeneratedMessage>({
  P body,
  Map<String, String> param
}) {
  UserAuthenticateReqDto req = body as UserAuthenticateReqDto;
  UserAuthenticateRespDto r = UserAuthenticateRespDto();
  if (req.userName == 'Weidan') {
    r.token = '112233';
    r.resourceCodes.addAll(['deliverBillPick', 'deliverBillPick2']);
  } else {
    r.token = '334455';
    r.resourceCodes.addAll(['deliverBillPick2']);
  }

  PbResultDto pbResultDto = PbResultDto();
  pbResultDto.data = Any.pack(r);
  return pbResultDto;
}