--Copyright 2022 Troy Jacobs
--  This file is part of Coolgame1.
--  Coolgame1 is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.
--  Coolgame1 is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
--  You should have received a copy of the GNU General Public License along with Coolgame1. If not, see <https://www.gnu.org/licenses/>.

with SDL.Events.Events;
with SDL.Events.Keyboards;

with GameState;
with Graphics;

package body Title is
  event : SDL.Events.Events.Events;
  package Keys renames SDL.Events.Keyboards;

  procedure Init is
  begin
    null;
  end Init;

  procedure SwappedTo is
    sp_ord : Graphics.Sprite_Order_Access := new Graphics.Sprite_Order(1 .. 1);
  begin
    sp_ord.all(1) := new Graphics.Sprite;
    Graphics.CreateTextSprite("This Software is Released Under the GNU General Public License Version 3", sp_ord.all(1));
    Graphics.Set_Items_To_Render(sp_ord);
  end SwappedTo;
  
  procedure Process is
  begin
    --handle input
    while SDL.Events.Events.Poll(event) loop
      case event.Common.Event_Type is
        when SDL.Events.Quit =>
          GameState.Change_To_State(GameState.quit);
        when Keys.Key_Down =>
          case Event.Keyboard.Key_Sym.Key_Code is
            when Keys.Code_Escape =>
              GameState.Change_To_State(GameState.quit);
            when Keys.Code_C =>
              GameState.Change_To_State(GameState.battle);
            when others =>
              null;
          end case;
        when others =>
          null;
      end case;
    end loop;
  end process;
end Title;
