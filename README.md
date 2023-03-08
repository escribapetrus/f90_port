# f90_port

Our objective is to create an erlang server that calls an external fortran program

## erlang server
The erlang program is a gen_server that opens up a _port_ to the fortran program.

A port is a process that sends and receives messages from external programs,
and is used most frequently to interface with C programs.

## fortran program
We wrote the simplest program possible, that calculates the 2nd Newtonian law.
We input mass and acceleration, and it gives us the force.

