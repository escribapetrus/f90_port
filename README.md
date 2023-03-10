# f90_port

Creates a genserver able to talk to an external Fortran server

## How to build 

Use `make` to compile the project.

To build each step manually, run:

```
	gfortran *.f90 -o newton
	erlc *.erl
```

## How to run

Run `erl` to start the Erlang session. In the Erlang shell, you can start the `f90` genserver by using the compiled program name, and execute commands in the genserver API:

``` 
    Eshell V13.1.2  (abort with ^G)
    1> f90:start_link("./newton").
    {ok,<0.84.0>}
    2> f90:force(90,80).
    7200 
```


## How it works

The genserver creates a port to the external program. A port is an erlang
process that manages and communicates with external programs.

The Fortran program expects inputs from stdin (which are provided by the port), such as:

- mass [value]: stores the value in the mass variable
- accel [value]: stores the value in the accel variable
- return: exits the loop and proceeds to the next step
