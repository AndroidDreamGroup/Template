package ${utilsPackage};

import android.content.Context;
import android.text.TextUtils;
import android.widget.Toast;

/**
 */
public class Tip {

    public static void toast(Context ctx, String msg) {
        if (ctx == null || TextUtils.isEmpty(msg)) {
            return;
        }
        Toast.makeText(ctx, msg, Toast.LENGTH_SHORT).show();
    }
}
