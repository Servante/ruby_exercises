=begin
	
Build a method #merge_sort that takes in an array and returns a sorted array, 
using a recursive merge sort methodology.


Tips:Think about what the base case is and what behavior is happening again
and again and can actually be delegated to someone else (e.g. that same method!).



psuedocode


merge(b[1..p], c[1..q], a[1..p+q])

ib = 1, ic = 1, ia = 1   #pointers

while ib <= p and ic <= q
  if b[ib] < c[ic]
    a[ia] = b[ib] ; ib = ib + 1
  else 
    a[ia] = c[ic] ; ic = ic + 1 
  ia = ia + 1

if ib == p + 1
  copy c[ic..q] into a[ik..p + q]
else
  copy b[ib..p] into a[ik..p+q]


#append

end