package ${packageName}.view;

import android.os.Bundle;
import android.support.annotation.Nullable;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import com.trello.rxlifecycle.components.support.RxFragment;

import ${packageName}.contract.${contractClass};
import ${packageName}.presenter.${presenterClass};

public class ${fragmentClass} extends RxFragment implements ${contractClass}.View {

    private ${fragmentClass}Binding binding;

    private ${contractClass}.Presenter presenter;

    public static ${fragmentClass} newInstance() {
        ${fragmentClass} fragment = new ${fragmentClass}();
        return fragment;
    }

     @Nullable
     @Override
     public View onCreateView(LayoutInflater inflater, @Nullable ViewGroup container, @Nullable Bundle savedInstanceState) {
         binding = DataBindingUtil.inflate(inflater, R.layout.${layoutName}, container, false);
         return binding.getRoot();
     }

     @Override
     public void onViewCreated(View view, @Nullable Bundle savedInstanceState) {
         super.onViewCreated(view, savedInstanceState);
         initView();
         initData();
     }

    private void initView(){

    }

    private void initData(){
        presenter = new ${presenterClass}(this, this);
    }

    @Override
    public void onDestroyView() {
        presenter.destroy();
        super.onDestroyView();
    }

}
