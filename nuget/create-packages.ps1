function Get-ScriptDirectory {
  $Invoc = (Get-Variable MyInvocation -Scope 1).Value
  Split-Path $Invoc.MyCommand.Path 
}

# Hang on to current location
pushd . 

# Move to the Package working directory
$pkgroot = (Get-ScriptDirectory) + "\lib_package"
cd $pkgroot

# Clear out the lib which are the references that will be added.
ls -Filter lib | del -recurse
mkdir lib

# Move the built binaries (release) into their respective convention folders
copy ..\..\bin\WPF\Release .\lib\net40 -Recurse
copy ..\..\bin\Silverlight\Release .\lib\sl4 -Recurse
copy ..\..\bin\WP71\Release .\lib\sl4-windowsphone71 -Recurse
copy ..\..\bin\SL5\Release .\lib\sl5 -Recurse
copy ..\..\bin\WinRT\Release .\lib\winrt45 -Recurse

popd

.\nuget.exe pack .\lib_package\caliburn.micro.nuspec
.\nuget.exe pack .\package\caliburn.micro.start.nuspec
