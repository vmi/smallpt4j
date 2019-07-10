@chcp 65001
@call "%PROGRAMFILES%\Microsoft SDKs\Windows\v7.1\Bin\SetEnv.cmd" /Release /x64 2> NUL
.\mvn.cmd package 2>&1 | .\tee build.log
