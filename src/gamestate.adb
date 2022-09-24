--Copyright 2022 Troy Jacobs
--  This file is part of Coolgame1.
--  Coolgame1 is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.
--  Coolgame1 is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
--  You should have received a copy of the GNU General Public License along with Coolgame1. If not, see <https://www.gnu.org/licenses/>.

package body GameState is
  State : Game_State := title;

  function Get_State return Game_State is
  begin
    return State;
  end Get_State;

  procedure Change_To_State (s : Game_State) is
  begin
    State := s;
  end Change_To_State;
end GameState;
