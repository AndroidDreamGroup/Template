package com.example.plugin.extend;

import android.content.Context;
import android.support.v4.widget.SwipeRefreshLayout;
import android.support.v7.widget.DefaultItemAnimator;
import android.support.v7.widget.LinearLayoutManager;
import android.support.v7.widget.RecyclerView;
import android.util.AttributeSet;
import android.view.LayoutInflater;
import android.view.View;
import android.widget.ImageView;
import android.widget.RelativeLayout;
import android.widget.TextView;

import com.example.plugin.R;


/**
 * 下啦刷新，加载更多
 */
public class LoadMoreSwipeRefreshLayout extends SwipeRefreshLayout {

    // RecyclerView
    private TouchableRecyclerView recyclerView;

    // Empty View
    private RelativeLayout rlEmpty;
    private TextView tvEmpty;
    private ImageView ivEmpty;

    // empty desc
    private String emptyDesc = getResources().getString(R.string.extend_refresh_def_empty);
    private int emptyImage = R.mipmap.no_data_common;

    private OnSwipeListener onSwipeListener;

    // refresh
    private boolean canRefresh = true;
    private boolean isRefreshing = false;

    // load more
    private final static int PRELOAD_SIZE = 1;
    private boolean canLoadMore = true;
    private boolean isLoading = false;

    public LoadMoreSwipeRefreshLayout(Context context) {
        super(context);
    }

    public LoadMoreSwipeRefreshLayout(Context context, AttributeSet attrs) {
        super(context, attrs);
        initView();
    }

    private void initView() {

        View view = LayoutInflater.from(getContext()).inflate(R.layout.extend_refresh_layout, null);
        recyclerView = (TouchableRecyclerView) view.findViewById(R.id.refresh_rv_list);
        rlEmpty = (RelativeLayout) view.findViewById(R.id.refresh_rl_container);
        ivEmpty = (ImageView) view.findViewById(R.id.refresh_iv_empty);
        tvEmpty = (TextView) view.findViewById(R.id.refresh_tv_empty);

        LinearLayoutManager linearLayoutManager = new LinearLayoutManager(getContext(), LinearLayoutManager.VERTICAL, false);
        recyclerView.setLayoutManager(linearLayoutManager);
        recyclerView.setItemAnimator(new DefaultItemAnimator());
        setOnRefreshListener(getOnRefreshListener());
        recyclerView.addOnScrollListener(getOnBottomListener(linearLayoutManager));

        addView(view);

    }

    public void setAdapter(RecyclerView.Adapter adapter) {
        recyclerView.setAdapter(adapter);
    }

    private OnRefreshListener getOnRefreshListener() {
        return new OnRefreshListener() {
            @Override
            public void onRefresh() {
                if (!canRefresh) {
                    onRefreshComplete();
                    return;
                }

                if (isRefreshing || isLoading) {
                    return;
                }

                if (onSwipeListener != null) {
                    setRefreshing(true);
                    isRefreshing = true;
                    onSwipeListener.onRefresh();
                }

            }
        };
    }

    private RecyclerView.OnScrollListener getOnBottomListener(final LinearLayoutManager layoutManager) {
        return new RecyclerView.OnScrollListener() {
            @Override
            public void onScrolled(RecyclerView rv, int dx, int dy) {

                if (!canLoadMore) {
                    onLoadComplete();
                    return;
                }

                boolean isBottom = layoutManager.findLastCompletelyVisibleItemPosition() >= recyclerView.getAdapter().getItemCount() - PRELOAD_SIZE;

                if (!isBottom) {
                    return;
                }

                if (isRefreshing || isLoading) {
                    return;
                }

                if (onSwipeListener != null) {
                    isLoading = true;
                    setRefreshing(true);
                    onSwipeListener.onLoadMore();
                }

            }
        };
    }

    public void onRefreshComplete() {
        setRefreshing(false);
        isRefreshing = false;
        checkEmpty();
    }

    public void onLoadComplete() {
        setRefreshing(false);
        isLoading = false;
        checkEmpty();
    }

    private void checkEmpty() {

        boolean isEmpty = recyclerView.getAdapter() == null || recyclerView.getAdapter().getItemCount() == 0;

        rlEmpty.setVisibility(isEmpty ? VISIBLE : GONE);
        tvEmpty.setText(emptyDesc);
        ivEmpty.setImageResource(emptyImage);
    }

    public void setOnSwipeListener(OnSwipeListener onSwipeListener) {
        this.onSwipeListener = onSwipeListener;
    }

    public void reload() {
        if (!canRefresh) {
            onRefreshComplete();
            return;
        }

        if (isRefreshing || isLoading) {
            return;
        }

        if (onSwipeListener != null) {
            setRefreshing(true);
            isRefreshing = true;
            onSwipeListener.onRefresh();
        }
    }

    // interface
    public interface OnSwipeListener {
        void onRefresh();

        void onLoadMore();
    }

    @Override
    public boolean isRefreshing() {
        return isRefreshing;
    }

    public boolean isLoading() {
        return isLoading;
    }

    public void setCanRefresh(boolean canRefresh) {
        this.canRefresh = canRefresh;
    }

    public void setCanLoadMore(boolean canLoadMore) {
        this.canLoadMore = canLoadMore;
    }

    public void setEmptyDesc(String emptyDesc) {
        this.emptyDesc = emptyDesc;
        checkEmpty();
    }

    public void setEmptyImage(int emptyRes) {
        this.emptyImage = emptyRes;
        checkEmpty();
    }

    public RecyclerView getRecyclerView() {
        return recyclerView;
    }
}
