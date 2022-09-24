package GameState is
  type Game_State is (title, battle, quit);
  function Get_State return Game_State;
  procedure Change_To_State ( s : Game_State );
end GameState;
