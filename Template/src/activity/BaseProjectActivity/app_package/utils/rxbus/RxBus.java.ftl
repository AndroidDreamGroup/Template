package ${rxBusPackage};


import rx.Observable;
import rx.subjects.PublishSubject;
import rx.subjects.SerializedSubject;
import rx.subjects.Subject;

/**
 * RxBus
 */
public class RxBus {

    private static class SingletonHolder {
        private static final RxBus INSTANCE = new RxBus();
    }

    //获取单例
    public static RxBus getInstance() {
        return SingletonHolder.INSTANCE;
    }

    private final Subject bus;

    private RxBus() {
        bus = new SerializedSubject<>(PublishSubject.create());
    }

    // 发射一个事件
    public void post(Object o) {
        bus.onNext(o);
    }

    public <T> Observable<T> toObservable(final Class<T> eventType) {
        return bus.ofType(eventType);
    }

}
