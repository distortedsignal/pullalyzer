%%%-------------------------------------------------------------------
%% @doc pullalyzer public API
%% @end
%%%-------------------------------------------------------------------

-module(pullalyzer_app).

-behaviour(application).

%% Application callbacks
-export([start/2, stop/1]).
-export([send/2]).

%%====================================================================
%% API
%%====================================================================

start(_StartType, _StartArgs) ->
    io:fwrite("Started."),
    receive
        Test ->
            io:fwrite("Got it ~s", [Test])
    end,
    start(one, two).

%%--------------------------------------------------------------------
stop(_State) ->
    ok.

%%====================================================================
%% Internal functions
%%====================================================================
send(Proc, Arg) ->
    Proc ! Arg.