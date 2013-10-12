package
{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.utils.setTimeout;

	public class UMDemo extends Sprite
	{
		public function UMDemo()
		{
			super();

			stage.align=StageAlign.TOP_LEFT;
			stage.scaleMode=StageScaleMode.NO_SCALE;

			setTimeout(showShareBar, 1000);
		}

		private function showShareBar():void
		{
			UMSocial.instance.init('5209f8ad56240b8807020cde');
			UMSocial.instance.status(true);
		}
	}
}
