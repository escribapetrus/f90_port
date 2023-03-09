build:
	gfortran *.f90 -o makoto
	erlc *.erl

run:
	gfortran *.f90 -o makoto
	erlc *.erl
	erl

clean:
	rm makoto *.beam 
