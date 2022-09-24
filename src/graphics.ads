with SDL.Video.Textures;

package Graphics is
  function Init return boolean;
  procedure Quit;

  type Sprite is tagged limited private;
  type Sprite_Order is array (Positive range <>) of Sprite;
  type Sprite_Order_Access is access Sprite_Order;
  
  procedure Set_Items_To_Render (r : Sprite_Order_Access);-- <- will probably need this to be an access type instead
  procedure Render_Pass;
  procedure CreateTextSprite (text : String; ret : in out Sprite);-- return Sprite;

private
  type Sprite is new SDL.Video.Textures.Texture with record
    null;
  end record;
end Graphics;
