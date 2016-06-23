package ${packageName}.adapter;

import android.content.Context;
import android.support.v7.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;

import java.util.ArrayList;
import java.util.List;

import ${packageName}.entity.${beanClass};

/**
 *
 */
public class ${adapterClass} extends RecyclerView.Adapter<${adapterClass}.ViewHolder>{

    private Context context;
    private List<${beanClass}> mDataSource;
    private LayoutInflater inflater;
    private OnItemClickListener mItemClickListener;

    public ${adapterClass}(Context ctx, List<${beanClass}> datas) {
        this.context = ctx;
        this.mDataSource = new ArrayList<>();
        this.inflater = LayoutInflater.from(context);

        if(datas != null){
            mDataSource.addAll(datas);
        }

    }

    @Override
    public ViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
        return new ViewHolder(inflater.inflate(R.layout.${listItemLayout}, parent, false));
    }

    @Override
    public void onBindViewHolder(ViewHolder holder, int position) {
        ${beanClass} entity = mDataSource.get(position);
        // TODO: 为holder中的控件赋值
    }

    @Override
    public int getItemCount() {
        return mDataSource.size();
    }

    public class ViewHolder extends RecyclerView.ViewHolder implements View.OnClickListener {

        public ViewHolder(View view) {
            super(view);
            // TODO: 添加控件，并初始化

            view.setOnClickListener(this);
        }

        @Override
        public void onClick(View v) {
            if (mItemClickListener != null) {
                mItemClickListener.onItemClick(v, mDataSource.get(getPosition()));
            }
        }

    }

    public interface OnItemClickListener {
        void onItemClick(View view, ${beanClass} entity);
    }

    public void setOnItemClickListener(OnItemClickListener onItemClickListener) {
        this.mItemClickListener = onItemClickListener;
    }

    public void updateSource(List<${beanClass}> data) {
        if(data == null){
            return;
        }

        mDataSource.clear();
        mDataSource.addAll(data);
        notifyDataSetChanged();
    }

    public void addData(List<${beanClass}> data){
        if(data == null){
            return;
        }

        mDataSource.addAll(data);
        notifyDataSetChanged();

    }

}


