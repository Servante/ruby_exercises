# 1.Write a method #fibs which takes a number and returns that many members of the fibonacci sequence. Use iteration for this solution.

# 2.Now write another method #fibs_rec which solves the same problem recursively. This can be done in just 3 lines (or 1 if you’re crazy, but don’t consider either of these lengths a requirement… just get it done).


def fib(n)
	sequence = [0, 1]
	for x in 0..(n - 3)
		sequence << sequence[-2] + sequence[-1]
	end
	p sequence
end


fib(3)

