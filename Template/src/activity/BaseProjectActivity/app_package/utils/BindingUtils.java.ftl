package ${utilsPackage};

import android.databinding.BindingAdapter;

import com.facebook.drawee.view.SimpleDraweeView;

/**
 */
public class BindingUtils {

    @BindingAdapter({"image"})
    public static void imageLoader(SimpleDraweeView imageView, String url) {
        ImageUtils.setImageUrl(imageView, url);
    }

}
