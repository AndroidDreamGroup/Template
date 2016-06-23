package ${packageName}.presenter;

import ${packageName}.contract.${contractClass};

public class ${presenterClass} extends BasePresenter implements ${contractClass}.Presenter{

    private ${contractClass}.View view;

    public ${presenterClass}(${contractClass}.View view) {
        this.view = view;
    }

    @Override
    public void destroy() {
        view = null;
    }

}
