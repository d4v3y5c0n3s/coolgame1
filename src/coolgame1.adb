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
                  end if;
                  Title.Process;
               when GameState.battle =>
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
