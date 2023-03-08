-module(f90).
-behaviour(gen_server).

-export([start_link/1, start_link/0, stop/0, call/1]).
-export([init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2]).

start_link() -> start_link("./makoto").

start_link(Filename) ->
    gen_server:start_link({local, ?MODULE}, ?MODULE, Filename, []).

stop() ->
    gen_server:cast(?MODULE, stop).

call(X) ->
    gen_server:call(?MODULE, {call, X}).

%% callbacks
init(Filename) ->
    process_flag(trap_exit, true),
    Port = open_port({spawn, Filename}, [{packet, 2}, binary]),
    {ok, {port, Port}}.

handle_call({call, X}, _From, {port, Port} = State) ->
    port_command(Port, list_to_binary(X)),
    receive
	{Port, {data, Data}} ->
	    {reply, Data, State}
	end.
    
handle_cast(stop, {port, Port}) ->
    port_close(Port),
    {stop, normal, []}.

handle_info({Port, {data, Data}}, {port, Port} = State) ->
    io:format("received: ~p~n", [Data]),
    {noreply, State};

handle_info({'EXIT', _Port, Reason}, _State) ->
    io:format("exit: reason ~p~n", [Reason]),
    {stop, Reason, undefined};

handle_info(Msg, State) ->
    erlang:display(Msg),
    {noreply, State}.

terminate(_Reason, _State) ->
    ok.
