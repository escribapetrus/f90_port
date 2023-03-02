program echo
  integer rstat
  character(100) :: input

  do while(.true.)
     write(*,*) 'fortan: tell me something.'
     read(*,*,iostat=rstat) input

     if (rstat > 0) then
        write(*,*) 'fortran: input error, write something else.'
     else if (rstat < 0) then
        write(*,*) 'fortran: end of file'
     else
        write(*,*) input
     end if
  end do
  
end program echo
