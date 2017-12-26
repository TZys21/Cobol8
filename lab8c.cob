      *Tyler Zysberg
      *> Calculates combinations or permutations
      
       Identification Division.
       Program-ID.     Lab8C.

       Environment Division.
       Configuration Section.
       Special-Names.
       
       Data Division.
       Working-Storage Section.
       01 ComVar Pic X(11).
       01 RepVar Pic X(11).
       01 ArgNum Pic 99.
       01 CmdLine Pic X(50).
       01 Param.
          05 p1 Pic X(11).
          05 p2 pic X(11).
          05 p3 Pic 9(9).
          05 p4 Pic 9(9).
       01 Indx Pic 999.
       01 Counter Pic 9(5).
       01 MathVar Pic 9(15).
       01 OtherMath Pic 9(15).
       01 ExtraMath Pic 9(15).
	   01 Randoms pic 9(15) value 0.
	   01 randoms2 pic 9(15) value 0.
       01 RVal Pic 9(9).
       01 OutMath Pic ZZZ,ZZZ,ZZZ,ZZZ,ZZ9.
             
             
             
       Procedure Division.
       000-Main.
           Move 1 to ArgNum
           Display ArgNum Upon Argument-Number
           Accept p1 from Argument-Value
           Add 1 to ArgNum
           Display ArgNum Upon Argument-Number
           Accept p2 from Argument-Value
           Add 1 to ArgNum
           Display ArgNum Upon Argument-Number
           Accept p3 from Argument-Value
           Add 1 to ArgNum
           Display ArgNum Upon Argument-Number
           Accept p4 from Argument-Value
           if p4 = 0
           Display "Requires 4 Parameters"
           else
           if p4 > p3
           Display "4th Parameter cannot " with no advancing
           Display "be larger than the 3rd parameter"
           else
           Move Function Upper-case(p1) to ComVar 
           Move Function Upper-case(p2) to RepVar
           if Function Trim(ComVar) = "C" or "COMBINATION"
              or "P" or "PERMUTATION"
            if ComVar = 'P' or "PERMUTATION"
             if RepVar = "Y" or "YES"
              Perform 101-PermYesRep
            Display "Number of Permutations: " Function Trim(OutMath)
             else
              if RepVar = "N" or "NO"
               Perform 100-PermNoRep
            Display "Number of Permutations: " Function Trim(OutMath)
              else
               Display "Second Parameter is invalid"
              end-if
             end-if
             
            else
             if ComVar = 'C' or "COMBINATION"
              if RepVar = "Y" or "YES"
               Perform 103-ComYesRep
            Display "Number of Combinations: " Function Trim(OutMath)
              else
               if RepVar = "N" or "NO"
                Perform 102-ComNoRep
            Display "Number of Combinations: " Function Trim(OutMath)
               else
                Display "Second Parameter is invalid"
               end-if
              end-if
              
             end-if
            end-if
           else
           Display "First Parameter is invalid"
           end-if
           end-if
           end-if
           stop run.
       
       100-PermNoRep.
           
           Move Function FACTORIAL(p3) to MathVar
           SUBTRACT p4 from p3 giving Randoms
           Move Function FACTORIAL(Randoms) to othermath
           Divide MathVar by OtherMath giving MathVar
           Move MathVar to OutMath.
          
       101-PermYesRep.
           Move p3 to MathVar
           Perform varying Indx from 1 by 1 until Indx = p4
           Multiply Mathvar by p3 giving MathVar
           end-perform
           Move MathVar to OutMath.
           
       102-ComNoRep.
           Move Function FACTORIAL(p3) to MathVar
		   Compute Randoms = (p3 - p4)
           Move Function FACTORIAL(Randoms) to OtherMath
           Move Function FACTORIAL(p4) to ExtraMath
           Multiply OtherMath by ExtraMath giving OtherMath
           Divide MathVar by OtherMath giving MathVar
           Move MathVar to OutMath.
           
       103-ComYesRep.
		   Compute randoms = (p3 + p4 - 1)
           Move Function FACTORIAL(Randoms) to MathVar
           Move Function FACTORIAL(p4) to OtherMath
		   Compute randoms2 = (p3 - 1)
           Move Function FACTORIAL(Randoms2) to ExtraMath
           Multiply OtherMath by ExtraMath giving OtherMath
           Divide MathVar by OtherMath giving MathVar
           Move MathVar to OutMath.
