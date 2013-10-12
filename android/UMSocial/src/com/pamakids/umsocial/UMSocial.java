package com.pamakids.umsocial;

import android.util.Log;
import com.adobe.fre.FREContext;
import com.adobe.fre.FREExtension;

/**
 * Created with IntelliJ IDEA.
 * User: mani
 * Date: 13-8-5
 * Time: PM5:11
 * To change this template use File | Settings | File Templates.
 */
public class UMSocial implements FREExtension{

    public static final String TAG = "UMSocial";

    @Override
    public FREContext createContext(String contextType){
        return  new UMSocialContext();
    }

    @Override
    public void dispose() {
        Log.d(TAG, "Extension disposed.");
    }

    @Override
    public void initialize() {
        Log.d(TAG, "Extension initialized.");
    }

}
