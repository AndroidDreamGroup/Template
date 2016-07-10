package ${dbPackage}.helper;

import android.content.Context;
import android.database.sqlite.SQLiteDatabase;

import ${dbPackage}.dao.DaoMaster;
import ${dbPackage}.dao.DaoSession;

public class AppDbHelper {

    protected final static String APP_DB_NAME = "${greenDaoName}";
    private Context appContext;
    private DaoSession daoSession;

    private AppDbHelper() {

    }

    private static class SingletonHolder {
        private static final AppDbHelper INSTANCE = new AppDbHelper();
    }

    //获取单例
    public static AppDbHelper getInstance() {
        return SingletonHolder.INSTANCE;
    }

    public void init(Context context) {
        this.appContext = context;
    }

    public DaoSession getAppDaoSession() {
        if (daoSession == null) {
            createDaoSession();
        }
        return daoSession;
    }

    private void createDaoSession() {
        if (appContext == null) {
            throw new NullPointerException("GreenDao.appContext == null , call init(Context) first .");
        }

        DaoMaster.DevOpenHelper openHelper = new DaoMaster.DevOpenHelper(appContext, APP_DB_NAME, null) {
            @Override
            public void onUpgrade(SQLiteDatabase db, int oldVersion, int newVersion) {
                GreenUpdate.update(db, oldVersion, newVersion);
            }
        };
        SQLiteDatabase db = openHelper.getWritableDatabase();
        daoSession = new DaoMaster(db).newSession();

    }

}
