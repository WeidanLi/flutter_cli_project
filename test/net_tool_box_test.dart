import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_cli_project/infrastructure/base_model/PbResultDto.pb.dart';
import 'package:flutter_cli_project/infrastructure/net_tool_box.dart';
import 'package:flutter_cli_project/mock/mock_holder.dart';

void main() {

  // 需要配合后端
  test('GET请求测试', () async {
    var future = await NetTool().get('http://127.0.0.1:8205/pbtest');
    print(future.success);
  });

  // 需要配合后端
  test('POST请求测试', () async {
    var req = PbResultDto();
    req.message = '测试调用POSTJSON';

    var future = await NetTool().post('http://127.0.0.1:8205/pbtest', request: req);
    print(future.message);
  });

  // Mock测试
  INetTool mockNetTool = MockNetTool();
  MockData.initRouter();

  test('测试Mock请求工具', () async {
    var result = await mockNetTool.post('/v1/user/login');
    expect('testMock', result.message);

    result = await mockNetTool.post('/v1/user/login?b=2&a=1');
    expect('testMock', result.message);

    result = await mockNetTool.post('/v1/user/login?a=1&b=2');
    expect('testMock', result.message);

    result = await mockNetTool.post('/v1/user/login', queryParameters: {'a': '1', 'b': '2'});
    expect('testMock', result.message);

  });

}
