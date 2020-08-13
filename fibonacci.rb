
def fib_iterative(n)
	sequence = [0, 1]
	for x in 0..(n - 3)
		sequence << sequence[-2] + sequence[-1]
	end
	p sequence
end

fib_iterative(25)



def fib_recursive(n, seq = [0, 1])
	if n == 0
		[0]
	elsif n == 1
		seq
	else
		seq << (seq[-1] + seq[-2])
		fib_recursive(n-1, seq)
	end
end

p fib_recursive(25)

