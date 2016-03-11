-module(openwhisk_erl_cowboy_app).
-behaviour(application).

-export([start/2]).
-export([stop/1]).

start(_Type, _Args) ->
    Dispatch = cowboy_router:compile([
        {'_', [
               {"/run",  run_handler,  []},
               {"/init", init_handler, []}
              ]}
    ]),
    {ok, _} = cowboy:start_http(http, 100, [{port, 8080}], [
        {env, [{dispatch, Dispatch}]}
    ]),
    openwhisk_erl_cowboy_sup:start_link().

stop(_State) ->
    ok.
