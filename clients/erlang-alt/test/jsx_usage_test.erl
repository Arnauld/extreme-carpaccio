-module(jsx_usage_test).

-include_lib("eunit/include/eunit.hrl").

%% ===================================================================
%% Tests
%% ===================================================================

parsing__test() ->
  Vals = json_utils:decode(<<"{\"prices\":[75.87],\"quantities\":[5],\"country\":\"FR\"}">>),
  ?assertEqual({ok, [75.87]}, json_utils:get_value(Vals, <<"prices">>)),
  ?assertEqual({ok, [5]}, json_utils:get_value(Vals, <<"quantities">>)).

parsing_printable_char_case__test() ->
  Vals = json_utils:decode(<<"{\"prices\":[60.58],\"quantities\":[9],\"country\":\"PT\"}">>),
  ?assertEqual({ok, [60.58]}, json_utils:get_value(Vals, <<"prices">>)),
  ?assertEqual({ok, [9]}, json_utils:get_value(Vals, <<"quantities">>)).


encoding__test() ->
  Data = #{total => 0.0},
  Json = json_utils:encode(Data),
  ?assertEqual(<<"{\"total\":0.0}">>, Json).
