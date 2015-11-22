: noop ;

create data_stack   110 cells allot
create return_stack   256 cells allot

create str  char w c, char o c, char r c, char l c, char d c, 10 c,

\ : type   dup if swap dup c@ emit 1+ swap 1- type then drop drop ;
: type   begin dup while swap dup c@ emit 1+ swap 1- repeat drop drop ;

: abort   ." ABORT!" bye ;
: cr   10 emit ;

\ : bounds ... ;
\ : type   bounds do i c@ emit loop ;

variable x
: foo   70 x !  x @ emit ;

0 value fd
create buf 22 allot

: readme   s" README " 0 open-file abort" Error opening file" to fd
           buf 22 fd read-file abort" Error reading file"
           buf 22 type
           fd close-file abort" Error closing file" ;

defer baz
' foo is baz

16 constant sixteen

forward: bar
: ok   ." ok" cr ;
: hello   s" hello " type str 6 type ;
: warm   hello foo baz bar cr readme ['] hello execute ok bye ;
: bar   sixteen cells 1+ 2 or 1 xor emit ;

code cold  also meta
   then,

   ' warm >body # I mov,
   ' data_stack >body 100 cells + # S mov,
   ' return_stack >body 256 cells + # R mov,

   next,
end-code
