import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:packagekit/packagekit.dart';
import 'package:snapd/snapd.dart';
import 'package:software/package_installer/package_installer_app.dart';
import 'package:software/services/color_generator.dart';
import 'package:software/services/snap_change_service.dart';
import 'package:software/store_app/store_app.dart';
import 'package:ubuntu_service/ubuntu_service.dart';

void main(List<String> args) async {
  if (args.isEmpty) {
    registerService<ColorGenerator>(DominantColorGenerator.new);
    registerService<SnapdClient>(SnapdClient.new, dispose: (s) => s.close());
    registerService<Connectivity>(Connectivity.new);
    registerService<SnapChangeService>(SnapChangeService.new);
    runApp(const StoreApp());
  } else if (args.first.endsWith('.deb')) {
    registerService<PackageKitClient>(
      PackageKitClient.new,
      dispose: (service) => service.close(),
    );
    runApp(
      PackageInstallerApp(filename: args.first),
    );
  }
}
