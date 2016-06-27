package com.example.plugin.extend;

import android.content.Context;
import android.support.annotation.Nullable;
import android.support.v7.widget.RecyclerView;
import android.util.AttributeSet;
import android.view.MotionEvent;
import android.view.ViewConfiguration;


/**
 * 判断当前recyclerview的滑动事件，判断需不需要让划出来的按钮回去
 */
public class TouchableRecyclerView extends RecyclerView {

    private Context mContext;
    int Slop;

    private OnCloseAllOpenedItem closeAllOpenedItem;

    public TouchableRecyclerView(Context context) {
        this(context, null);
    }

    public TouchableRecyclerView(Context context, @Nullable AttributeSet attrs) {
        this(context, attrs, 0);
    }

    public TouchableRecyclerView(Context context, @Nullable AttributeSet attrs, int defStyle) {
        super(context, attrs, defStyle);
        initEvent(context);
    }

    private void initEvent(Context context) {
        mContext = context;
        Slop = ViewConfiguration.get(mContext).getScaledEdgeSlop();
    }


    /**
     * 判断 当前手势触摸的距离是否为拖动的最小距离
     *
     * @param e
     * @return
     */
    @Override
    public boolean onTouchEvent(MotionEvent e) {

        int dx = 0;
        int dy = 0;

        switch (e.getAction()) {
            case MotionEvent.ACTION_DOWN:
                dx = (int) e.getX();
                dy = (int) e.getY();
                break;
            case MotionEvent.ACTION_MOVE:
                int tempX = (int) e.getX();
                int tempY = (int) e.getY();
                if (Math.abs(dx - tempX) > Slop && Math.abs(tempY - dy) > Slop) {
                    if (closeAllOpenedItem != null) {
                        closeAllOpenedItem.closeAllOpenedItem();
                    }
                }
                break;

        }


        return super.onTouchEvent(e);

    }

    public void setOnCloseAllOpenedItem(OnCloseAllOpenedItem closeAllOpenedItem) {
        this.closeAllOpenedItem = closeAllOpenedItem;
    }

    public interface OnCloseAllOpenedItem {
        void closeAllOpenedItem();
    }

}
