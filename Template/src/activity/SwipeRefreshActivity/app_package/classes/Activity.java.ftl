package ${packageName}.view;

import android.os.Bundle;
import android.content.Context;
import android.databinding.DataBindingUtil;
import android.content.Intent;
import android.view.View;

import com.trello.rxlifecycle.components.support.RxAppCompatActivity;
import ${packageName}.contract.${contractClass};
import ${packageName}.presenter.${presenterClass};
import ${packageName}.adapter.${adapterClass};
import ${packageName}.entity.${beanClass};
import ${packageName}.extend.LoadMoreSwipeRefreshLayout;

import java.util.List;

public class ${activityClass} extends RxAppCompatActivity implements ${contractClass}.View, ${adapterClass}.OnItemClickListener {

    private ${activityClass}Binding binding;

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
        binding = DataBindingUtil.setContentView(this, R.layout.${layoutName});

        initView();
        initData();

    }

    private void initView(){
        adapter = new ${adapterClass}(${activityClass}.this, null);
        adapter.setOnItemClickListener(this);

        binding.refreshLayout.setAdapter(adapter);
        binding.refreshLayout.setCanLoadMore(false);
        binding.refreshLayout.setOnSwipeListener(new LoadMoreSwipeRefreshLayout.OnSwipeListener() {
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
        presenter = new ${presenterClass}(this, this);
        binding.refreshLayout.reload();
    }

    @Override
    public void onItemClick(View view, ${beanClass} entity) {

    }

    private void onGetDataComplete(boolean success, List<${beanClass}> items){
        if (success) {

            if (items.size() < size) {
                binding.refreshLayout.setCanLoadMore(false);
            } else {
                index++;
                binding.refreshLayout.setCanLoadMore(true);
            }

            if (binding.refreshLayout.isRefreshing()) {
                adapter.updateSource(items);
            } else {
                adapter.addData(items);
            }

        }
        binding.refreshLayout.onRefreshComplete();
        binding.refreshLayout.onLoadComplete();
      }


    @Override
    protected void onDestroy() {
        presenter.destroy();
        super.onDestroy();
    }

}
