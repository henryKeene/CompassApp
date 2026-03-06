import 'package:flutter/material.dart';
import 'package:permission_service/permission_service.dart';

class MockPermissionService extends PermissionService {
  bool _granted = true;

  void setGranted({required bool granted}) {
    _granted = granted;
  }

  @override
  Future<bool> requestLocationPermission(BuildContext context) async {
    return _granted;
  }
}
