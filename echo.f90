program echo
  implicit none
  integer rstat
  integer force, mass, accel
  character(20) :: input

  print *, 'Lets calculate force. Set values for mass and acceleration as &
       & mass [value] accel [value] and get value by writing return'


  do while(.true.)
     do while(.true.)
        read(*,'(A)',iostat=rstat) input

        if (rstat /= 0) then
           write(*,*) 'fortran: io error'
           stop
        else
           if (input(1:5) == 'accel') then
              read(input(7:), *, iostat=rstat) accel
              if (rstat == 0) then
                 write(*,'(i10)') accel
              else
                 write(*,*) 'bad input'
              endif
           else if (input(1:4) == 'mass') then
              read(input(6:), *, iostat=rstat) mass
              if (rstat == 0) then
                 write (*,'(i10)') mass
              else
                 write (*,*) 'bad input'
              endif
           else if (input(1:6) == 'return') then
              exit
           else
              write(*,*) 'bad input' 
           end if
        end if
     end do

     force = mass * accel
     write (*,'(i10)') force
  end do
end program echo
