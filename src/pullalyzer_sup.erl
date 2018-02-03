%%%----------------------------------------------------------------------------
%% @doc pullalyzer top level supervisor.
%% @end
%%%----------------------------------------------------------------------------

-module(pullalyzer_sup).

-behaviour(supervisor).

%% API
-export([start_link/0]).

%% Supervisor callbacks
-export([init/1]).

-define(SERVER, ?MODULE).

%%=============================================================================
%% API functions
%%=============================================================================

start_link() ->
    supervisor:start_link({local, ?SERVER}, ?MODULE, []).

%%=============================================================================
%% Supervisor callbacks
%%=============================================================================

%% Child :: {Id,StartFunc,Restart,Shutdown,Type,Modules}
init([]) ->
    SupFlags = #{
        strategy => one_for_one,
        intensity => 2,
        period => 120
    },
    ChildDescriptor = #{
        id => pullalyzer_app,
        start => {pullalyzer_app, start_link, []},
        restart => permanent,
        shutdown => 5000,
        type => supervisor,
        modules => [pullalyzer_app]
    },
    ok = supervisor:check_childspecs([ChildDescriptor]),
    {ok, {SupFlags, [ChildDescriptor]}}.

%%=============================================================================
%% Internal functions
%%=============================================================================
