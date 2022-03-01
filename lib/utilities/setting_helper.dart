import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:ios_utsname_ext/extension.dart';

class SettingHelper {

  static Future<void> sendEmail(BuildContext context) async {
    String body = await getEmailBody();
    final Email email = Email(
      body: body,
      subject: '[담타 앱 문의]',
      recipients: ['damta.help@gmail.com'],
      attachmentPaths: [],
      isHTML: false,
    );

    // String platformResponse;

    try {
      await FlutterEmailSender.send(email);
    } catch (error) {
      showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              '메일 앱이 설치되지 않았거나 로그인되어 있지 않아 바로 문의를 전송할 수 없습니다.\n아래 메일로 문의주시거나 카카오톡 채널로 문의해주세요.\n\n\n- 이메일 : damta.help@gmail.com\n- 카카오톡 채널 : @담타',
              style: TextStyle(
                fontSize: 15
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text(
                    '확인',
                    style: TextStyle(
                      color: Colors.black
                    )
                  ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }


}

// 이메일 본문 구현
Future<String> getEmailBody() async {
  Map<String, dynamic> _deviceData = await getDeviceInfo();
  PackageInfo _packageInfo = await getPackageInfo();
  String body = '\n\n\n\n\n';
  body += '아래 내용과 함께 보내주시면 문의사항을 처리하는데 도움이 됩니다.\n';
  body += '-----------------\n';
  body += '앱 버전 : ${_packageInfo.version} \n';
  body += '운영체제 : ${_deviceData['OS']} \n';
  body += '기기 : ${_deviceData['기기']} \n';
  body += '-----------------\n';
  return body;

}
// device 정보 가져오기
Future<Map<String, dynamic>> getDeviceInfo() async {
  final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  Map<String, dynamic> deviceData = <String, dynamic>{};
  if (Platform.isAndroid) {
    deviceData =
        _readAndroidBuildData(await deviceInfoPlugin.androidInfo);
  } else if (Platform.isIOS) {
    deviceData = _readIosDeviceInfo(await deviceInfoPlugin.iosInfo);
  }
  return deviceData;
}

Map<String, dynamic> _readAndroidBuildData(AndroidDeviceInfo build) {
    return <String, dynamic>{
      'OS' : 'Android ${build.version.release} (SDK ${build.version.sdkInt})',
      '기기' : '${build.manufacturer} ${build.model}' 
      // 'version.securityPatch': build.version.securityPatch,
      // 'version.sdkInt': build.version.sdkInt,
      // 'version.release': build.version.release,
      // 'version.previewSdkInt': build.version.previewSdkInt,
      // 'version.incremental': build.version.incremental,
      // 'version.codename': build.version.codename,
      // 'version.baseOS': build.version.baseOS,
      // 'board': build.board,
      // 'bootloader': build.bootloader,
      // 'brand': build.brand,
      // 'device' : build.device,
      // 'display': build.display,
      // 'fingerprint': build.fingerprint,
      // 'hardware': build.hardware,
      // 'host': build.host,
      // 'id': build.id,
      // 'manufacturer': build.manufacturer,
      // 'model': build.model,
      // 'product': build.product,
      // 'supported32BitAbis': build.supported32BitAbis,
      // 'supported64BitAbis': build.supported64BitAbis,
      // 'supportedAbis': build.supportedAbis,
      // 'tags': build.tags,
      // 'type': build.type,
      // 'isPhysicalDevice': build.isPhysicalDevice,
      // 'androidId': build.androidId,
      // 'systemFeatures': build.systemFeatures,
    };
  }

  Map<String, dynamic> _readIosDeviceInfo(IosDeviceInfo data) {
    return <String, dynamic>{
      'OS' : '${data.systemName} ${data.systemVersion}',
      '기기' : '${data.utsname.machine?.iOSProductName}',
      // 'name': data.name,
      // 'systemName': data.systemName,
      // 'systemVersion': data.systemVersion,
      // 'model': data.model,
      // 'localizedModel': data.localizedModel,
      // 'identifierForVendor': data.identifierForVendor,
      // 'isPhysicalDevice': data.isPhysicalDevice,
      // 'utsname.sysname:': data.utsname.sysname,
      // 'utsname.nodename:': data.utsname.nodename,
      // 'utsname.release:': data.utsname.release,
      // 'utsname.version:': data.utsname.version,
      // 'utsname.machine:': data.utsname.machine,
    };
  }

Future<PackageInfo> getPackageInfo() async {
  // appName
  // packageName
  // version
  // buildNumber
  // buildSignature
  final packageInfo = await PackageInfo.fromPlatform();
  return packageInfo;
}