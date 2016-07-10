package ${utilsPackage};

import android.os.Environment;
import android.util.Log;

import ${packageName}.BuildConfig;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;


/**
 * 日志
 */
public class Logger {

    private static SimpleDateFormat logfile = new SimpleDateFormat("yyyy-MM-dd");
    private static SimpleDateFormat myLogSdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    private static String MYLOG_PATH_SDCARD_DIR = Environment.getExternalStorageDirectory().getAbsolutePath();
    private static String MYLOGFILEName = "Log.txt";

    public static void i(String tag, String msg) {
        if (!isDebug()) {
            return;
        }

        Log.i(tag, msg);
        writeLogToFile("i", tag, msg);
    }

    private static boolean isDebug() {
        return BuildConfig.DEBUG;
    }

    /**
     * 打开日志文件并写入日志
     *
     * @return
     **/
    private static void writeLogToFile(String mylogtype, String tag, String text) {// 新建或打开日志文件
        Date nowtime = new Date();
        String needWriteFiel = logfile.format(nowtime);
        String needWriteMessage = myLogSdf.format(nowtime) + "    " + mylogtype + "    " + tag + "    " + text;
        File file = new File(MYLOG_PATH_SDCARD_DIR, needWriteFiel + MYLOGFILEName);
        try {
            FileWriter filerWriter = new FileWriter(file, true);//后面这个参数代表是不是要接上文件中原来的数据，不进行覆盖
            BufferedWriter bufWriter = new BufferedWriter(filerWriter);
            bufWriter.write(needWriteMessage);
            bufWriter.newLine();
            bufWriter.close();
            filerWriter.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

}
