# Binary-GCD
Binary GCD
Binary GCD algorithm or Stein's algorithm
1.	Introduction
The Binary GCD algorithm or Stein's algorithm, is an algorithm that calculates two non-negative integer's largest common divisor by using simpler arithmetic operations than the standard Euclidean algorithm and it reinstates division by numerical shifts, comparisons, and subtraction operations.
2.	Algorithm
The Binary GCD Algorithm for calculating GCD of two numbers x and y can be given as follows:
i.	If both x and y are 0, gcd is zero gcd (0, 0) = 0.
ii.	Gcd (x, 0) = x and gcd (0, y) = y because everything divides 0. 
iii.	Gcd (x, x) = x, gcd (x, x mod x) = gcd (x, 0) = x  
iv.	If x and y are both even, gcd (x, y) = 2 * gcd (x/2, y/2) because 2 is a common divisor. Multiplication with 2 can be done with bitwise shift operator.
v.	If x is even and y is odd, gcd (x, y) = gcd (x/2, y).
vi.	On similar lines, if x is odd and y is even, then gcd (x, y) = gcd (x, y/2). It is because 2 is not a common divisor.
vii.	If both x and y are odd, then gcd (x, y) = gcd (|x-y|/2, y)
viii.	Repeat steps 3–5 until x = y, or until x = 0. In either case, the GCD is power (2, k) * y, where power (2, k) is 2 raises to the power of k and k is the number of common factors of 2 found in step (iii).
 





3.	Detailed Example
 
4.	Complexity
Worst case time complexity: Θ((logN)2). The algorithm requires the worst-case time of O((logN)2), while each step decreases one of the operands by a minimum factor of 2, the subtract and shift operations, for huge entities, take linear time (though they are still very quick in practice, requiring around a single operation per word).
 logN denotes the number of digits in a number N. This arises from the factor a number reduces by a factor of 2 where 2 is the base of the logarithm.
5.	Efficiency
It has been shown that, binary GCD algorithm can be nearly 60 per cent more cost-effective (in comparison to the number of bit operations) than the Euclidean method on an average. Although this approach moderately outshines the regular Euclidean algorithm in real implementations, its asymptotic efficiency is the same and the binary GCD algorithm is considerably more productive in real implementations.


