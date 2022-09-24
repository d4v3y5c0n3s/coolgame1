with SDL.Events.Events;
with SDL.Events.Keyboards;

with GameState;
with Graphics;

package body Battle is
  event : SDL.Events.Events.Events;
  package Keys renames SDL.Events.Keyboards;
  
  procedure Init is
  begin
    null;
  end Init;
  
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
