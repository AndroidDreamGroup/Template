package ${packageName}.view;

import ${superClassFqcn};
import android.os.Bundle;
import android.content.Context;
import android.content.Intent;
import android.view.View;

import ${packageName}.contract.${contractClass};
import ${packageName}.presenter.${presenterClass};
import ${packageName}.adapter.${adapterClass};
import ${packageName}.entity.${beanClass};
import ${packageName}.extend.LoadMoreSwipeRefreshLayout;

import java.util.List;

import butterknife.Bind;
import butterknife.ButterKnife;

public class ${activityClass} extends ${superClass} implements ${contractClass}.View, ${adapterClass}.OnItemClickListener {

    @Bind(R.id.refresh_layout)
    LoadMoreSwipeRefreshLayout refreshLayout;

    private ${contractClass}.Presenter presenter;

    private ${adapterClass} adapter;

    private int index = 1, size = 10;

    public static Intent getIntent(Context ctx){
        Intent intent = new Intent(ctx, ${activityClass}.class);
        intent.addFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP);
        return intent;
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        // TODO: 修改布局文件中SwipeRefreshLayout的包名
        setContentView(R.layout.${layoutName});
        ButterKnife.bind(this);

        initView();
        initData();

    }

    private void initView(){
        adapter = new ${adapterClass}(${activityClass}.this, null);
        adapter.setOnItemClickListener(this);

        refreshLayout.setAdapter(adapter);
        refreshLayout.setCanLoadMore(false);
        refreshLayout.setOnSwipeListener(new LoadMoreSwipeRefreshLayout.OnSwipeListener() {
            @Override
            public void onRefresh() {
                index = 1;
                // TODO: onRefresh
                // presenter.onRefresh(index, size);
            }

            @Override
            public void onLoadMore() {
                // TODO: onLoadMore
                // presenter.onLoadMore(index, size);
            }
        });
    }

    private void initData(){
        presenter = new ${presenterClass}(this);
        refreshLayout.reload();
    }

    @Override
    public void onItemClick(View view, ${beanClass} entity) {

    }

    private void onGetDataComplete(boolean success, List<${beanClass}> items){
        if (success) {

            if (items.size() < size) {
                refreshLayout.setCanLoadMore(false);
            } else {
                index++;
                refreshLayout.setCanLoadMore(true);
            }

            if (refreshLayout.isRefreshing()) {
                adapter.updateSource(items);
            } else {
                adapter.addData(items);
            }

        }
        refreshLayout.onRefreshComplete();
        refreshLayout.onLoadComplete();
      }


    @Override
    protected void onDestroy() {
        presenter.destroy();
        super.onDestroy();
    }

}
