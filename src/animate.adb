--Copyright 2022 Troy Jacobs
--  This file is part of Coolgame1.
--  Coolgame1 is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.
--  Coolgame1 is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
--  You should have received a copy of the GNU General Public License along with Coolgame1. If not, see <https://www.gnu.org/licenses/>.

with Graphics;
with Ada.Calendar;

package body Animate is
  function Read_Animated_Sprite_From_File (F : String; Cols : Positive; Rows : Positive; sprite : Graphics.Sprite_Access)
  return Animated_Sprite is
    default_anim : Animations;
    height : Positive;
    width : Positive;
  begin
    Graphics.CreateSpriteFromFile(F, sprite);
    height := Graphics.SpritePixelHeight(sprite)/Rows;
    width := Graphics.SpritePixelWidth(sprite)/Cols;
    Graphics.SpriteSetSubSpriteTransform(
      sprite, height, width, 0, 0
    );
    Graphics.SpriteSetOutputTransform(
      sprite, 100, 100, 100, 100
    );
    default_anim.available_tracks := new Track_Array(0 .. 0);
    default_anim.available_tracks.all(0) := new Track(0 .. 0);
    default_anim.available_tracks.all(0).all(0) := Event'(Event_Identity'(0), 0.0);
    default_anim.current_track := default_anim.available_tracks.all(0);
    return Animated_Sprite'(sprite, Cols, Rows, default_anim);
  end Read_Animated_Sprite_From_File;
  
  procedure Jump_To_Animation_Track (A : Animations; Index : Natural) is
  begin
    null;
  end Jump_To_Animation_Track;
  
  procedure Pause (A : in out Animations) is
  begin
    A.playing := false;
  end Pause;
  
  procedure Play (A : in out Animations) is
  begin
    A.playing := true;
  end Play;
  
  procedure Anim_Update (A : Animations) is
  begin
    null;
  end Anim_Update;
end Animate;