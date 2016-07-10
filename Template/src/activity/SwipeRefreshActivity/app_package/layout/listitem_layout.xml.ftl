<?xml version="1.0" encoding="utf-8"?>

<layout>

        <data class=".${activityClass}AdapterBinding">

                 <variable
                     name="entity"
                     type="${packageName}.entity.${beanClass}" />

                 <variable
                     name="click"
                     type="android.view.View.OnClickListener" />

        </data>

        <RelativeLayout
            xmlns:android="http://schemas.android.com/apk/res/android"
            android:layout_width="match_parent"
            android:layout_height="match_parent"
            android:onClick="@{click.onClick}" >

        </RelativeLayout>

</layout>
