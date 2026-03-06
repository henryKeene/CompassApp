import 'package:flutter_test/flutter_test.dart';
import 'package:permission_service/permission_service.dart';

import 'helpers/mock_permission_service.dart';
import 'helpers/test_setup.dart';

Future<void> locationPermissionIsDenied(WidgetTester tester) async {
  (getIt<PermissionService>() as MockPermissionService).setGranted(
    granted: false,
  );
}
