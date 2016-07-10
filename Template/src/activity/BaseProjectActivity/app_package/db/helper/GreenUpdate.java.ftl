package ${dbPackage}.helper;

import android.database.sqlite.SQLiteDatabase;

/**
 * 数据库版本升级管理
 */
public class GreenUpdate {

    public static void update(SQLiteDatabase db, int oldVersion, int newVersion) {

        for (int i = oldVersion; i < newVersion; i++) {
            switch (i) {
                case 1:
                    // TODO: 数据库版本升级代码
                    update1To2(db);
                    break;
                default:
                    break;
            }
        }

    }

    private static void update1To2(SQLiteDatabase db) {
    }

}
