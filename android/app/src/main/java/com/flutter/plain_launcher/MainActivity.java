package com.flutter.plain_launcher;
import android.content.ComponentName;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.text.TextUtils;

import androidx.annotation.NonNull;
import androidx.core.content.IntentCompat;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodChannel;

public class MainActivity extends FlutterActivity {
  private static final String CHANNEL = "com.flutter.plain_launcher/channel";

  @Override
  public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
  super.configureFlutterEngine(flutterEngine);
    new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL)
      .setMethodCallHandler(
        (call, result) -> {
          switch (call.method) {
            case "openApp":
              if (!call.hasArgument("packageName") || TextUtils.isEmpty(call.argument("packageName").toString())) {
                result.error("ERROR", "Empty or null package name", null);
              } else {
                String packageName = call.argument("packageName").toString();
                boolean restart = call.argument("isRestart");
                result.success(openApp(packageName, restart));
              }
              break;
            default: break;
          }
        });
  }

  private boolean openApp(@NonNull String packageName, boolean isRestart) {
    if (!_isAppInstalled(packageName)) {
      return false;
    }

    Intent launchIntent = getPackageManager().getLaunchIntentForPackage(packageName);

    if (isRestart) {
      ComponentName componentName = getPackageManager().getLaunchIntentForPackage(packageName).getComponent();
       launchIntent = Intent.makeRestartActivityTask(componentName);
    }

    if (getPackageManager().queryIntentActivities(launchIntent, 0).size() > 0) {
      startActivity(launchIntent);
      return true;
    }

    return false;
  }

  private boolean _isAppInstalled(@NonNull String packageName) {
    try {
      getPackageManager().getPackageInfo(packageName, 0);
      return true;
    } catch (PackageManager.NameNotFoundException ignored) {
      return false;
    }
  }
}
