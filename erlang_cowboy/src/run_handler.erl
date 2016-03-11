-module(run_handler).

-export([init/3]).
-export([handle/2]).
-export([terminate/3]).

init(_Transport, Req, []) ->
	{ok, Req, undefined}.

handle(Req, State) ->
    {Method, Req2} = cowboy_req:method(Req),
    HasBody = cowboy_req:has_body(Req2),
    {ok, Req3} = hello(Method, HasBody, Req),
    {ok, Req3, State}.

hello(<<"POST">>, true, Req) ->
    {ok, Body, Req2} = cowboy_req:body(Req),
    PostVals = jsx:decode(Body),
    Params = proplists:get_value(<<"value">>, PostVals, []),
    Name = proplists:get_value(<<"name">>, Params, <<"world">>),
    Text = <<<<"Hello, ">>/bitstring, Name/bitstring>>,
    Json = jsx:encode([{<<"result">>, [{<<"msg">>, Text}]}]),
    cowboy_req:reply(200, [
        {<<"content-type">>, <<"application/json; charset=utf-8">>}
    ], Json, Req2);

hello(<<"POST">>, false, Req) ->
    cowboy_req:reply(400, [], <<"Missing body.">>, Req);

hello(_, _, Req) ->
    cowboy_req:reply(405, Req).

terminate(_Reason, _Req, _State) ->
	ok.
