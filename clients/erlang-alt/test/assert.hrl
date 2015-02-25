%% This is a convenience macro which gives more detailed reports when
%% the expected LHS value is not a pattern, but a computed value
-ifdef(NOASSERT).
-define(assertEqualNbr(Expect, Expr, Delta),ok).
-else.
-define(assertEqualNbr(Expect, Expr, Delta),
  ((fun (__X) ->
      case (abs(Expr - __X)) of
        __D when __D < Delta -> ok;
        __V -> erlang:error({assertEqual_failed,
                  [{module, ?MODULE},
                   {line, ?LINE},
                   {expression, (??Expr)},
                   {expected, __X},
                   {delta, (??Delta)},
                   {value, __V}]})
      end
    end)(Expect))).
-endif.
-define(_assertEqualNbr(Expect, Expr, Delta), ?_test(?assertEqualNbr(Expect, Expr, Delta))).
