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
with Interfaces.C;

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
                                      Title => "coolgame1",
                                      Position => SDL.Natural_Coordinates'(X => 300, Y => 300),
                                      Size => window_size,
                                      Flags => SDL.Video.Windows.Resizable
                                    );
      SDL.Video.Renderers.Makers.Create(renderer, window);
      SDL.TTFs.Makers.Create(font, font_path, 18);
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
    s : Sprite_Access;
  begin
    renderer.Clear;
    for I in render_order.all'Range loop
      s := render_order.all(I);
      renderer.Copy(SDL.Video.Textures.Texture(s.all.tex), s.all.from_rect, s.all.to_rect, 0.0, SDL.Video.Rectangles.Point'(X => 0, Y => 0), SDL.Video.Renderers.None);
    end loop;
    renderer.Present;
  end Render_Pass;
  
  procedure GetTextureSize (spa: Sprite_Access; sz : out SDL.Sizes) is
    pf : SDL.Video.Pixel_Formats.Pixel_Format_Names;
    kd : SDL.Video.Textures.Kinds;
  begin
    SDL.Video.Textures.Query(spa.all.tex, pf, kd, sz);
  end GetTextureSize;

  procedure CreateSpriteFromFile (filename : String; ret : Sprite_Access) is
    sprite_surface : SDL.Video.Surfaces.Surface;
    tex_size : SDL.Sizes;
  begin
    SDL.Images.IO.Create (Surface => sprite_surface, File_Name => filename);
    SDL.Video.Textures.Makers.Create(SDL.Video.Textures.Texture(ret.all.tex), renderer, sprite_surface);
    GetTextureSize(ret, tex_size);
    ret.all.from_rect := SDL.Video.Rectangles.Rectangle'(0, 0, tex_size.Width, tex_size.Height);
    ret.all.to_rect := SDL.Video.Rectangles.Rectangle'(0, 0, tex_size.Width, tex_size.Height);
  end CreateSpriteFromFile;
  
  procedure CreateTextSprite (text : String; ret : Sprite_Access) is
    text_surface : SDL.Video.Surfaces.Surface;
    tex_size : SDL.Sizes;
  begin
    text_surface := SDL.TTFs.Render_Shaded(
      Self => font,
      Text => text,
      Colour => SDL.Video.Palettes.Colour'(Red => 255, Green => 255, Blue => 255, Alpha => 255),
      Background_Colour => SDL.Video.Palettes.Colour'(Red => 0, Green => 0, Blue => 0, Alpha => 255)
    );
    SDL.Video.Textures.Makers.Create(SDL.Video.Textures.Texture(ret.all.tex), renderer, text_surface);
    GetTextureSize(ret, tex_size);
    ret.all.from_rect := SDL.Video.Rectangles.Rectangle'(0, 0, tex_size.Width, tex_size.Height);
    ret.all.to_rect := SDL.Video.Rectangles.Rectangle'(0, 0, tex_size.Width, tex_size.Height);
  end CreateTextSprite;
  
  function SpritePixelWidth (S : Sprite_Access) return Positive is
    tex_size : SDL.Sizes;
  begin
    GetTextureSize(S, tex_size);
    return Integer(tex_size.Width);
  end SpritePixelWidth;
  
  function SpritePixelHeight (S : Sprite_Access) return Positive is
    tex_size : SDL.Sizes;
  begin
    GetTextureSize(S, tex_size);
    return Integer(tex_size.Height);
  end SpritePixelHeight;
  
  procedure SpriteSetSubSpriteTransform(S : Sprite_Access; W : Positive; H : Positive; X : Natural; Y : Natural) is
  begin
    S.all.from_rect.X := Interfaces.C.int(X);
    S.all.from_rect.Y := Interfaces.C.int(Y);
    S.all.from_rect.Width := Interfaces.C.int(W);
    S.all.from_rect.Height := Interfaces.C.int(H);
  end SpriteSetSubSpriteTransform;
  
  procedure SpriteSetOutputTransform(S : Sprite_Access; W : Positive; H : Positive; X : Integer; Y : Integer) is
  begin
    S.all.to_rect.X := Interfaces.C.int(X);
    S.all.to_rect.Y := Interfaces.C.int(Y);
    S.all.to_rect.Width := Interfaces.C.int(W);
    S.all.to_rect.Height := Interfaces.C.int(H);
  end SpriteSetOutputTransform;

end Graphics;
