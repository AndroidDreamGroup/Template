package ${utilsPackage};

import android.content.Context;
import android.graphics.Bitmap;
import android.net.Uri;
import android.text.TextUtils;

import com.facebook.binaryresource.BinaryResource;
import com.facebook.binaryresource.FileBinaryResource;
import com.facebook.cache.common.CacheKey;
import com.facebook.cache.disk.DiskCacheConfig;
import com.facebook.drawee.backends.pipeline.Fresco;
import com.facebook.drawee.generic.GenericDraweeHierarchy;
import com.facebook.drawee.view.SimpleDraweeView;
import com.facebook.imagepipeline.cache.DefaultCacheKeyFactory;
import com.facebook.imagepipeline.core.ImagePipelineConfig;
import com.facebook.imagepipeline.core.ImagePipelineFactory;
import com.facebook.imagepipeline.request.ImageRequest;
import ${appPackage}.Constant;

import java.io.File;
import java.io.FileOutputStream;

/**
 * Fresco Utils
 */
public class ImageUtils {

    public static void init(Context ctx) {

        File cache = new File(Constant.AppImageCache);
        if (!cache.exists()) {
            cache.mkdirs();
        }

        DiskCacheConfig diskCacheConfig = DiskCacheConfig.newBuilder(ctx)
                .setMaxCacheSize(1)
                .setBaseDirectoryPath(cache)
                .build();

        ImagePipelineConfig config = ImagePipelineConfig.newBuilder(ctx)
                .setBitmapsConfig(Bitmap.Config.ARGB_8888)
                .setMainDiskCacheConfig(diskCacheConfig)
                .build();

        Fresco.initialize(ctx, config);
    }

    public static void setImageUrl(SimpleDraweeView imageView, String url) {
        if (imageView == null || TextUtils.isEmpty(url)) {
            return;
        }
        Uri uri = Uri.parse(url);
        setImageUri(imageView, uri);
    }

    public static void setImageUri(SimpleDraweeView imageView, Uri uri) {
        if (imageView == null || uri == null) {
            return;
        }
        imageView.setImageURI(uri);
    }

    public static void setImageResource(SimpleDraweeView imageView, int resId) {
        if (imageView == null) {
            return;
        }

        GenericDraweeHierarchy hierarchy = imageView.getHierarchy();
        hierarchy.setPlaceholderImage(resId);
        imageView.setHierarchy(hierarchy);

    }

    public static Uri saveBitmapToLocal(Bitmap bm, String local) {

        File img = new File(local);
        if (!img.getParentFile().exists()) {
            boolean success = img.getParentFile().mkdirs();
        }
        try {
            FileOutputStream fos = new FileOutputStream(img);
            bm.compress(Bitmap.CompressFormat.PNG, 90, fos);
            fos.flush();
            fos.close();
            return Uri.fromFile(img);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public static File getCacheByUrl(String imageUrl) {
        ImageRequest imageRequest = ImageRequest.fromUri(imageUrl);
        CacheKey cacheKey = DefaultCacheKeyFactory.getInstance()
                .getEncodedCacheKey(imageRequest);
        BinaryResource resource = ImagePipelineFactory.getInstance()
                .getMainDiskStorageCache().getResource(cacheKey);
        if (resource == null) {
            return null;
        }
        File file = ((FileBinaryResource) resource).getFile();

        return file;
    }

}
