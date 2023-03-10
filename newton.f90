program newton
  implicit none
  integer rstat
  integer mass, accel
  character(20) :: input

  do while(.true.)
     do while(.true.)
        read(*,'(A)',iostat=rstat) input

        if (rstat /= 0) then
           stop
        else
           if (input(1:4) == 'mass') then
              call maybe_read_int(mass, 4 + 2) 
           else if (input(1:5) == 'accel') then
              call maybe_read_int(accel, 5 + 2)
           else if (input(1:6) == 'return') then
              exit
           else
              write(*,*) 'bad input' 
           end if
        end if
     end do

     write (*,'(10i0)') force(mass, accel)

     mass = 0
     accel = 0
  end do

contains
  subroutine maybe_read_int(field, index)
    implicit none
    integer field, index

    read(input(index:), *, iostat=rstat) field
    if (rstat == 0) then
       write(*,'(10i0)') field
    else
       write(*,*) 'bad input'
    endif
  end subroutine maybe_read_int

  function force(m, a) result (f)
    implicit none
    integer m, a, f

    f = m * a
  end function force
end program newton

