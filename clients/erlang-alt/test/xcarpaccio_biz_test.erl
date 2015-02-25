-module(xcarpaccio_biz_test).

-include_lib("eunit/include/eunit.hrl").
-include("assert.hrl").

%% ===================================================================
%% Tests
%% ===================================================================

calculate_total_ht__test() ->
  {ok, Total1} = xcarpaccio_biz:calculate_total_ht([23.8], [6], 0),
  ?assertEqualNbr(142.8, Total1, 0.001),
  {ok, Total3} = xcarpaccio_biz:calculate_total_ht([23.8, 5.1, 56.2], [6, 3, 11], 0),
  ?assertEqualNbr(776.3, Total3, 0.001).
