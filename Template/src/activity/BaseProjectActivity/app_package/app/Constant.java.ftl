package ${appPackage};

import android.os.Environment;

import java.io.File;

/**
 *
 */
public class Constant {

    private final static String appSdPath = getAvailableCachePath();

    public final static String ApkSavePath = appSdPath + "apk/";
    public final static String AppImageCache = appSdPath + "imageCache/";

    private static String getAvailableCachePath() {
        if (Environment.getExternalStorageState().equals(Environment.MEDIA_MOUNTED)) {

            File exDir = App.instance.getExternalCacheDir();

            if (exDir != null) {
                return exDir.getPath() + "/";
            }
        }
        return App.instance.getCacheDir().getPath() + "/";

    }

}
