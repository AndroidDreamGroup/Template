package ${utilsPackage};

import android.annotation.SuppressLint;
import android.os.Bundle;
import android.os.Handler;
import android.os.Message;
import android.text.TextUtils;
import android.util.Log;

import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import java.util.List;

/**
 * 更新组建——提供普通更新、增量更新两种更新方式
 */
public class UpdateUtils {

    private final static String TAG = UpdateUtils.class.getName();

    /**
     * 下载状态 开始
     */
    private final static int DOWN_START = 0;
    /**
     * 下载状态 下载中
     */
    private final static int DOWN_LOADING = 1;
    /**
     * 下载状态 下载错误
     */
    private final static int DOWN_ERROR = 2;
    /**
     * 下载状态 下载完成
     */
    private final static int DOWN_SUCCESS = 3;

    /**
     * APK下载路径
     */
    private String apkUrl;
    /**
     * APK、Patch文件保存路径
     */
    private String apkSavePath;
    /**
     * APK文件保存名称
     */
    private String apkSaveName;
    /**
     * 服务端更新包MD5
     */
    private String md5;

    /**
     * 下载过程回调接口
     */
    private OnDownloadListener mOnDownloadListener;

    /**
     * 是否为增量更新——判定条件：md5 == null ? false : true
     */
    private boolean isIncrementalUpdates = false;


    /**
     * 网络连接是否正常
     */
    private boolean isNetConnected = true;

    private List<String> downloadMap = new ArrayList<>();

    private static class UpdateUtilsHolder {

        static final UpdateUtils INSTANCE = new UpdateUtils();

    }

    private UpdateUtils() {

    }

    public static UpdateUtils getInstance() {

        return UpdateUtilsHolder.INSTANCE;
    }

    /**
     * 下载Apk文件
     *
     * @param fileUrl     网络地址
     * @param apkSavePath 保存地址
     * @param apkSaveName 保存名称
     * @param listener    下载回调接口
     */
    public void downloadFile(String fileUrl, String apkSavePath,
                             String apkSaveName, OnDownloadListener listener) {
        if (downloadMap.contains(fileUrl)) {
            return;
        }

        this.apkUrl = fileUrl;
        this.apkSavePath = apkSavePath;
        this.apkSaveName = apkSaveName;
        this.mOnDownloadListener = listener;
        isIncrementalUpdates = false;

        downloadMap.add(fileUrl);

        Thread downThread = new Thread(new DownloadThread(fileUrl, apkSavePath,
                apkSaveName));
        downThread.start();

    }

    /**
     * 文件下载进程
     */
    private class DownloadThread implements Runnable {

        private String mUrl;
        private String savePath;
        private String saveName;
        private Message msg;

        public DownloadThread(String url, String path, String name) {
            this.mUrl = url;
            this.savePath = path;
            this.saveName = name;
        }

        @Override
        public void run() {
            try {
                msg = new Message();
                msg.what = DOWN_START;
                mHandler.sendMessage(msg);

                URL url = new URL(mUrl);

                HttpURLConnection conn = (HttpURLConnection) url.openConnection();
                conn.connect();
                int length = conn.getContentLength();
                InputStream is = conn.getInputStream();

                File file = new File(savePath);
                if (!file.exists()) {
                    file.mkdirs();
                }
                String downloadFile = savePath
                        + "/"
                        + (isIncrementalUpdates ? getNameFromUrl(mUrl)
                        : saveName);
                File DownloadFile = new File(downloadFile);
                FileOutputStream fos = new FileOutputStream(DownloadFile);

                int count = 0;
                int numread = 0;
                int progress = 0;

                byte buf[] = new byte[1024];

                long startTime = System.currentTimeMillis();
                long updateTime = 0;

                do {

                    numread = is.read(buf);
                    count += numread;
                    progress = (int) (((float) count / length) * 100);

                    long time = System.currentTimeMillis();

                    if (progress == 100) {

                        Bundle mBundle = new Bundle();
                        mBundle.putInt("PROGRESS", progress);
                        mBundle.putString("SPEED", "0");
                        mBundle.putString("TIMELEFT", "0");

                        // 更新进度
                        msg = new Message();
                        msg.what = DOWN_LOADING;
                        msg.setData(mBundle);
                        mHandler.sendMessage(msg);
                    } else if (time - updateTime >= 1000) {
                        long delTime = time - startTime;
                        updateTime = time;
                        // 单位：kb/s
                        double speed = delTime / 1000.0 == 0 ? 0
                                : (count / 1024.0) / (delTime / 1000.0);
                        // 单位：s
                        double timeLeft = speed == 0 ? 0 : (length - count)
                                / 1024 / speed;

                        Bundle mBundle = new Bundle();
                        mBundle.putInt("PROGRESS", progress);
                        mBundle.putString("SPEED", (int) speed + "");
                        mBundle.putString("TIMELEFT", (int) timeLeft + "");

                        // 更新进度
                        msg = new Message();
                        msg.what = DOWN_LOADING;
                        msg.setData(mBundle);
                        mHandler.sendMessage(msg);
                    }

                    fos.write(buf, 0, numread);
                } while (progress != 100 && isNetConnected);// 点击取消就停止下载.

                fos.close();
                is.close();

                // 文件下载完毕后，返回apk的地址
                msg = new Message();
                msg.what = DOWN_SUCCESS;
                msg.obj = downloadFile;
                msg.arg1 = progress = 100;
                mHandler.sendMessage(msg);
                downloadMap.remove(mUrl);
            } catch (Exception e) {
                e.printStackTrace();
                downloadMap.remove(mUrl);
                msg.what = DOWN_ERROR;
                msg.obj = e;
                mHandler.sendMessage(msg);

            }
        }

    }

    /**
     * 事件处理
     */
    @SuppressLint("HandlerLeak")
    Handler mHandler = new Handler() {

        @Override
        public void handleMessage(Message msg) {

            if (mOnDownloadListener == null) {
                Log.w(TAG, "mOnDownloadListener is null !");
                return;
            }

            switch (msg.what) {
                case DOWN_START:
                    mOnDownloadListener.onStart();
                    break;
                case DOWN_LOADING:

                    Bundle mBundle = msg.getData();
                    if (mBundle != null) {
                        mOnDownloadListener.onLoading(mBundle.getInt("PROGRESS"),
                                mBundle.getString("SPEED"),
                                mBundle.getString("TIMELEFT"));
                    }
                    break;
                case DOWN_ERROR:
                    mOnDownloadListener.onError((Exception) msg.obj);
                    break;
                case DOWN_SUCCESS:
                    mOnDownloadListener.onSuccess((String) msg.obj);
                    break;

                default:
                    break;
            }
        }

    };

	/*---------------------------Interface--------------------------------*/

    /**
     * 下载回调接口
     */
    public interface OnDownloadListener {
        /**
         * 开始下载
         */
        void onStart();

        /**
         * 下载中
         *
         * @param progress 下载进度
         */
        void onLoading(int progress, String speed, String timeLeft);

        /**
         * 下载失败
         *
         * @param error 错误信息
         */
        void onError(Exception error);

        /**
         * 安装包下载成功
         *
         * @param filePath 安装包本地路径
         */
        void onSuccess(String filePath);
    }

	/*---------------------------Tools--------------------------------*/

    /**
     * 从url上面获取文件名
     *
     * @param url
     * @return
     */
    private String getNameFromUrl(String url) {

        if (!TextUtils.isEmpty(url)) {
            String name = url.substring(url.lastIndexOf("/") + 1);
            return name;
        }

        return "temp_patch.apk";
    }

    /*---------------------------Get Set--------------------------------*/
    public String getApkSavePath() {
        return apkSavePath;
    }

    public void setApkSavePath(String apkSavePath) {
        this.apkSavePath = apkSavePath;
    }

    public String getApkSaveName() {
        return apkSaveName;
    }

    public void setApkSaveName(String apkSaveName) {
        this.apkSaveName = apkSaveName;
    }

    public String getMd5() {
        return md5;
    }

    public void setMd5(String md5) {
        this.md5 = md5;
    }

    public OnDownloadListener getOnDownloadListener() {
        return mOnDownloadListener;
    }

    public void setOnDownloadListener(OnDownloadListener onDownloadListener) {
        this.mOnDownloadListener = onDownloadListener;
    }

    public boolean isIncrementalUpdates() {
        return isIncrementalUpdates;
    }

    public void setIncrementalUpdates(boolean isIncrementalUpdates) {
        this.isIncrementalUpdates = isIncrementalUpdates;
    }

    public String getApkUrl() {
        return apkUrl;
    }

    public void setApkUrl(String apkUrl) {
        this.apkUrl = apkUrl;
    }

    public boolean isNetConnected() {
        return isNetConnected;
    }

    public void setNetConnected(boolean isNetConnected) {
        this.isNetConnected = isNetConnected;
    }
}
