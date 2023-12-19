build:
	gfortran *.f90 -o newton
	erlc *.erl

run-f90:
	gfortran *.f90 -o newton
	./newton

run-erl:
	gfortran *.f90 -o newton
	erlc *.erl
	erl

clean:
	rm newton *.beam 
