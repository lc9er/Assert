<#
.SYNOPSIS
Assert the actual value is not of the expected type.
.DESCRIPTION
Assert the actual value is not of the expected type. Supports type accelerators. 
.EXAMPLE 
Assert-Type -Actual "MyString" -Expected Hashtable
.PARAMETER Actual
The value to be tested.
.PARAMETER Expected
The type to test the actual type against.
.PARAMETER CustomMessage
Define a custom error message.
#>
function Assert-NotType {
    param (
        [Parameter(Position=1, ValueFromPipeline=$true)]
        $Actual, 
        [Parameter(Position=0)]
        [Type]$Expected,
        [String]$CustomMessage
    )

    $Actual = Collect-Input -ParameterInput $Actual -PipelineInput $local:Input
    if ($Actual -is $Expected) 
    { 
        $type = [string]$Expected
        $Message = Get-AssertionMessage -Expected $Expected -Actual $Actual -CustomMessage $CustomMessage -DefaultMessage "Expected value to be of different type than '$type', but got '<actual>' of type '<actualType>'."
        throw [Assertions.AssertionException]$Message
    }

    $Actual
}