#-----------------------------------------------------------------------------#
# Author    : Inc
# Module    : binary_gcd.py
# Date      : June 23
# Version   : v1
# Remarks   : Initial Draft -v1
#
#
#
#
#
#-----------------------------------------------------------------------------#
import math

def gcd (num_0,num_1):
    multiplier = 1
    if (num_0 == 0 and num_1 == 0):
        return 0
    else:
        while (True):
            if (num_0 == 0):
                return num_1 * multiplier
            elif (num_1 == 0):
                return num_0 * multiplier
            else:
                if ((num_0 & 1 == 0) and (num_1 &  1 == 0)): # Both are even
                    num_0 = num_0 >> 1                      # SHift right by 1 for division by 2
                    num_1 = num_1 >> 1                      # Shift right by 1 for division by 2
                    multiplier = multiplier * 2
                elif (num_0 & 1 == 0):                      # num-0 is even
                    num_0 = num_0 >> 1
                elif (num_1 & 1 == 0):                      # num-1 is even
                    num_1 = num_1 >> 1
                elif (num_0 > num_1):                       # num_0 and num_1 are Odd and num_0 > num_1
                    num_0 = (num_0 - num_1) >> 1
                else:                                       # num_0 and num_1 are Odd and num_1 > num_0
                    num_1 = (num_1 - num_0) >> 1


if __name__ == "__main__":
    num_0   = int(input("Enter Num_0: "))
    num_1   = int(input("Enter Num_1: "))
    gcd_val = gcd(num_0,num_1)
    gcd_exp = math.gcd(num_0,num_1)
    print (f"gcd_val Computed = {gcd_val}")
    print (f"gcd_val Expected = {gcd_exp}")
    if gcd_val == gcd_exp:
        print ("[+] Success : Results are Matching")
    else:
        print ("[-] Failure : Reasults are not matching")


