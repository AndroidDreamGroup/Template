package ${packageName}.presenter;

import com.trello.rxlifecycle.components.support.RxFragment;
import ${packageName}.contract.${contractClass};

public class ${presenterClass} implements ${contractClass}.Presenter{

    private RxFragment context;
    private ${contractClass}.View view;

    public ${presenterClass}(RxFragment context, ${contractClass}.View view) {
        this.context = context;
        this.view = view;
    }

    @Override
    public void destroy() {
        view = null;
    }

}
