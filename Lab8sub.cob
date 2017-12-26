
      * Tyler Zysberg
      * Calculates total payroll based on department, now with a school tax and unsorted file
       Identification Division.
       Program-ID.     Lab8Sub.

       Data Division.      
       Linkage Section.
       01 p1 Pic X.
       01 p2.
          05 Mar Pic 9999V9999.
          05 UnMar Pic 9999V9999.
             
             
             
       Procedure Division using p1 p2.
       000-Main.
       if p1 = "F"
      *Federal Taxes
       Move .28 to Mar
       Move .33 to UnMar
       end-if
      *State Taxes
       if p1 = "S"
       Move .0475 to Mar
       end-if
      *Medical
       if p1 = "M"
       Move 100.0 to Mar
       Move 075.0 to UnMar
       end-if
      *Dental
       if p1 = "D"
       move 40 to Mar
       Move 25 to UnMar
       end-if
      *Vision
       if p1 = "V"
       Move 7.5 to Mar
       Move 5 to UnMar
       end-if
	   exit Program.
