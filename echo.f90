program echo
  implicit none
  integer rstat
  integer force, mass, accel
  character(256) :: input

  
  write(*,*) 'hello, fortran!'
  print *, 'lets calculate force'

  do while(.true.)
     do while(.true.)
        read(*,'(A)',iostat=rstat) input

        if (rstat /= 0) then
           write(*,*) 'fortran: io error'
           stop
        else
           if (input(1:5) == 'accel') then
              read(input(7:), *) accel
              print *, 'accel is (integer)', accel
           else if (input(1:4) == 'mass') then
              read(input(6:), *) mass
              print *, 'mass is (integer)', mass
           else if (input(1:6) == 'return') then
              exit
           else
              write(*,*) 'fortran: incorrect value' 
           end if
        end if
     end do

     force = mass * accel
     write (*,*) force, mass, accel
  end do

end program echo
