build:
	gfortran *.f90 -o newton
	erlc *.erl

run-erl:
	gfortran *.f90 -o newton
	erlc *.erl
	erl

run-f90:
	gfortran *.f90 -o newton
	erlc *.erl
	./newton

clean:
	rm newton *.beam 
