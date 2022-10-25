--Copyright 2022 Troy Jacobs
--  This file is part of Coolgame1.
--  Coolgame1 is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.
--  Coolgame1 is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
--  You should have received a copy of the GNU General Public License along with Coolgame1. If not, see <https://www.gnu.org/licenses/>.

with Graphics;
with Ada.Calendar;

package Animate is
  type Event_Identity is range 0 .. 255;
  type Event is record
    event : Event_Identity;
    start_delay : Duration;
  end record;
  type Track is array(Natural range <>) of Event;
  type Track_Array is array (Natural range <>) of access Track;
  type Animations is record
    playing : Boolean := false;
    available_tracks : access Track_Array;
    current_track : access Track;
  end record;
  type Animated_Sprite is record
    s : Graphics.Sprite_Access;
    cols : Positive;
    rows : Positive;
    anims : Animations;
  end record;
  function Read_Animated_Sprite_From_File (F : String; Cols : Positive; Rows : Positive; sprite : Graphics.Sprite_Access) return Animated_Sprite;
  procedure Jump_To_Animation_Track (A : Animations; Index : Natural);
  procedure Pause (A : in out Animations);
  procedure Play (A : in out Animations);
  procedure Anim_Update (A : Animations);
end Animate;
