build:
	gfortran *.f90 -o makoto
	erlc *.erl

clean:
	rm makoto *.beam 
