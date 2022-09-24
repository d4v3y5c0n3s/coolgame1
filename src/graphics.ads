--Copyright 2022 Troy Jacobs
--  This file is part of Coolgame1.
--  Coolgame1 is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.
--  Coolgame1 is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
--  You should have received a copy of the GNU General Public License along with Coolgame1. If not, see <https://www.gnu.org/licenses/>.

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
