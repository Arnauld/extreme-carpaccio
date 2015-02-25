-module(xcarpaccio_biz).

%% API

-export([calculate_total/3]).

%% Visible for tests
-ifdef(TEST).
-export([calculate_total_ht/3, tax_of/1, apply_reduction/1]).
-endif.

%% ===================================================================
%% API functions
%% ===================================================================

calculate_total(Prices, Quantities, Country) ->
  {ok, HT} = calculate_total_ht(Prices, Quantities, 0),
  TX = tax_of(Country),
  Total = HT * (1 + TX/100.0),
  apply_reduction(Total).

%% ===================================================================
%% Internal functions
%% ===================================================================

apply_reduction(S) when S >=  1000 -> S * (1 - 3/100);
apply_reduction(S) when S >=  5000 -> S * (1 - 5/100);
apply_reduction(S) when S >=  7000 -> S * (1 - 7/100);
apply_reduction(S) when S >= 10000 -> S * (1 - 10/100);
apply_reduction(S) when S >= 50000 -> S * (1 - 15/100);
apply_reduction(S) -> S.

calculate_total_ht([], [], Sum) -> {ok, Sum};
calculate_total_ht([],  _, Sum) -> {missing_price, Sum};
calculate_total_ht( _, [], Sum) -> {missing_quantity, Sum};

calculate_total_ht([Price|Prices], [Quantity|Quantities], Sum) ->
  calculate_total_ht(Prices, Quantities, Sum + Price * Quantity).

tax_of(Country) ->
  case Country of
    <<"BG">> -> 10;
    <<"CZ">> -> 11;
    <<"DK">> -> 12;
    <<"DE">> -> 13;
    <<"EE">> -> 14;
    <<"IE">> -> 15;
    <<"EL">> -> 16;
    <<"ES">> -> 17;
    <<"FR">> -> 18;
    <<"HR">> -> 19;
    <<"IT">> -> 20;
    <<"CY">> -> 10;
    <<"LV">> -> 11;
    <<"LT">> -> 12;
    <<"LU">> -> 13;
    <<"HU">> -> 14;
    <<"MT">> -> 15;
    <<"NL">> -> 16;
    <<"AT">> -> 17;
    <<"PL">> -> 18;
    <<"PT">> -> 19;
    <<"RO">> -> 20;
    <<"SI">> -> 10;
    <<"SK">> -> 11;
    <<"FI">> -> 12;
    <<"SE">> -> 13;
    <<"UK">> -> 14
  end.
