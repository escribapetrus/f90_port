-module(f90).
-behaviour(gen_server).

-export([start_link/1, force/2, stop/0]).
-export([init/1, handle_call/3, handle_cast/2]).

start_link(Filename) ->
    gen_server:start_link({local, ?MODULE}, ?MODULE, Filename, []).

stop() ->
    gen_server:cast(?MODULE, stop).

force(Mass, Accel) ->
    gen_server:call(?MODULE, {force, Mass, Accel}).

init(Filename) ->
    process_flag(trap_exit, true),
    Port = open_port({spawn, Filename}, [use_stdio, exit_status]),
    {ok, {port, Port}}.
    
handle_call({force, Mass, Accel}, _From, {port, Port} = State) ->
    call_port(mass(Mass), Port),
    call_port(accel(Accel), Port),
    Res = call_port(result(), Port),
    {reply, Res, State}.
    
handle_cast(stop, {port, Port}) ->
    port_close(Port),
    {stop, normal, []}.

call_port(X, Port) ->
    port_command(Port, X),
    receive
	{_, {data, Data}} ->
	    TrimmedData = string:trim(Data),
	    list_to_integer(TrimmedData)
    after 500 -> nil
    end.

accel(X) -> "accel " ++ integer_to_list(X) ++ "\n".
mass(X) -> "mass " ++ integer_to_list(X) ++ "\n".
result() -> "return\n".
