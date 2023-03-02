-module(f90_port).
-behaviour(gen_server).

-export([start_link/1, stop/0, echo/1]).
-export([init/1, handle_call/3, handle_cast/2, handle_info/2]).

start_link(Filename) ->
    gen_server:start_link({local, ?MODULE}, ?MODULE, Filename, [binary]).

stop() ->
    gen_server:cast(?MODULE, stop).

echo(X) ->
    gen_server:cast(?MODULE, {echo, X}).

%% callbacks
init(Filename) ->
    process_flag(trap_exit, true),
    Port = open_port({spawn, Filename}, []),
    {ok, {port, Port}}.

handle_call(Msg, _From, State) ->
    {reply, Msg, State}.

handle_cast({echo, X}, {port, Port} = State) ->
    port_command(Port, term_to_binary(X)),
    {noreply, State};
    
handle_cast(stop, {port, Port}) ->
    port_close(Port),
    {stop, normal, []}.

handle_info({_Port, {data, Data}}, State) ->
    io:format("received: ~p~n", [Data]),
    {noreply, State};

handle_info(Msg, State) ->
    erlang:display(Msg),
    {noreply, State}.
    
