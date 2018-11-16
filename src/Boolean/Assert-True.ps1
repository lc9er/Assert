<#
.SYNOPSIS
Assert actual value is true.
.DESCRIPTION 
Assert actual returned value is true or a truthy. 
.EXAMPLE
$true | Assert-True 
.EXAMPLE
1 + 1 -eq 2 | Assert-True
.EXAMPLE
Assert-True -Actual (1 + 1 -eq 3) -CustomMessage "<actual> does not return a true value."
.PARAMETER Actual
The value to be tested.
.PARAMETER CustomMessage
Custom error message.
#>
function Assert-True{
    param (
        [Parameter(ValueFromPipeline=$true)]
        $Actual, 
        [String]$CustomMessage
    )

    $Actual = Collect-Input -ParameterInput $Actual -PipelineInput $local:Input
    if (-not $Actual) 
    { 
        $Message = Get-AssertionMessage -Expected $true -Actual $Actual -CustomMessage $CustomMessage -DefaultMessage "Expected <actualType> '<actual>' to be <expectedType> '<expected>' or truthy value."
        throw [Assertions.AssertionException]$Message
    }

    $Actual
}