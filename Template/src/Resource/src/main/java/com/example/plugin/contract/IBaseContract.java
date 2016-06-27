package com.example.plugin.contract;


import rx.Subscriber;

public interface IBaseContract {

    interface IBaseView {
    }

    interface IBasePresenter {
        void unSub(Subscriber subscriber);

        void destroy();
    }

}
