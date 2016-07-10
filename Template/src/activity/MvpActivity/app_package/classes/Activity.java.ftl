package ${packageName}.view;

import android.os.Bundle;
import android.content.Context;
import android.content.Intent;
import android.databinding.DataBindingUtil;

import com.trello.rxlifecycle.components.support.RxAppCompatActivity;
import ${packageName}.contract.${contractClass};
import ${packageName}.presenter.${presenterClass};

public class ${activityClass} extends RxAppCompatActivity implements ${contractClass}.View {

    private ${activityClass}Binding binding;

    private ${contractClass}.Presenter presenter;

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

    }

    private void initData(){
        presenter = new ${presenterClass}(this, this);
    }

    @Override
    protected void onDestroy() {
        presenter.destroy();
        super.onDestroy();
    }

}
