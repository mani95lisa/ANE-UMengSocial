package com.pamakids.umsocial.activities;

import android.app.Activity;
import android.os.Bundle;
import android.view.ViewGroup;
import com.adobe.fre.FREContext;
import com.pamakids.umsocial.R;
import com.umeng.socialize.view.ActionBarView;
import android.view.ViewGroup.LayoutParams;

/**
 * Created with IntelliJ IDEA.
 * User: mani
 * Date: 13-8-6
 * Time: PM5:48
 * To change this template use File | Settings | File Templates.
 */
public class ActionBarActivity extends Activity {

    FREContext freContext;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.only_actionbar);

        ViewGroup parent = (ViewGroup) this.findViewById(R.id.parent);
        ActionBarView actionBarView = new ActionBarView(this);

        LayoutParams layoutParams = new ViewGroup.LayoutParams(LayoutParams.WRAP_CONTENT,
                LayoutParams.WRAP_CONTENT);
        actionBarView.setLayoutParams(layoutParams);
        //添加ActionBar
        parent.addView(actionBarView);
    }

}
