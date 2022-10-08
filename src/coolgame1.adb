--Copyright 2022 Troy Jacobs
--  This file is part of Coolgame1.
--  Coolgame1 is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.
--  Coolgame1 is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
--  You should have received a copy of the GNU General Public License along with Coolgame1. If not, see <https://www.gnu.org/licenses/>.

with Title;
with Battle;
with GameState; use type GameState.Game_State;
with Graphics;

procedure Coolgame1 is
begin
   if Graphics.Init then

      -- main loop
      declare
         running : Boolean := True;
         last_state : GameState.Game_State := GameState.quit;
      begin
         Title.Init;
         Battle.Init;
         
         while running loop
            -- look into making updates frame-independent in the future

            -- calls the process function for the current game state on loop
            case GameState.Get_State is
               when GameState.title =>
                  if last_state /= GameState.title then
                     Title.SwappedTo;
                     last_state := GameState.title;
                  end if;
                  Title.Process;
               when GameState.battle =>
                  if last_state /= GameState.battle then
                     Battle.SwappedTo;
                     last_state := GameState.battle;
                  end if;
                  Battle.Process;
               when GameState.quit =>
                  running := False;
            end case;

            Graphics.Render_Pass;
         end loop;
      end;

      Graphics.Quit;
   end if;
end Coolgame1;
