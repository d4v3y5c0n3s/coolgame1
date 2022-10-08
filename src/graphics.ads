--Copyright 2022 Troy Jacobs
--  This file is part of Coolgame1.
--  Coolgame1 is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.
--  Coolgame1 is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
--  You should have received a copy of the GNU General Public License along with Coolgame1. If not, see <https://www.gnu.org/licenses/>.

with SDL.Video.Textures;
with SDL.Video.Rectangles;

package Graphics is
  function Init return boolean;
  procedure Quit;

  type Sprite is limited private;
  type Sprite_Access is access Sprite;
  type Sprite_Order is array (Positive range <>) of Sprite_Access;
  type Sprite_Order_Access is access Sprite_Order;
  
  procedure Set_Items_To_Render (r : Sprite_Order_Access);
  procedure Render_Pass;
  procedure CreateSpriteFromFile(filename : String; ret : Sprite_Access);
  procedure CreateTextSprite (text : String; ret : Sprite_Access);

private
  type Sprite is record
    tex : SDL.Video.Textures.Texture;
    from_rect : SDL.Video.Rectangles.Rectangle;
    to_rect : SDL.Video.Rectangles.Rectangle;
  end record;
end Graphics;
