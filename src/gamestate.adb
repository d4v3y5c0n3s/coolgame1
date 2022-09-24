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
