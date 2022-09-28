--Copyright 2022 Troy Jacobs
--  This file is part of Coolgame1.
--  Coolgame1 is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.
--  Coolgame1 is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
--  You should have received a copy of the GNU General Public License along with Coolgame1. If not, see <https://www.gnu.org/licenses/>.

with SDL.Events.Events;
with SDL.Events.Keyboards;

with GameState;
with Graphics;
with Fighters;

package body Battle is
  event : SDL.Events.Events.Events;
  package Keys renames SDL.Events.Keyboards;
  
  procedure Init is
  begin
    null;
  end Init;

  procedure SwappedTo is
  begin
    null;
  end SwappedTo;
  
  procedure Process is
  begin
    while SDL.Events.Events.Poll(event) loop
      case event.Common.Event_Type is
        when SDL.Events.Quit =>
          GameState.Change_To_State(GameState.quit);
        when Keys.Key_Down =>
          case Event.Keyboard.Key_Sym.Key_Code is
            when Keys.Code_Escape =>
              GameState.Change_To_State(GameState.quit);
            when others =>
              null;
          end case;
        when others =>
          null;
      end case;
    end loop;
  end process;
end Battle;
--SDL.Video.Textures.Makers.Create(text_texture2, renderer, text_surface2);
--renderer.Copy(text_texture2);
