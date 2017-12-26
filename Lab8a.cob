
      * Jacob Rollins 4/3/2017
      * Calculates total payroll based on department, now with a school tax and unsorted file
       Identification Division.
       Program-ID.     Lab08a.

       Environment Division.
       Input-Output Section.
       File-Control.
           Select InputFile
               Assign to "lab8a-in.dat"
               Organization is Line Sequential.
           Select SortedInput
               Assign to "Lab8a-sort.dat"
               Organization is Line Sequential.
           Select TmpSrt Assign to Disk.
           Select OtherInput
               Assign to "lab8a-schooltax.dat"
               Organization is Line Sequential
               Access Mode is Sequential.
           Select OutFile
               Assign to "lab8a-out.dat"
               Organization is Line Sequential.
       
       Data Division.
       File Section.
       FD  InputFile.
       01  InFile.
           05  EmpRecord.
               10 FileRegNum Pic 99.
               10 FileRegNam Pic Z(15).
               10 FileDeptNum Pic 9(5).
               10 FileDeptName Pic Z(30).
               10 FileEmpNum Pic 9(5).
               10 FileEmpName.
                  15 FileLastName Pic Z(20).
                  15 FileFirstName Pic Z(15).
               10 FileGender Pic Z.
               10 FileStAddress Pic Z(20).
               10 FileCityState Pic Z(20).
               10 FileJTitle Pic Z(20).
               10 FileBirthdate Pic Z(8).
               10 FileHireDate Pic 9(8).
               10 FileMarStat Pic Z.
               10 FileDep Pic 99.
               10 FileSchoolDist Pic Z(3).
               10 FileInsurance Pic ZZZ.
               10 File401k Pic v999.
               10 FilePayCode Pic Z.
               10 FilePay Pic S9(7)v99.
               10 FileHours Pic S99v99.
               10 FileRate Pic SV999.
               10 FileSales Pic 9(7)v99.
			   
       SD TmpSrt.        
       01 Tmp-Rec.
          05  EmpRecord.
               10 SortRegNum Pic 99.
               10 SortRegNam Pic Z(15).
               10 SortDeptNum Pic 9(5).
               10 SortDeptName Pic Z(30).
               10 SortEmpNum Pic 9(5).
               10 SortEmpName.
                  15 SortLastName Pic Z(20).
                  15 SortFirstName Pic Z(15).
               10 SortGender Pic Z.
               10 SortStAddress Pic Z(20).
               10 SortCityState Pic Z(20).
               10 SortJTitle Pic Z(20).
               10 SortBirthdate Pic Z(8).
               10 SortHireDate Pic 9(8).
               10 SortMarStat Pic Z.
               10 SortDep Pic 99.
               10 SortSchoolDist Pic Z(3).
               10 SortInsurance Pic ZZZ.
               10 Sort401k Pic v999.
               10 SortPayCode Pic Z.
               10 SortPay Pic S9(7)v99.
               10 SortHours Pic S99v99.
               10 SortRate Pic SV999.
               10 SortSales Pic 9(7)v99. 

       FD SortedInput.
       01  Employee.
           10 RegNum Pic 99.
           10 RegNam Pic Z(15).
           10 DeptNum Pic 9(5).
           10 DeptName Pic Z(30).
           10 EmpNum Pic 9(5).
           10 EmpName.
              15 LastName Pic Z(20).
              15 FirstName Pic Z(15).
           10 Gender Pic Z.
           10 StAddress Pic Z(20).
           10 CityState Pic Z(20).
           10 JTitle Pic Z(20).
           10 Birth Pic 9(8).
           10 Hire Pic 9(8).
           10 MarStat Pic Z.
              88 FedRate Value "M" "P".
           10 Dep Pic 99.
           10 SchoolDist Pic ZZZ.
           10 Insurance.
              15 Med Pic Z.
              15 Den Pic Z.
              15 Vis Pic Z.
           10 401k Pic v999.
           10 PayCode Pic Z.
           10 Pay Pic S9(7)v99.
           10 Hours Pic S99v99.
           10 Rate Pic SV999.
           10 Sales Pic 9(7)V99.	   
       FD OtherInput.
       01 TaxFile.
           05 FileDistrictCode Pic XXX.
           05 FileTaxCode Pic V999.
               
       FD OutFile.
       01  ot-record              pic x(208).


               
           
       Working-Storage Section.       
       01  EOF Pic X.
           88 Finished Value "Y".
           01  Page-Header.
            05  PH-Month     Pic Z9/.
            05  PH-Day       Pic 99/.
            05  PH-Year      Pic 9999. 
            05               Pic X(42) Value Spaces. 
            05         Pic X(71) Value "Stomper & Wombat's Emporium". 
            05               Pic X(6) Value "Page:". 
            05  PH-PageNo Pic Z9.
       01  Page-Header2.
            05     Pic X(35) Value" Emp #          Employee        M ".
            05     Pic X(34) Value" Deps  Ins     Gross Pay      Comm".
            05     Pic X(35) Value"ission       401k        Fed      ".
            05     Pic X(35) Value"  State     School Tax  Insurance ".
            05     Pic X(35) Value "    Net Pay".
       01 HourLine.
            05 HourOut Pic Z9.
            05  Pic X Value ":".
            05 MinOut Pic 99.
            05 Pic X Value Spaces.
            05 AMPM Pic XX.
            05 Pic X(40) Value Spaces.
            05 Pic X(33) Value "Monthly Payroll Register".
            05 Pic X(18) Value "- Salary and Sales".
       01 ContLine1.
            05 Pic X(14) Value "  Department: ".
            05 DeptNumOutCont1 Pic X(5).
       01 ContLine2.
            05 Pic X(14) Value Spaces.
            05 DeptNameOutCont1 Pic X(30).
       01 RecordOutput.
            05  Pic X Value Spaces.
            05 EmpNumOut Pic 9(5).
            05  Pic XX Value Spaces.
            05 EmpNameOut Pic 9(22).
            05  Pic XX Value Spaces.
            05 PayrollInfo.
               10 MarStatOut Pic X.
               10 Pic XXX Value Spaces.
               10 DependNumOut Pic 99.
               10 Pic XXX Value Spaces.
               10 CoverageOut Pic XXX.
               10 Pic XXX Value Spaces.
            05 GrossPayOut Pic $Z,ZZZ,ZZ9.99.
            05  Pic XXX Value Spaces.
            05 CommissionOut Pic $Z,ZZZ,ZZZ.ZZ.
            05  Pic XX Value Spaces.
            05 Deductions.
               10 401kOut Pic $ZZ,ZZZ.ZZ.
               10  Pic XX Value Spaces.
               10 FedTax Pic $ZZ,ZZ9.99.
               10  Pic XX Value Spaces.
               10 StateTax Pic $ZZ,ZZ9.99.
               10  Pic XX Value Spaces.
               10  SchoolDeductOut Pic $ZZ,ZZ9.99.
               10  Pic XX Value Spaces.
               10 InsuranceOut Pic $ZZ,ZZ9.99.
            05  Pic XXX Value Spaces.
            05 NetPay Pic $Z,ZZZ,ZZ9.99.
       01 MidLine.
           05   Pic X(109) Value Spaces.
           05   Pic X(6) Value "Dept: ".
           05 DeptNumOutCont2 Pic X(5).
           05   Pic XX Value Spaces.
           05   Pic X(15) Value "Total Payroll: ".
           05 PayrollContOut Pic $ZZZ,ZZZ,ZZ9.99.
       01 EndLine.
           05   Pic X(111) Value Spaces.
           05   Pic X(22) Value "Total Expected Payroll".
           05 TotalOut Pic $ZZZ,ZZZ,ZZZ,ZZ9.ZZ.
       01 DetailLine Pic X(208).
       01 DateandTime.
          05 CurrentDate.
             10 CYear Pic 9(4).
             10 CMonth Pic 9(2).
             10 CDay Pic 9(2).
          05 CurrentTime.
             10 CHour Pic 9(2).
             10 CMinute Pic 9(2).
             10 CSecond Pic 9(2).
             10 CMS Pic 9(2).
       01 blank-line             pic x value spaces.
       01 TestDateVar Pic 9.
       01 MathVar Pic 9(9)V99.
       01 ExtraMath Pic 9(9)V99.
       01 TotalPayroll Pic 9(9)V99.
       01 ControlPayroll Pic 9(9)V99.
       01 DateDone Pic 9.
       01 PageNum Pic 999.
       01 LineNum Pic 99.
          88 NewPage Value 0, 35.
       01 FirstInitial Pic X.
       01 ContDept Pic 9(5).
       01 GrossCalc Pic 9(9)V99.
       01 MarRate Pic V9999 Value .28.
       01 UnMarRate Pic V9999 Value .33.
       01 StateTaxRate Pic V9999 Value .0475.
       01 InsuranceDeduct Pic 9(9)V99.
       01 TaxTable.
          05 TableRow occurs 25 times.
             10 DistrictCode Pic XXX.
             10 DistrictRate Pic V999.
       01 RC Pic 99.
       01 CurrentTax Pic v999.
       01 Indx Pic 99.
       01 Found Pic X.
             
             
             
       Procedure Division.
       000-Main.
           Set RC to 1.
           open Input OtherInput
           perform until Finished
           Read OtherInput
           at end Move 'Y' to EOF
           continue
           not at end
           Move TaxFile to TableRow(RC)
           Add 1 to RC
           end-perform
           close OtherInput
           open output OutFile.
           Move 'N' to EOF
           move Function current-date to DateandTime
           Perform 50-SortInput
           perform 100-ReadFile
           Close OutFile.
           stop run.
           
       50-SortInput.
          Sort TmpSrt
             On Ascending Key SortRegNum SortDeptNum
             Using InputFile
             Giving SortedInput
		  Display "work dammit".

       100-ReadFile.
           Open Input SortedInput.
           Perform until Finished
           read SortedInput
           At end move 'Y' to EOF
           Perform 133-EndControl
           Write ot-record from blank-line
           Move TotalPayroll to TotalOut
           Write ot-record from EndLine
           not at end
           if NewPage
           Perform 150-DisplayHeader
           end-if
           Perform 102-CheckControl
           Perform 130-EachRecord
           Perform 103-CalcDeductions
           Perform 131-WriteRecord
           Perform 125-Clear
           end-read
           end-perform
           close SortedInput.
        
        101-CalculateGross.
           Divide Pay by 12 giving GrossCalc rounded
           If PayCode = "C"
           Multiply Sales by Rate giving MathVar rounded
           Move MathVar to CommissionOut
           Add MathVar to GrossCalc
           end-if
           Move GrossCalc to GrossPayOut.
        
        102-CheckControl.
           if DeptNum <> ContDept
           if LineNum > 33
           Perform 133-EndControl
           Perform 150-DisplayHeader
           else
           Perform 133-EndControl
           if LineNum > 33
           Perform 150-DisplayHeader
           else
           Perform 135-NewControl
           end-if
           end-if
           end-if.

        103-CalcDeductions.
           if 401k is positive
           Multiply 401k by GrossCalc giving ExtraMath rounded
           Subtract ExtraMath from GrossCalc
           Move ExtraMath to 401kOut
           else
           Move "       " to 401kOut
           end-if
           if FedRate
           Multiply GrossCalc by MarRate giving ExtraMath rounded
           else
           Multiply GrossCalc by UnMarRate giving ExtraMath rounded
           end-if
           Subtract ExtraMath from GrossCalc
           Move ExtraMath to FedTax
           Multiply GrossCalc by StateTaxRate giving ExtraMath rounded
           Perform 124-SchoolDeduct
           Subtract ExtraMath from GrossCalc
           Move ExtraMath to StateTax
           if Med = "Y"
           if Dep > 1 
           Add 100 to InsuranceDeduct
           else
           Add 75 to InsuranceDeduct
           end-if
           end-if
           if Den = "Y"
           if Dep > 1
           Add 40 to InsuranceDeduct
           else
           add 25 to InsuranceDeduct
           end-if
           end-if
           if Vis ="Y"
           if Dep > 1
           Add 7.5 to InsuranceDeduct
           else
           add 5 to InsuranceDeduct
           end-if
           end-if
           Move InsuranceDeduct to InsuranceOut
           Subtract InsuranceDeduct from GrossCalc
           Move GrossCalc to NetPay.
           
        124-SchoolDeduct.
           If SchoolDist = "   "
           Move 0.00 to SchoolDeductOut
           else
           Perform Varying Indx from 1 by 1 until Indx = RC
           if SchoolDist = DistrictCode(Indx)
           Move DistrictRate (Indx) to CurrentTax
           Set Found to 'Y'
           end-if
           end-perform
           if Found = 'Y'
           Multiply GrossCalc by CurrentTax giving MathVar rounded
           Move MathVar to SchoolDeductOut
           Subtract MathVar from GrossCalc
           else
           Move "*******" to SchoolDeductOut
           end-if
           end-if
           Move 'N' to Found.
           
        125-Clear.
           Set CommissionOut to "         "
           Set InsuranceDeduct to 0.
          
        130-EachRecord.
           Move EmpNum to EmpNumOut
           Move EmpName to EmpNameOut
           Set EmpNameOut (21:2) to "  "
           Move FirstName to FirstInitial (1:1)
           inspect EmpNameOut replacing first " " by FirstInitial
           after initial " "
           Move MarStat to MarStatOut
           Move Dep to DependNumOut
           Move Insurance to CoverageOut
           Perform 101-CalculateGross.
           
           
        131-WriteRecord.
           Add GrossCalc to ControlPayroll
           write ot-record from RecordOutput
           Add 1 to LineNum.
           
        133-EndControl.
           Move ControlPayroll to PayrollContOut
           Write ot-record from MidLine
           Add ControlPayroll to TotalPayroll
           Set ControlPayroll to 0
           add 1 to LineNum.
            
        135-NewControl.
           if LineNum > 32
           Perform 150-DisplayHeader
           else
           Move DeptNum to DeptNumOutCont1
           Move DeptNum to DeptNumOutCont2
           Move DeptNum to ContDept
           Move DeptName to DeptNameOutCont1
           perform 136-WriteControl
           end-if.
        
        136-WriteControl.
           write ot-record from blank-line
           Write ot-record from ContLine1
           write ot-record from ContLine2
		   write ot-record from blank-line
           Add 3 to LineNum.
           
        150-DisplayHeader.
           move CMonth to PH-Month
           move CDay to PH-Day
           move CYear to PH-Year
           add 1 to PageNum
           move PageNum to PH-PageNo
           if CHour < 12
           Move "AM" to AMPM
           else
           Subtract 12 from CHour 
           Move "PM" to AMPM
           end-if
           Move CHour to HourOut
           Move CMinute to MinOut
           Write ot-record from Page-Header after advancing page
           Write ot-record from HourLine 
           Write ot-record from blank-line
           Write ot-record from Page-Header2
           Set LineNum to 4
           If DeptNum = ContDept
           continue
           else
           Perform 135-NewControl
           end-if.
