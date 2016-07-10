package ${packageName}.presenter;

import com.trello.rxlifecycle.components.support.RxAppCompatActivity;
import ${packageName}.contract.${contractClass};

public class ${presenterClass} implements ${contractClass}.Presenter{

    private RxAppCompatActivity context;
    private ${contractClass}.View view;

    public ${presenterClass}(RxAppCompatActivity context, ${contractClass}.View view) {
        this.context = context;
        this.view = view;
    }

    @Override
    public void destroy() {
        view = null;
    }

}
