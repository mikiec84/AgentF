package de.mediadesign.gd1011.studiof.services
{
    import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.media.Sound;
    import flash.utils.ByteArray;
    import flash.utils.Dictionary;
	import flash.utils.getDefinitionByName;

	import starling.display.Image;

	import starling.text.BitmapFont;
    import starling.text.TextField;
    import starling.textures.Texture;
    import starling.textures.TextureAtlas;

    public class Assets
    {
        private static var sTextures:Dictionary = new Dictionary();
        private static var sSounds:Dictionary = new Dictionary();
        private static var sTextureAtlas:TextureAtlas;
        private static var sBitmapFontsLoaded:Boolean;

		public static function getImage(name:String):Image
		{
			return new Image(getTexture(name));
		}

        public static function getTexture(name:String):Texture
        {
            if (sTextures[name] == undefined)
            {
                var data:Object = create(name);
                
                if (data is Bitmap)
                    sTextures[name] = Texture.fromBitmap(data as Bitmap, true, false);
				else if (data is BitmapData)
					sTextures[name] = Texture.fromBitmapData(data as BitmapData, true, false);
                else if (data is ByteArray)
                    sTextures[name] = Texture.fromAtfData(data as ByteArray);
            }
            
            return sTextures[name];
        }
        
        public static function getSound(name:String):Sound
        {
            var sound:Sound = sSounds[name] as Sound;
            if (sound) return sound;
            else throw new ArgumentError("Sound not found: " + name);
        }
        
        public static function getTextureAtlas():TextureAtlas
        {
            if (sTextureAtlas == null)
            {
                var texture:Texture = getTexture("AtlasTexture");
                var xml:XML = XML(create("AtlasXml"));
                sTextureAtlas = new TextureAtlas(texture, xml);
            }
            
            return sTextureAtlas;
        }
        
        public static function loadBitmapFonts():void
        {
            if (!sBitmapFontsLoaded)
            {
                var texture:Texture = getTexture("DesyrelTexture");
                var xml:XML = XML(create("DesyrelXml"));
                TextField.registerBitmapFont(new BitmapFont(texture, xml));
                sBitmapFontsLoaded = true;
            }
        }
        
        private static function create(name:String):Object
        {
			var textureClass:Class = Assets[name];
			if(textureClass != null)
			{
				var data:Object = new textureClass;
				return data;
			}
			var classDefinition:Class = getDefinitionByName(name) as Class;
			data = new classDefinition(0,0);
			return data;
        }
    }
}