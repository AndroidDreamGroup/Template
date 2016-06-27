package com.example.plugin.presenter;

import com.example.plugin.contract.IBaseContract;

import rx.Subscriber;

/**
 */
public abstract class BasePresenter implements IBaseContract.IBasePresenter {
    @Override
    public void unSub(Subscriber subscriber) {
        if (subscriber != null && subscriber.isUnsubscribed()) {
            subscriber.unsubscribe();
        }
    }

}
