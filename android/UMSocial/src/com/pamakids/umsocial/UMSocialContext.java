package com.pamakids.umsocial;

import android.content.Intent;
import android.util.Log;
import android.view.ViewGroup;
import com.adobe.fre.*;
import com.pamakids.umsocial.activities.ActionBarActivity;
import com.pamakids.umsocial.activities.ShareActivity;
import com.umeng.socialize.controller.RequestType;
import com.umeng.socialize.controller.UMServiceFactory;
import com.umeng.socialize.controller.UMSocialService;
import com.umeng.socialize.media.UMImage;
import com.umeng.socialize.view.ActionBarView;

import java.util.HashMap;
import java.util.Map;

/**
 * Created with IntelliJ IDEA.
 * User: mani
 * Date: 13-8-5
 * Time: PM5:12
 * To change this template use File | Settings | File Templates.
 */
public class UMSocialContext extends FREContext {

    public static final String TAG = "UMSocialContext";

    @Override
    public void dispose(){
        Log.d(TAG, "Context disposed.");
    }

    @Override
    public Map<String, FREFunction> getFunctions(){
        Map<String, FREFunction> functions = new HashMap<String, FREFunction>();
        functions.put(init.TAG, new init());
        functions.put(share.TAG, new share());
        functions.put(status.TAG, new status());
        functions.put(dataID.TAG, new dataID());
        return functions;
    }

    public class status implements FREFunction{

        public static final String TAG = "status";

        @Override
        public FREObject call(final FREContext context, FREObject[] args){
            return null;
        }
    }

    public class dataID implements FREFunction{

        public static final String TAG = "dataID";

        @Override
        public FREObject call(final FREContext context, FREObject[] args){
            return null;
        }
    }

    public class share implements FREFunction{

        public static final String TAG = "share";

        @Override
        public FREObject call(final FREContext context, FREObject[] args){
            Log.d(TAG, "UMSocial share called1");

            String id;
            String text;
            String image;
            String title;
            try {
                id = args[0].getAsString();
                text = args[1].getAsString();
                image = args[2].getAsString();

                UMSocialService controller = UMServiceFactory.getUMSocialService(id, RequestType.SOCIAL);
                controller.setShareContent(text);
                if(image!=null)
                {
                    UMImage shareImage = new UMImage(context.getActivity(), image);
                    controller.setShareMedia(shareImage);
                }
                controller.openShare(context.getActivity(),false);
            } catch (FRETypeMismatchException e) {
                e.printStackTrace();  //To change body of catch statement use File | Settings | File Templates.
            } catch (FREInvalidObjectException e) {
                e.printStackTrace();  //To change body of catch statement use File | Settings | File Templates.
            } catch (FREWrongThreadException e) {
                e.printStackTrace();  //To change body of catch statement use File | Settings | File Templates.
            }
//            context.getActivity().startActivity(intent);

            Log.d(TAG, "UMSocial share called2");
            return null;
        }
    }

    public class init implements FREFunction {

        public static final String TAG = "init";

        @Override
        public FREObject call(final FREContext context, FREObject[] args){

            Log.d(TAG, "UMSocial init called");

            return null;
        }

    }
}

