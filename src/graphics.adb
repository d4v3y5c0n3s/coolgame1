--Copyright 2022 Troy Jacobs
--  This file is part of Coolgame1.
--  Coolgame1 is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.
--  Coolgame1 is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
--  You should have received a copy of the GNU General Public License along with Coolgame1. If not, see <https://www.gnu.org/licenses/>.

with SDL;
with SDL.Video.Renderers.Makers;
with SDL.Video.Textures.Makers;
with SDL.Video.Windows.Makers;
with SDL.Video.Pixel_Formats;
with SDL.TTFs.Makers;
with SDL.Video.Palettes;
with SDL.Video.Surfaces;
with SDL.Images.IO;
with SDL.Images; use SDL.Images;

package body Graphics is
   window_size : constant SDL.Positive_Sizes := SDL.Positive_Sizes'(800, 600);
   window : SDL.Video.Windows.Window;
   renderer : SDL.Video.Renderers.Renderer;
   font_path : constant String := "resources/fonts/kunika_2.0/fonts/OpenType-TT/Kunika-Regular.ttf";
   font : SDL.TTFs.Fonts;
   
   render_order : Sprite_Order_Access;
   
  function Init return boolean is
  begin
    if SDL.Initialise = True and then SDL.TTFs.Initialise = True and then SDL.Images.Initialise(SDL.Images.Enable_JPG or SDL.Images.Enable_PNG) then
      SDL.Video.Windows.Makers.Create(
                                      Win => window,
                                      Title => "HITBOXERS",
                                      Position => SDL.Natural_Coordinates'(X => 300, Y => 300),
                                      Size => window_size,
                                      Flags => SDL.Video.Windows.Resizable
                                    );
      SDL.Video.Renderers.Makers.Create(renderer, window);
      SDL.TTFs.Makers.Create(font, font_path, 40);
      return True;
    else
      return False;
    end if;
  end Init;

  procedure Quit is
  begin
    window.Finalize;
    SDL.TTFs.Finalise;
    SDL.Images.Finalise;
    SDL.Finalise;
  end Quit;

  procedure Set_Items_To_Render (r : Sprite_Order_Access) is
  begin
    render_order := r;
  end Set_Items_To_Render;

  procedure Render_Pass is
  begin
    renderer.Clear;
    for I in render_order.all'Range loop
      renderer.Copy(SDL.Video.Textures.Texture(render_order.all(I).all));
    end loop;
    renderer.Present;
  end Render_Pass;

  procedure CreateSpriteFromFile (filename : String; ret : Sprite_Access) is
    sprite_surface : SDL.Video.Surfaces.Surface;
  begin
    SDL.Images.IO.Create (Surface => sprite_surface, File_Name => filename);
    SDL.Video.Textures.Makers.Create(SDL.Video.Textures.Texture(ret.all), renderer, sprite_surface);
  end CreateSpriteFromFile;
  
  procedure CreateTextSprite (text : String; ret : Sprite_Access) is
    text_surface : SDL.Video.Surfaces.Surface;
  begin
    text_surface := SDL.TTFs.Render_Shaded(
                                            Self => font,
                                            Text => text,
                                            Colour => SDL.Video.Palettes.Colour'(Red => 98, Green => 236, Blue => 120, Alpha => 255),
                                            Background_Colour => SDL.Video.Palettes.Colour'(Red => 236, Green => 203, Blue => 98, Alpha => 255)
                                          );
    SDL.Video.Textures.Makers.Create(SDL.Video.Textures.Texture(ret.all), renderer, text_surface);
  end CreateTextSprite;

end Graphics;
