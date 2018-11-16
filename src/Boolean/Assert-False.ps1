<#
.SYNOPSIS
Assert actual value is false.
.DESCRIPTION 
Assert actual returned value is false.
.EXAMPLE
$true | Assert-False 
.EXAMPLE
1 + 1 -eq 3 | Assert-False
.EXAMPLE
Assert-False -Actual (1 + 1 -eq 3) -CustomMessage "<actual> does not return a False value."
.PARAMETER Actual
The value to be tested
.PARAMETER CustomMessage
Custom error message.
#>
function Assert-False {
    param (
        [Parameter(ValueFromPipeline=$true)]
        $Actual, 
        [String]$CustomMessage
    )

    $Actual = Collect-Input -ParameterInput $Actual -PipelineInput $local:Input
    if ($Actual) 
    { 
        $Message = Get-AssertionMessage -Expected $false -Actual $Actual -CustomMessage $CustomMessage -DefaultMessage "Expected <actualType> '<actual>' to be <expectedType> '<expected>' or falsy value 0, """", `$null, @()."
        throw [Assertions.AssertionException]$Message
    }

    $Actual
}