with SDL.Events.Events;
with SDL.Events.Keyboards;

with GameState;
with Graphics;

package body Title is
  event : SDL.Events.Events.Events;
  package Keys renames SDL.Events.Keyboards;
  --yolo : Graphics.Sprite := Graphics.CreateTextSprite("YOLO");

  procedure Init is
  begin
    null;
  end Init;

  procedure SwappedTo is
    sp_ord : Graphics.Sprite_Order_Access := new Graphics.Sprite_Order(1 .. 1);-- := (1 => Graphics.CreateTextSprite("YOLO"))
  begin
    Graphics.CreateTextSprite("YOLO", sp_ord.all(1));
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
