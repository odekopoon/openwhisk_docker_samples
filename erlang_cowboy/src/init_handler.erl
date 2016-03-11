-module(init_handler).

-export([init/3]).
-export([handle/2]).
-export([terminate/3]).

init(_Transport, Req, []) ->
	{ok, Req, undefined}.


handle(Req, State) ->
    {Method, Req2} = cowboy_req:method(Req),
    {ok, Req3} =
        case Method of
            <<"POST">> -> cowboy_req:reply(200, Req2);
            _          -> cowboy_req:reply(405, Req2)
        end,
    {ok, Req3, State}.

terminate(_Reason, _Req, _State) ->
	ok.
