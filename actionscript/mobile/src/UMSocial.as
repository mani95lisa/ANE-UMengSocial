package
{
	import flash.events.EventDispatcher;
	import flash.events.StatusEvent;
	import flash.external.ExtensionContext;


	/**
	 *  时间都是毫秒
	 * @author mani
	 */
	public class UMSocial extends EventDispatcher
	{
		private static var _instance:UMSocial;
		private static var extensionContext:ExtensionContext;
		private static const EXTENSION_ID:String="com.pamakids.UMSocial";

//		UMSResponseCodeSuccess            = 200,        //成功
//			UMSResponseCodeBaned              = 505,        //用户被封禁
//			UMSResponseCodeShareRepeated      = 5016,       //分享内容重复
//			UMSResponseCodeGetNoUidFromOauth  = 5020,       //授权之后没有得到用户uid
//			UMSResponseCodeAccessTokenExpired = 5027,       //token过期
//			UMSResponseCodeNetworkError       = 5050,       //网络错误
//			UMSResponseCodeGetProfileFailed   = 5051,       //获取账户失败
//			UMSResponseCodeCancel             = 5052        //用户取消授权

		public static function get instance():UMSocial
		{
			if (!_instance)
			{
				_instance=new UMSocial();
				extensionContext=ExtensionContext.createExtensionContext(EXTENSION_ID, null);
				if (!extensionContext)
					trace("ERROR - Extension context is null. Please check if extension.xml is setup correctly.");
				else
					extensionContext.addEventListener(StatusEvent.STATUS, onStatus);
			}
			return _instance;
		}

		public static var sharedOK:Function;

		protected static function onStatus(event:StatusEvent):void
		{
			if (sharedOK != null)
			{
				if (event.code == 'shared' && event.level == '200')
					sharedOK();
			}
			trace(event.code, event.level);
		}

		public function init(appkey:String="", useSocialBar:Boolean=true):void
		{
			if (extensionContext)
				extensionContext.call('init', appkey, useSocialBar ? 1 : 0);
		}

		/**
		 * 控制分享条是否显示，因为分享条初始化的时候可能有卡顿，所以初始化的时候是看不见的
		 * @param visible
		 */
		public function status(visible:Boolean):void
		{
			if (extensionContext)
				extensionContext.call('status', visible ? 1 : 0);
		}

		/**
		 * 设置bar的属性
		 * @param id 数据ID
		 * @param shareText 分享文本
		 * @param imageUrl 分享图片地址
		 * @param title 分享邮件时使用的标题
		 */
		public function dataID(id:String, shareText:String='', imageUrl:String='', title:String=''):void
		{
			if (extensionContext)
				extensionContext.call('dataID', id, shareText, imageUrl, title);
		}

		/**
		 * 弹出分享列表分享选择
		 * @param id 数据ID
		 * @param shareText 分享文本
		 * @param imageUrl 分享图片地址
		 * @param title 分享邮件时使用的标题
		 * @param type 分享的平台类型，默认新浪微博，目前只支持： sina, tencent, qzone, email
		 */
		public function share(id:String, shareText:String='', imageUrl:String='', title:String='', type:String='sina'):void
		{
			if (extensionContext)
				extensionContext.call('share', id, shareText, imageUrl, title, type);
		}
	}
}

