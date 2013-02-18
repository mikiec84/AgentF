package de.mediadesign.gd1011.studiof.services
{
    import flash.display.Bitmap;
	import flash.display.BitmapData;
    import flash.geom.Rectangle;
    import flash.media.Sound;
    import flash.utils.ByteArray;
    import flash.utils.Dictionary;
	import flash.utils.getDefinitionByName;

    import starling.core.Starling;
    import starling.display.DisplayObject;

    import starling.display.Image;
    import starling.display.MovieClip;

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



        public static function createAtlasAnim(name:String,w:int,h:int,frames:int):TextureAtlas
        {
            var texture:Texture = getTexture(name);

            var atlas:TextureAtlas = new TextureAtlas (texture);
            var hNew:int = texture.height / h;
            var wNew:int = texture.width / w;

            for (var i:int = 0; i < frames; i++)
            {
                var x:int = i%w;
                var y:int = i/w;

                var nameNew:String = String(i);
                while ( nameNew.length < 3 )
                {
                    nameNew = "0" + nameNew;
                }
                atlas.addRegion(name+nameNew, new Rectangle(x*wNew,y*hNew, wNew, hNew));

            }
            return atlas;
        }

        private static function createMovieClip(assetName:String, v:Vector.<int>):DisplayObject
        {
            var newClip:MovieClip;
            var frames:Vector.<Texture> = createAtlasAnim(assetName,v[0],v[1],v[2]).getTextures(assetName);
            newClip = new MovieClip(frames, v[3]);
            newClip.play();
            Starling.juggler.add(newClip);
            return newClip;
        }


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