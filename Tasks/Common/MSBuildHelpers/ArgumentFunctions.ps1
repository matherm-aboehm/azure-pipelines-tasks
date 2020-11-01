function Format-MSBuildArguments {
    [CmdletBinding()]
    param(
        [string]$MSBuildArguments,
        [string]$Platform,
        [string]$Configuration,
        [string]$VSVersion,
        [string]$VSPath,
        [switch]$MaximumCpuCount)

    Trace-VstsEnteringInvocation $MyInvocation
    try {
        if ($Platform) {
            $MSBuildArguments = "$MSBuildArguments /p:platform=`"$Platform`""
        }

        if ($Configuration) {
            $MSBuildArguments = "$MSBuildArguments /p:configuration=`"$Configuration`""
        }

        if ($VSVersion) {
            $MSBuildArguments = "$MSBuildArguments /p:VisualStudioVersion=`"$VSVersion`""
        }

        if ($VSPath) {
            $DevEnvDir = Join-Path -Path $VSPath -ChildPath "Common7\IDE\\"
            $MSBuildArguments = "$MSBuildArguments /p:DevEnvDir=`"$DevEnvDir`""
        }

        if ($MaximumCpuCount) {
            $MSBuildArguments = "$MSBuildArguments /m"
        }
        
        $userAgent = Get-VstsTaskVariable -Name AZURE_HTTP_USER_AGENT
        if ($userAgent) {
            $MSBuildArguments = "$MSBuildArguments /p:_MSDeployUserAgent=`"$userAgent`""
        }

        $MSBuildArguments
    } finally {
        Trace-VstsLeavingInvocation $MyInvocation
    }
}