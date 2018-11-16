
<#
.SYNOPSIS
Assert actual value is greater than or equal to expected value.
.DESCRIPTION
Will compare numbers or strings.
.PARAMETER Actual
The value to compare.
.PARAMETER Expected
The value to compare the actual value against.
.EXAMPLE
100 | Assert-GreaterThanOrEqual 99
.EXAMPLE
Assert-GreaterThanOrEqual -Actual 5000 -Expected 4000 
#>
function Assert-LessThan {
    param (
        [Parameter(Position=1, ValueFromPipeline=$true)]
        $Actual, 
        [Parameter(Position=0)]
        $Expected,
        [String]$CustomMessage
    )

    $Actual = Collect-Input -ParameterInput $Actual -PipelineInput $local:Input
    if ((Ensure-ExpectedIsNotCollection $Expected) -le $Actual) 
    { 
        $Message = Get-AssertionMessage -Expected $Expected -Actual $Actual -CustomMessage $CustomMessage -DefaultMessage "Expected <actualType> '<actual>' to be less than <expectedType> '<expected>', but it was not."
        throw [Assertions.AssertionException]$Message
    }

    $Actual
}