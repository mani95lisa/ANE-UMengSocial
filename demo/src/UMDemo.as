package
{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.utils.setTimeout;

	/**
	 * 1. 初始化分享条
	 * 2. 设置分享条可见
	 * 3. 直接分享文字图片
	 * @author mani
	 */
	public class UMDemo extends Sprite
	{
		public function UMDemo()
		{
			super();

			stage.align=StageAlign.TOP_LEFT;
			stage.scaleMode=StageScaleMode.NO_SCALE;

			setTimeout(showShareBar, 1000);
			setTimeout(share, 2000);
		}

		private function showShareBar():void
		{
			UMSocial.instance.init('5209f8ad56240b8807020cde');
			UMSocial.instance.status(true);
		}

		private function share():void
		{
			UMSocial.instance.share('test', 'test', 'http://www.google.com/images/srpr/logo4w.png');
		}
	}
}
