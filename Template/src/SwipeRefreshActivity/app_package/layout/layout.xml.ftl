<?xml version="1.0" encoding="utf-8"?>
<layout>

        <data class=".${activityClass}Binding" />

        <RelativeLayout
            xmlns:android="http://schemas.android.com/apk/res/android"
            android:layout_width="match_parent"
            android:layout_height="match_parent">

            <${packageName}.extend.LoadMoreSwipeRefreshLayout
                android:id="@+id/refresh_layout"
                android:layout_width="match_parent"
                android:layout_height="match_parent" />

        </RelativeLayout>

</layout>
