package
{
	import flash.events.EventDispatcher;
	import flash.external.ExtensionContext;


	/**
	 *  使用时必须加入如下权限，APP_KEY在配置文件里写好
	 *  时间都是毫秒
	 *
	 *  <application ……>
			……
		<activity ……/>
		<meta-data android:value="YOUR_APP_KEY" android:name="UMENG_APPKEY"></meta-data>
		<meta-data android:value="Channel ID" android:name="UMENG_CHANNEL"/>
		</application>
	 *  <uses-permission android:name="android.permission.ACCESS_NETWORK_STATE"></uses-permission>
		<uses-permission android:name="android.permission.INTERNET"></uses-permission>
		<uses-permission android:name="android.permission.READ_PHONE_STATE"></uses-permission>
		<uses-permission android:name="android.permission.READ_LOGS"></uses-permission>
	 *
	 * @author mani
	 *
	 */
	public class UMSocial extends EventDispatcher
	{
		private static var _instance:UMSocial;

		public static function get instance():UMSocial
		{
			if (!_instance)
			{
				_instance=new UMSocial();
			}
			return _instance;
		}

		public function init(appkey:String="", weixinID:String="", weixinURL:String=""):void
		{
		}

		public static var sharedOK:Function;

		/**
		 * 控制分享条是否显示
		 * @param visible
		 */
		public function status(visible:Boolean):void
		{
		}

		public function dataID(id:String, shareText:String='', imageUrl:String='', title:String=''):void
		{
		}

		public function share(id:String, shareText:String='', imageUrl:String='', title:String='', type:String='sina'):void
		{
		}

		/**
		 * 第三方平台登录
		 * @param platform 平台名称，目前只支持：sina,tencent,qzone,renren,douban
		 * @callback 返回登录结果
		 */
		public function login(platform:String, callback:Function):void
		{
		}

		public function cancelLogin(platform:String, callback:Function):void
		{
		}

	}
}

