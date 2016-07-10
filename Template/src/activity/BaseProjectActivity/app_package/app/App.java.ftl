package ${appPackage};

import android.app.Application;

<#if hasGreenDao>
import ${dbPackage}.helper.AppDbHelper;
</#if>
import ${utilsPackage}.ImageUtils;


public class App extends Application {

    public static App instance;

    @Override
    public void onCreate() {
        super.onCreate();
        instance = this;
        ImageUtils.init(this);
<#if hasGreenDao>
        AppDbHelper.getInstance().init(this);
</#if>
    }
}
