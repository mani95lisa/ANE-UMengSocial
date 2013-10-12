package com.pamakids.umsocial.activities;
import android.app.Activity;
import android.os.Bundle;
import android.view.View;

import com.umeng.socialize.controller.RequestType;
import com.umeng.socialize.controller.UMServiceFactory;
import com.umeng.socialize.controller.UMSocialService;
import com.umeng.socialize.media.UMImage;


public class ShareActivity extends Activity {

	@Override
	protected void onCreate(Bundle savedInstanceState){
		super.onCreate(savedInstanceState);


        String id= this.getIntent().getStringExtra("id");
        String text = this.getIntent().getStringExtra("shareText");
        String image = this.getIntent().getStringExtra("imageUrl");
        String title = this.getIntent().getStringExtra("title");

        /**
         * @param descriptor UMSocialService的标识，你可能在一个Acitvity中使用多个UMSocialService用于区分各个子版块。
         * 如果只使用一个，建议使用相关Acitvity的classname作为参数。
         * @param type 申明UMSocialService的权限，目前有两种权限（SOCIAL，ANALYTICS），
         * 相应的权限下某些API与做限制。本文当所涉及的都是SOCIAL权限
         * @return
         */
        UMSocialService controller = UMServiceFactory.getUMSocialService(id, RequestType.SOCIAL);


        //设置默认分享文字
        controller.setShareContent(text);

        //设置默认分享图片
        if(image!=null)
        {
            UMImage shareImage = new UMImage(ShareActivity.this, image);
            controller.setShareMedia(shareImage);
        }
//				/**
//				 * @param context
//				 * @param forceLogin 是否只有已登录用户才能打开分享选择页
//				 * /
        controller.openShare(ShareActivity.this,false);

//		setContentView(R.layout.testgroup);
		
//		View view = this.findViewById(R.id.button1);
//		view.setOnClickListener(new View.OnClickListener() {
//			@Override
//			public void onClick(View v) {
//				UMServiceFactory.shareTo(MainActivity.this, "test", null);
//			}
//		});
	}
	
}
