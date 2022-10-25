--Copyright 2022 Troy Jacobs
--  This file is part of Coolgame1.
--  Coolgame1 is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.
--  Coolgame1 is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
--  You should have received a copy of the GNU General Public License along with Coolgame1. If not, see <https://www.gnu.org/licenses/>.

with Animate;

package Fighters is
  type CharacterID is (Dummy);-- enumerated type for each character
  type Base_State is (Standing, Crouching, MidAir);
  type Facing_Dir is (Left, Right);
  -- ^--base character state such as crouch, stand, etc. that determines what moves can be used
  --type Move (s : Base_State) is array();-- a temporary sub-state a character enters resulting
  --type Moveset (c : CharacterID);
  --type Move_Binding is ;
  type Fighter is record
    anim_sprite : Animate.Animated_Sprite;
    X : Integer;
    Y : Integer;
    facing : Facing_Dir;
    base : Base_State;
  end record;
  procedure Move_Fighter (F : Fighter; X : Integer; Y : Integer);
end Fighters;
