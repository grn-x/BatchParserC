@Echo off
setlocal EnableDelayedExpansion
where git >nul 2>nul && (
    echo Git is installed.
) || (
    start cmd.exe /k "color 4f & title Error & Echo. & Echo. & Echo Git is not properly installed! & Echo The installation will be canceled. If this is a mistake, remove the initial check from this batch file. & Echo Press any key to close this dialog & Pause > nul & Exit"
    Echo Git environment variable wasnt found; Pulling will be canceled
    Echo.
    Echo Press any key to exit.
    Pause > nul
    Exit;
)


(
echo gitConfigUser=""
echo gitConfigPassword=""
echo gitConfigURL=""
echo gitConfigPersonalBranch=""
) > config.txt

@(Echo @echo off)>>pull.bat
@(Echo setlocal EnableDelayedExpansion)>>pull.bat
@(Echo. )>>pull.bat
@(Echo set ^"overwriteGitConfigData=false^")>>pull.bat
@(Echo. )>>pull.bat
@(Echo set ^"skipConfig=1^" )>>pull.bat
@(Echo REM 0==dont skip; 1==skip userConfig; ^>1==skip)>>pull.bat
@(Echo. )>>pull.bat
@(Echo. )>>pull.bat
@(Echo where git ^>nul 2^>nul ^&^& ^()>>pull.bat
@(Echo     echo Git is installed.)>>pull.bat
@(Echo ^) ^|^| ^()>>pull.bat
@(Echo     start cmd.exe /k ^"color 4f ^& title Error ^& Echo. ^& Echo. ^& Echo Git is not properly installed^^! ^& Echo The installation will be canceled. If this is a mistake, remove the initial check from this batch file. ^& Echo Press any key to close this dialog ^& Pause ^> nul ^& Exit^")>>pull.bat
@(Echo     Echo Git environment variable wasnt found; Pulling will be canceled)>>pull.bat
@(Echo     Echo.)>>pull.bat
@(Echo     Echo Press any key to exit.)>>pull.bat
@(Echo     Pause ^> nul)>>pull.bat
@(Echo     Exit;)>>pull.bat
@(Echo ^))>>pull.bat
@(Echo Echo.)>>pull.bat
@(Echo Echo Overwrite existing Git Configurations: %%overwriteGitConfigData%%)>>pull.bat
@(Echo Echo.)>>pull.bat
@(Echo. )>>pull.bat
@(Echo if ^"%%skipConfig%%^"==^"0^" ^()>>pull.bat
@(Echo     echo The script will not skip any configuration.)>>pull.bat
@(Echo ^) else if ^"%%skipConfig%%^"==^"1^" ^()>>pull.bat
@(Echo     echo The script will skip the Git User Configuration.)>>pull.bat
@(Echo ^) else ^()>>pull.bat
@(Echo     echo The script will skip the User and URL Configuration.)>>pull.bat
@(Echo ^))>>pull.bat
@(Echo. )>>pull.bat
@(Echo for /f %%%%i in ^('git rev-parse --is-inside-work-tree 2^^^>^^^&1'^) do ^()>>pull.bat
@(Echo     if /I ^"%%%%i^"==^"true^" ^()>>pull.bat
@(Echo         goto success)>>pull.bat
@(Echo     ^) else ^()>>pull.bat
@(Echo         echo Current directory isn't a Git repository^^!)>>pull.bat
@(Echo         echo By continuing, Git will be set up here.)>>pull.bat
@(Echo         set /P ^"input=Press 'y' to continue and configure Git here; 'n' to abort this action: ^")>>pull.bat
@(Echo. )>>pull.bat
@(Echo         REM Check if the length of the input at 4th index is empty ^(3 chars or less^) and if it starts with 'y')>>pull.bat
@(Echo         set ^"choice=^^!input:~0,1^^!^")>>pull.bat
@(Echo         if /I ^"^^!choice^^!^"==^"y^" ^()>>pull.bat
@(Echo             if ^"^^!input:~3^^!^"==^"^" ^()>>pull.bat
@(Echo                 echo Continuing...)>>pull.bat
@(Echo                 echo Setting Git up in the current directory...)>>pull.bat
@(Echo                 git init)>>pull.bat
@(Echo             ^) else ^()>>pull.bat
@(Echo                 goto wrongDirError)>>pull.bat
@(Echo             ^))>>pull.bat
@(Echo         ^) else ^()>>pull.bat
@(Echo             :wrongDirError)>>pull.bat
@(Echo             echo Aborting...)>>pull.bat
@(Echo             echo.)>>pull.bat
@(Echo             echo Press any key to exit.)>>pull.bat
@(Echo             pause ^> nul)>>pull.bat
@(Echo             exit)>>pull.bat
@(Echo         ^))>>pull.bat
@(Echo     ^))>>pull.bat
@(Echo ^))>>pull.bat
@(Echo. )>>pull.bat
@(Echo :success)>>pull.bat
@(Echo Echo.)>>pull.bat
@(Echo Echo.)>>pull.bat
@(Echo. )>>pull.bat
@(Echo. )>>pull.bat
@(Echo set ^"branchToPull=%%~1^")>>pull.bat
@(Echo. )>>pull.bat
@(Echo if ^"%%branchToPull%%^"==^"^" ^()>>pull.bat
@(Echo     echo No branch name input provided. Pulling the ^"main^" branch.)>>pull.bat
@(Echo     set ^"branchToPull=main^")>>pull.bat
@(Echo 	Echo List of remote Branches to pull:)>>pull.bat
@(Echo 	git branch -r)>>pull.bat
@(Echo ^) )>>pull.bat
@(Echo. )>>pull.bat
@(Echo. )>>pull.bat
@(Echo set ^"gitConfigRemoteName=%%~2^")>>pull.bat
@(Echo. )>>pull.bat
@(Echo if ^"%%gitConfigRemoteName%%^"==^"^" ^()>>pull.bat
@(Echo     echo No input remote repo name provided. Setting to default ^"origin^".)>>pull.bat
@(Echo     set ^"gitConfigRemoteName=origin^")>>pull.bat
@(Echo ^))>>pull.bat
@(Echo Echo.)>>pull.bat
@(Echo if not exist ^"config.txt^" ^()>>pull.bat
@(Echo     echo The configuration file config.txt does not exist.)>>pull.bat
@(Echo ^))>>pull.bat
@(Echo. )>>pull.bat
@(Echo. )>>pull.bat
@(Echo. )>>pull.bat
@(Echo set ^"gitConfigUser=^")>>pull.bat
@(Echo set ^"gitConfigPassword=^")>>pull.bat
@(Echo set ^"gitConfigURL=^")>>pull.bat
@(Echo set ^"gitConfigPersonalBranch=^")>>pull.bat
@(Echo. )>>pull.bat
@(Echo rem Read configurations from the config.txt file)>>pull.bat
@(Echo for /F ^"tokens=1,* delims== ^" %%%%G in ^(config.txt^) do ^()>>pull.bat
@(Echo     if ^"%%%%G^"==^"gitConfigUser^" ^()>>pull.bat
@(Echo         set ^"gitConfigUser=%%%%H^")>>pull.bat
@(Echo         if ^"^^!gitConfigUser^^!^"==^"^" set ^"gitConfigUser=^")>>pull.bat
@(Echo     ^))>>pull.bat
@(Echo     if ^"%%%%G^"==^"gitConfigPassword^" ^()>>pull.bat
@(Echo         set ^"gitConfigPassword=%%%%H^")>>pull.bat
@(Echo         if ^"^^!gitConfigPassword^^!^"==^"^" set ^"gitConfigPassword=^")>>pull.bat
@(Echo     ^))>>pull.bat
@(Echo     if ^"%%%%G^"==^"gitConfigURL^" ^()>>pull.bat
@(Echo         set ^"gitConfigURL=%%%%H^")>>pull.bat
@(Echo         if ^"^^!gitConfigURL^^!^"==^"^" set ^"gitConfigURL=^")>>pull.bat
@(Echo     ^))>>pull.bat
@(Echo 	if ^"%%%%G^"==^"gitConfigPersonalBranch^" ^()>>pull.bat
@(Echo         set ^"gitConfigPersonalBranch=%%%%H^")>>pull.bat
@(Echo         if ^"^^!gitConfigPersonalBranch^^!^"==^"^" set ^"gitConfigPersonalBranch=^")>>pull.bat
@(Echo     ^))>>pull.bat
@(Echo ^))>>pull.bat
@(Echo. )>>pull.bat
@(Echo rem Removing quotes from the config values)>>pull.bat
@(Echo set ^"gitConfigUser=^^!gitConfigUser:^"=^^!^")>>pull.bat
@(Echo set ^"gitConfigPassword=^^!gitConfigPassword:^"=^^!^")>>pull.bat
@(Echo set ^"gitConfigURL=^^!gitConfigURL:^"=^^!^")>>pull.bat
@(Echo set ^"gitConfigPersonalBranch=^^!gitConfigPersonalBranch:^"=^^!^")>>pull.bat
@(Echo. )>>pull.bat
@(Echo rem Check if the string is a space character and set it to an empty variable; space is always appended ^>:-^( though git should deal with these strings correctly nevertheless)>>pull.bat
@(Echo if ^"%%gitConfigUser%%^"==^" ^" set ^"gitConfigUser=^")>>pull.bat
@(Echo if ^"%%gitConfigPassword%%^"==^" ^" set ^"gitConfigPassword=^")>>pull.bat
@(Echo if ^"%%gitConfigURL%%^"==^" ^" set ^"gitConfigURL=^")>>pull.bat
@(Echo if ^"%%gitConfigPersonalBranch%%^"==^" ^" set ^"gitConfigPersonalBranch=^")>>pull.bat
@(Echo. )>>pull.bat
@(Echo ::echo Git Config User: %%gitConfigUser%%)>>pull.bat
@(Echo ::echo Git Config Password: %%gitConfigPassword%%)>>pull.bat
@(Echo ::echo Git Config URL: %%gitConfigURL%%)>>pull.bat
@(Echo. )>>pull.bat
@(Echo. )>>pull.bat
@(Echo. )>>pull.bat
@(Echo rem read current/already defined Git Config to see if theyre blank; not using --global flag^^!)>>pull.bat
@(Echo for /F ^"delims=^" %%%%i in ^('git config user.name'^) do set currentGitConfigUser=%%%%i)>>pull.bat
@(Echo for /F ^"delims=^" %%%%i in ^('git config user.password'^) do set currentGitConfigPassword=%%%%i)>>pull.bat
@(Echo for /F ^"delims=^" %%%%i in ^('git config --get remote.%%gitConfigRemoteName%%.url'^) do set currentGitConfigURL=%%%%i)>>pull.bat
@(Echo. )>>pull.bat
@(Echo if ^"^^!currentGitConfigUser^^!^"==^" ^" set ^"currentGitConfigUser=^")>>pull.bat
@(Echo if ^"^^!currentGitConfigPassword^^!^"==^" ^" set ^"currentGitConfigPassword=^")>>pull.bat
@(Echo if ^"^^!currentGitConfigURL^^!^"==^" ^" set ^"currentGitConfigURL=^")>>pull.bat
@(Echo. )>>pull.bat
@(Echo. )>>pull.bat
@(Echo if ^"^^!gitConfigPersonalBranch^^!^" == ^"^" ^()>>pull.bat
@(Echo 		Echo DerMagsNichtWennNichtsDrinnenSteht;Hurensohn ^>nul)>>pull.bat
@(Echo 	^) else if ^"^^!gitConfigPersonalBranch^^!^" == ^" ^" ^()>>pull.bat
@(Echo. )>>pull.bat
@(Echo 			Echo DerMagDasAuchNicht ^>nul)>>pull.bat
@(Echo. )>>pull.bat
@(Echo 	^) else ^()>>pull.bat
@(Echo 		goto personalBranchNotEmpty)>>pull.bat
@(Echo ^))>>pull.bat
@(Echo. )>>pull.bat
@(Echo Echo.)>>pull.bat
@(Echo Echo.)>>pull.bat
@(Echo Echo The Value read from the config.txt corresponding to gitConfigPersonalBranch Key is Empty^^!)>>pull.bat
@(Echo Echo. )>>pull.bat
@(Echo Echo Your Personal Branch Name must be provided.)>>pull.bat
@(Echo Echo.)>>pull.bat
@(Echo echo Press any key to exit.)>>pull.bat
@(Echo pause ^> nul)>>pull.bat
@(Echo exit)>>pull.bat
@(Echo. )>>pull.bat
@(Echo. )>>pull.bat
@(Echo :personalBranchNotEmpty)>>pull.bat
@(Echo. )>>pull.bat
@(Echo. )>>pull.bat
@(Echo REM set TAB=^"^<TAB^>^")>>pull.bat
@(Echo set ^"TAB=   ^")>>pull.bat
@(Echo. )>>pull.bat
@(Echo Echo Current User Name: ^"^^!currentGitConfigUser^^!^" %%TAB%% Read User Name: ^"^^!gitConfigUser^^!^")>>pull.bat
@(Echo Echo Current User PWD: ^"^^!currentGitConfigPassword^^!^" %%TAB%% Read User PWD: ^"^^!gitConfigPassword^^!^")>>pull.bat
@(Echo Echo.)>>pull.bat
@(Echo Echo Pulling from Host with Name: ^"%%gitConfigRemoteName%%^")>>pull.bat
@(Echo Echo Current URL under this Name: ^"^^!currentGitConfigURL^^!^" %%TAB%% Read URL: ^"^^!gitConfigURL^^!^")>>pull.bat
@(Echo Echo From Config Read Branch: ^"^^!gitConfigPersonalBranch^^!^")>>pull.bat
@(Echo. )>>pull.bat
@(Echo. )>>pull.bat
@(Echo. )>>pull.bat
@(Echo. )>>pull.bat
@(Echo. )>>pull.bat
@(Echo. )>>pull.bat
@(Echo. )>>pull.bat
@(Echo if %%skipConfig%%==0 ^()>>pull.bat
@(Echo     REM do nothing)>>pull.bat
@(Echo     goto dontSkip)>>pull.bat
@(Echo ^) else if %%skipConfig%%==1 ^()>>pull.bat
@(Echo     goto skipUserConfig)>>pull.bat
@(Echo ^) else ^()>>pull.bat
@(Echo     goto skipConfig)>>pull.bat
@(Echo ^))>>pull.bat
@(Echo. )>>pull.bat
@(Echo. )>>pull.bat
@(Echo. )>>pull.bat
@(Echo. )>>pull.bat
@(Echo. )>>pull.bat
@(Echo :dontSkip)>>pull.bat
@(Echo. )>>pull.bat
@(Echo. )>>pull.bat
@(Echo Echo.)>>pull.bat
@(Echo Echo.)>>pull.bat
@(Echo. )>>pull.bat
@(Echo if not ^"^^!gitConfigUser^^!^"==^"^" ^()>>pull.bat
@(Echo     if ^"^^!currentGitConfigUser^^!^"==^"^" ^()>>pull.bat
@(Echo         echo Current local Git Username is not set -^> new Name: ^"^^!gitConfigUser^^!^")>>pull.bat
@(Echo         git config user.name ^"^^!gitConfigUser^^!^")>>pull.bat
@(Echo     ^) else ^()>>pull.bat
@(Echo         echo Current local Git Username is already set; if overwriteGitConfigData is true the current Username: ^"^^!currentGitConfigUser^^!^" will be set to ^"^^!gitConfigUser^^!^")>>pull.bat
@(Echo     if ^"^^!overwriteGitConfigData^^!^"==^"true^" ^()>>pull.bat
@(Echo         git config user.name ^"^^!gitConfigUser^^!^"^&Echo Overwriting successful; Username ^"^^!currentGitConfigUser^^!^" changed to ^"^^!gitConfigUser^^!^")>>pull.bat
@(Echo         REM git config --global --replace-all ^"^^!gitConfigUser^^!^")>>pull.bat
@(Echo     ^))>>pull.bat
@(Echo ^))>>pull.bat
@(Echo ^))>>pull.bat
@(Echo. )>>pull.bat
@(Echo Echo.)>>pull.bat
@(Echo Echo.)>>pull.bat
@(Echo. )>>pull.bat
@(Echo if not ^"^^!gitConfigPassword^^!^"==^"^" ^()>>pull.bat
@(Echo     if ^"^^!currentGitConfigPassword^^!^"==^"^" ^()>>pull.bat
@(Echo         echo Current local Git Password is not set -^> new Password: ^"^^!gitConfigPassword^^!^")>>pull.bat
@(Echo         git config user.password ^"^^!gitConfigPassword^^!^")>>pull.bat
@(Echo     ^) else ^()>>pull.bat
@(Echo. )>>pull.bat
@(Echo         echo Current local Git Password is already set; if overwriteGitConfigData is true the current Password: ^"^^!currentGitConfigPassword^^!^" will be set to ^"^^!gitConfigPassword^^!^")>>pull.bat
@(Echo     if ^"^^!overwriteGitConfigData^^!^"==^"true^" ^()>>pull.bat
@(Echo         git config user.password ^"^^!gitConfigPassword^^!^"^&Echo Overwriting successful; Password ^"^^!currentGitConfigPassword^^!^" changed to ^"^^!gitConfigPassword^^!^")>>pull.bat
@(Echo         REM git config --replace-all --global user.password ^"^^!gitConfigPassword^^!^")>>pull.bat
@(Echo     ^))>>pull.bat
@(Echo ^))>>pull.bat
@(Echo ^))>>pull.bat
@(Echo. )>>pull.bat
@(Echo :skipUserConfig)>>pull.bat
@(Echo Echo.)>>pull.bat
@(Echo Echo.)>>pull.bat
@(Echo. )>>pull.bat
@(Echo if not ^"^^!gitConfigURL^^!^"==^"^" ^()>>pull.bat
@(Echo     if ^"^^!currentGitConfigURL^^!^"==^"^" ^()>>pull.bat
@(Echo         echo Current local Git fetch URL is not set -^> new URL: ^"^^!gitConfigURL^^!^")>>pull.bat
@(Echo         git remote add %%gitConfigRemoteName%% ^"^^!gitConfigURL^^!^")>>pull.bat
@(Echo     ^) else ^()>>pull.bat
@(Echo         echo Current local Git fetch URL is already set; if overwriteGitConfigData is true the current URL: ^"^^!currentGitConfigURL^^!^" will be set to ^"^^!gitConfigURL^^!^")>>pull.bat
@(Echo         if ^"^^!overwriteGitConfigData^^!^"==^"true^" ^()>>pull.bat
@(Echo             git remote add ^^!gitConfigRemoteName^^! ^"^^!gitConfigURL^^!^" ^& Echo Overwriting successful; URL ^"^^!currentGitConfigURL^^!^" changed to ^"^^!gitConfigURL^^!^")>>pull.bat
@(Echo         ^))>>pull.bat
@(Echo     ^))>>pull.bat
@(Echo ^) else ^()>>pull.bat
@(Echo     Echo Config.txt URL is empty)>>pull.bat
@(Echo 	if ^"^^!currentGitConfigURL^^!^"==^"^" ^()>>pull.bat
@(Echo 	Echo Current Git remote URL is not set aswell. No valid URL to find. Aborting ...)>>pull.bat
@(Echo 	Pause)>>pull.bat
@(Echo 	Exit)>>pull.bat
@(Echo 	^))>>pull.bat
@(Echo ^))>>pull.bat
@(Echo :skipConfig)>>pull.bat
@(Echo Echo.)>>pull.bat
@(Echo Echo.)>>pull.bat
@(Echo git pull %%gitConfigRemoteName%% %%branchToPull%%)>>pull.bat
@(Echo. )>>pull.bat
@(Echo. )>>pull.bat
@(Echo if not %%errorlevel%% == 0 ^()>>pull.bat
@(Echo Echo. )>>pull.bat
@(Echo Echo.)>>pull.bat
@(Echo Echo.)>>pull.bat
@(Echo Echo Git ran into an Error when pulling.)>>pull.bat
@(Echo Echo Several different issues, such as wrong credentials, a wrong Repo URL or most likely uncommited changes could have lead to this error. )>>pull.bat
@(Echo Echo You can try executing the push script and then reexecuting this script, the output a few lines above should also help.)>>pull.bat
@(Echo Echo.)>>pull.bat
@(Echo Echo Do you want to try to resolve this by resetting your current local repository back to its latest commit?)>>pull.bat
@(Echo Echo.)>>pull.bat
@(Echo Echo.)>>pull.bat
@(Echo set /p inputs=^"Press 'y' to continue and overwrite uncommitted changes; 'n' to abort this action: ^")>>pull.bat
@(Echo set ^"choices=^^!inputs:~0,1^^!^")>>pull.bat
@(Echo if /I ^"^^!choices^^!^"==^"y^" ^()>>pull.bat
@(Echo     if ^"^^!inputs:~3^^!^"==^"^" ^()>>pull.bat
@(Echo         Echo Continuing...)>>pull.bat
@(Echo         Echo Resetting uncommited local changes ...)>>pull.bat
@(Echo. )>>pull.bat
@(Echo         git reset --hard )>>pull.bat
@(Echo. )>>pull.bat
@(Echo 		Echo Retrying now...)>>pull.bat
@(Echo 		goto skipConfig)>>pull.bat
@(Echo. )>>pull.bat
@(Echo     ^) else ^()>>pull.bat
@(Echo         goto invalidNumberLength)>>pull.bat
@(Echo     ^))>>pull.bat
@(Echo ^) else ^()>>pull.bat
@(Echo     :invalidNumberLength)>>pull.bat
@(Echo     Echo Aborting...)>>pull.bat
@(Echo     Echo.)>>pull.bat
@(Echo     Echo Press any key to exit.)>>pull.bat
@(Echo     Pause ^> nul)>>pull.bat
@(Echo     Exit)>>pull.bat
@(Echo ^))>>pull.bat
@(Echo ^))>>pull.bat
@(Echo. )>>pull.bat
@(Echo Echo.)>>pull.bat
@(Echo Echo Now creating/switching to your personal branch)>>pull.bat
@(Echo REM fatal: Needed a single revision?? specify remote name before switching / creating? )>>pull.bat
@(Echo REM ^^!gitConfigRemoteName^^!)>>pull.bat
@(Echo git rev-parse --verify ^^!gitConfigPersonalBranch^^!)>>pull.bat
@(Echo if %%ERRORLEVEL%% NEQ 0 ^()>>pull.bat
@(Echo     REM Branch does not exist, so create and switch to it)>>pull.bat
@(Echo 	REM git branch ^^!^^!)>>pull.bat
@(Echo 	REm git switch ^^!^^!)>>pull.bat
@(Echo     git checkout -b ^^!gitConfigPersonalBranch^^!)>>pull.bat
@(Echo ^) else ^()>>pull.bat
@(Echo     git switch ^^!gitConfigPersonalBranch^^!)>>pull.bat
@(Echo ^))>>pull.bat
@(Echo Echo.)>>pull.bat
@(Echo Echo Branch Overview:)>>pull.bat
@(Echo git branch -a)>>pull.bat
@(Echo. )>>pull.bat
@(Echo. )>>pull.bat
@(Echo endlocal)>>pull.bat


@(Echo @echo off)>>push.bat
@(Echo setlocal EnableDelayedExpansion)>>push.bat
@(Echo. )>>push.bat
@(Echo set ^"overwriteGitConfigData=false^")>>push.bat
@(Echo. )>>push.bat
@(Echo set ^"skipConfig=1^" )>>push.bat
@(Echo REM 0==dont skip; 1==skip userConfig; ^>1==skip)>>push.bat
@(Echo. )>>push.bat
@(Echo. )>>push.bat
@(Echo where git ^>nul 2^>nul ^&^& ^()>>push.bat
@(Echo     echo Git is installed.)>>push.bat
@(Echo ^) ^|^| ^()>>push.bat
@(Echo     start cmd.exe /k ^"color 4f ^& title Error ^& Echo. ^& Echo. ^& Echo Git is not properly installed^^! ^& Echo The installation will be canceled. If this is a mistake, remove the initial check from this batch file. ^& Echo Press any key to close this dialog ^& Pause ^> nul ^& Exit^")>>push.bat
@(Echo     Echo Git environment variable wasnt found; Pulling will be canceled)>>push.bat
@(Echo     Echo.)>>push.bat
@(Echo     Echo Press any key to exit.)>>push.bat
@(Echo     Pause ^> nul)>>push.bat
@(Echo     Exit;)>>push.bat
@(Echo ^))>>push.bat
@(Echo Echo.)>>push.bat
@(Echo Echo Overwrite existing Git Configurations: %%overwriteGitConfigData%%)>>push.bat
@(Echo Echo.)>>push.bat
@(Echo. )>>push.bat
@(Echo if ^"%%skipConfig%%^"==^"0^" ^()>>push.bat
@(Echo     echo The script will not skip any configuration.)>>push.bat
@(Echo ^) else if ^"%%skipConfig%%^"==^"1^" ^()>>push.bat
@(Echo     echo The script will skip the Git User Configuration.)>>push.bat
@(Echo ^) else ^()>>push.bat
@(Echo     echo The script will skip the User and URL Configuration.)>>push.bat
@(Echo ^))>>push.bat
@(Echo. )>>push.bat
@(Echo for /f %%%%i in ^('git rev-parse --is-inside-work-tree 2^^^>^^^&1'^) do ^()>>push.bat
@(Echo     if /I ^"%%%%i^"==^"true^" ^()>>push.bat
@(Echo         goto success)>>push.bat
@(Echo     ^) else ^()>>push.bat
@(Echo 	Echo.)>>push.bat
@(Echo         echo Current directory isn't a Git repository^^!)>>push.bat
@(Echo         echo It cannot be commited and pushed.)>>push.bat
@(Echo         Echo.)>>push.bat
@(Echo             echo Aborting...)>>push.bat
@(Echo             echo.)>>push.bat
@(Echo             echo Press any key to exit.)>>push.bat
@(Echo             pause ^> nul)>>push.bat
@(Echo             exit)>>push.bat
@(Echo     ^))>>push.bat
@(Echo ^))>>push.bat
@(Echo. )>>push.bat
@(Echo :success)>>push.bat
@(Echo. )>>push.bat
@(Echo. )>>push.bat
@(Echo. )>>push.bat
@(Echo set ^"gitConfigUser=^")>>push.bat
@(Echo set ^"gitConfigPassword=^")>>push.bat
@(Echo set ^"gitConfigURL=^")>>push.bat
@(Echo set ^"gitConfigPersonalBranch=^")>>push.bat
@(Echo. )>>push.bat
@(Echo rem Read configurations from the config.txt file)>>push.bat
@(Echo for /F ^"tokens=1,* delims== ^" %%%%G in ^(config.txt^) do ^()>>push.bat
@(Echo     if ^"%%%%G^"==^"gitConfigUser^" ^()>>push.bat
@(Echo         set ^"gitConfigUser=%%%%H^")>>push.bat
@(Echo         if ^"^^!gitConfigUser^^!^"==^"^" set ^"gitConfigUser=^")>>push.bat
@(Echo     ^))>>push.bat
@(Echo     if ^"%%%%G^"==^"gitConfigPassword^" ^()>>push.bat
@(Echo         set ^"gitConfigPassword=%%%%H^")>>push.bat
@(Echo         if ^"^^!gitConfigPassword^^!^"==^"^" set ^"gitConfigPassword=^")>>push.bat
@(Echo     ^))>>push.bat
@(Echo     if ^"%%%%G^"==^"gitConfigURL^" ^()>>push.bat
@(Echo         set ^"gitConfigURL=%%%%H^")>>push.bat
@(Echo         if ^"^^!gitConfigURL^^!^"==^"^" set ^"gitConfigURL=^")>>push.bat
@(Echo     ^))>>push.bat
@(Echo 	if ^"%%%%G^"==^"gitConfigPersonalBranch^" ^()>>push.bat
@(Echo         set ^"gitConfigPersonalBranch=%%%%H^")>>push.bat
@(Echo         if ^"^^!gitConfigPersonalBranch^^!^"==^"^" set ^"gitConfigPersonalBranch=^")>>push.bat
@(Echo     ^))>>push.bat
@(Echo ^))>>push.bat
@(Echo. )>>push.bat
@(Echo rem Removing quotes from the config values)>>push.bat
@(Echo set ^"gitConfigUser=^^!gitConfigUser:^"=^^!^")>>push.bat
@(Echo set ^"gitConfigPassword=^^!gitConfigPassword:^"=^^!^")>>push.bat
@(Echo set ^"gitConfigURL=^^!gitConfigURL:^"=^^!^")>>push.bat
@(Echo set ^"gitConfigPersonalBranch=^^!gitConfigPersonalBranch:^"=^^!^")>>push.bat
@(Echo. )>>push.bat
@(Echo rem Check if the string is a space character and set it to an empty variable; space is always appended ^>:-^( though git should deal with these strings correctly nevertheless)>>push.bat
@(Echo if ^"%%gitConfigUser%%^"==^" ^" set ^"gitConfigUser=^")>>push.bat
@(Echo if ^"%%gitConfigPassword%%^"==^" ^" set ^"gitConfigPassword=^")>>push.bat
@(Echo if ^"%%gitConfigURL%%^"==^" ^" set ^"gitConfigURL=^")>>push.bat
@(Echo if ^"%%gitConfigPersonalBranch%%^"==^" ^" set ^"gitConfigPersonalBranch=^")>>push.bat
@(Echo. )>>push.bat
@(Echo ::echo Git Config User: %%gitConfigUser%%)>>push.bat
@(Echo ::echo Git Config Password: %%gitConfigPassword%%)>>push.bat
@(Echo ::echo Git Config URL: %%gitConfigURL%%)>>push.bat
@(Echo. )>>push.bat
@(Echo Echo.)>>push.bat
@(Echo Echo.)>>push.bat
@(Echo. )>>push.bat
@(Echo. )>>push.bat
@(Echo set ^"branchToPull=%%~1^")>>push.bat
@(Echo. )>>push.bat
@(Echo if ^"%%branchToPull%%^"==^"^" ^()>>push.bat
@(Echo     echo No branch name input provided. Pulling the ^"main^" branch.)>>push.bat
@(Echo     set branchToPull=%%gitConfigPersonalBranch%%)>>push.bat
@(Echo 	Echo List of remote Branches to pull:)>>push.bat
@(Echo 	git branch -r)>>push.bat
@(Echo ^) )>>push.bat
@(Echo Echo %%branchToPull%%)>>push.bat
@(Echo. )>>push.bat
@(Echo set ^"gitConfigRemoteName=%%~2^")>>push.bat
@(Echo. )>>push.bat
@(Echo if ^"%%gitConfigRemoteName%%^"==^"^" ^()>>push.bat
@(Echo     echo No input remote repo name provided. Setting to default ^"origin^".)>>push.bat
@(Echo     set ^"gitConfigRemoteName=origin^")>>push.bat
@(Echo ^))>>push.bat
@(Echo Echo.)>>push.bat
@(Echo if not exist ^"config.txt^" ^()>>push.bat
@(Echo     echo The configuration file config.txt does not exist.)>>push.bat
@(Echo ^))>>push.bat
@(Echo. )>>push.bat
@(Echo. )>>push.bat
@(Echo rem read current/already defined Git Config to see if theyre blank; not using --global flag^^!)>>push.bat
@(Echo for /F ^"delims=^" %%%%i in ^('git config user.name'^) do set currentGitConfigUser=%%%%i)>>push.bat
@(Echo for /F ^"delims=^" %%%%i in ^('git config user.password'^) do set currentGitConfigPassword=%%%%i)>>push.bat
@(Echo for /F ^"delims=^" %%%%i in ^('git config --get remote.%%gitConfigRemoteName%%.url'^) do set currentGitConfigURL=%%%%i)>>push.bat
@(Echo. )>>push.bat
@(Echo if ^"^^!currentGitConfigUser^^!^"==^" ^" set ^"currentGitConfigUser=^")>>push.bat
@(Echo if ^"^^!currentGitConfigPassword^^!^"==^" ^" set ^"currentGitConfigPassword=^")>>push.bat
@(Echo if ^"^^!currentGitConfigURL^^!^"==^" ^" set ^"currentGitConfigURL=^")>>push.bat
@(Echo. )>>push.bat
@(Echo. )>>push.bat
@(Echo if ^"^^!gitConfigPersonalBranch^^!^" == ^"^" ^()>>push.bat
@(Echo 		Echo DerMagsNichtWennNichtsDrinnenSteht;Hurensohn ^>nul)>>push.bat
@(Echo 	^) else if ^"^^!gitConfigPersonalBranch^^!^" == ^" ^" ^()>>push.bat
@(Echo. )>>push.bat
@(Echo 			Echo DerMagDasAuchNicht ^>nul)>>push.bat
@(Echo. )>>push.bat
@(Echo 	^) else ^()>>push.bat
@(Echo 		goto personalBranchNotEmpty)>>push.bat
@(Echo ^))>>push.bat
@(Echo. )>>push.bat
@(Echo Echo.)>>push.bat
@(Echo Echo.)>>push.bat
@(Echo Echo The Value read from the config.txt corresponding to gitConfigPersonalBranch Key is Empty^^!)>>push.bat
@(Echo Echo. )>>push.bat
@(Echo Echo Your Personal Branch Name must be provided.)>>push.bat
@(Echo Echo.)>>push.bat
@(Echo echo Press any key to exit.)>>push.bat
@(Echo pause ^> nul)>>push.bat
@(Echo exit)>>push.bat
@(Echo. )>>push.bat
@(Echo. )>>push.bat
@(Echo :personalBranchNotEmpty)>>push.bat
@(Echo. )>>push.bat
@(Echo. )>>push.bat
@(Echo REM set TAB=^"^<TAB^>^")>>push.bat
@(Echo set ^"TAB=   ^")>>push.bat
@(Echo. )>>push.bat
@(Echo Echo Current User Name: ^"^^!currentGitConfigUser^^!^" %%TAB%% Read User Name: ^"^^!gitConfigUser^^!^")>>push.bat
@(Echo Echo Current User PWD: ^"^^!currentGitConfigPassword^^!^" %%TAB%% Read User PWD: ^"^^!gitConfigPassword^^!^")>>push.bat
@(Echo Echo.)>>push.bat
@(Echo Echo Pushing to Host with Name: ^"%%gitConfigRemoteName%%^")>>push.bat
@(Echo Echo Current URL under this Name: ^"^^!currentGitConfigURL^^!^" %%TAB%% Read URL: ^"^^!gitConfigURL^^!^")>>push.bat
@(Echo Echo From Config Read Branch: ^"^^!gitConfigPersonalBranch^^!^")>>push.bat
@(Echo. )>>push.bat
@(Echo. )>>push.bat
@(Echo. )>>push.bat
@(Echo. )>>push.bat
@(Echo. )>>push.bat
@(Echo. )>>push.bat
@(Echo. )>>push.bat
@(Echo if %%skipConfig%%==0 ^()>>push.bat
@(Echo     REM do nothing)>>push.bat
@(Echo     goto dontSkip)>>push.bat
@(Echo ^) else if %%skipConfig%%==1 ^()>>push.bat
@(Echo     goto skipUserConfig)>>push.bat
@(Echo ^) else ^()>>push.bat
@(Echo     goto skipConfig)>>push.bat
@(Echo ^))>>push.bat
@(Echo. )>>push.bat
@(Echo. )>>push.bat
@(Echo. )>>push.bat
@(Echo. )>>push.bat
@(Echo. )>>push.bat
@(Echo :dontSkip)>>push.bat
@(Echo. )>>push.bat
@(Echo. )>>push.bat
@(Echo Echo.)>>push.bat
@(Echo Echo.)>>push.bat
@(Echo. )>>push.bat
@(Echo if not ^"^^!gitConfigUser^^!^"==^"^" ^()>>push.bat
@(Echo     if ^"^^!currentGitConfigUser^^!^"==^"^" ^()>>push.bat
@(Echo         echo Current local Git Username is not set -^> new Name: ^"^^!gitConfigUser^^!^")>>push.bat
@(Echo         git config user.name ^"^^!gitConfigUser^^!^")>>push.bat
@(Echo     ^) else ^()>>push.bat
@(Echo         echo Current local Git Username is already set; if overwriteGitConfigData is true the current Username: ^"^^!currentGitConfigUser^^!^" will be set to ^"^^!gitConfigUser^^!^")>>push.bat
@(Echo     if ^"^^!overwriteGitConfigData^^!^"==^"true^" ^()>>push.bat
@(Echo         git config user.name ^"^^!gitConfigUser^^!^"^&Echo Overwriting successful; Username ^"^^!currentGitConfigUser^^!^" changed to ^"^^!gitConfigUser^^!^")>>push.bat
@(Echo         REM git config --global --replace-all ^"^^!gitConfigUser^^!^")>>push.bat
@(Echo     ^))>>push.bat
@(Echo ^))>>push.bat
@(Echo ^))>>push.bat
@(Echo. )>>push.bat
@(Echo Echo.)>>push.bat
@(Echo Echo.)>>push.bat
@(Echo. )>>push.bat
@(Echo if not ^"^^!gitConfigPassword^^!^"==^"^" ^()>>push.bat
@(Echo     if ^"^^!currentGitConfigPassword^^!^"==^"^" ^()>>push.bat
@(Echo         echo Current local Git Password is not set -^> new Password: ^"^^!gitConfigPassword^^!^")>>push.bat
@(Echo         git config user.password ^"^^!gitConfigPassword^^!^")>>push.bat
@(Echo     ^) else ^()>>push.bat
@(Echo. )>>push.bat
@(Echo         echo Current local Git Password is already set; if overwriteGitConfigData is true the current Password: ^"^^!currentGitConfigPassword^^!^" will be set to ^"^^!gitConfigPassword^^!^")>>push.bat
@(Echo     if ^"^^!overwriteGitConfigData^^!^"==^"true^" ^()>>push.bat
@(Echo         git config user.password ^"^^!gitConfigPassword^^!^"^&Echo Overwriting successful; Password ^"^^!currentGitConfigPassword^^!^" changed to ^"^^!gitConfigPassword^^!^")>>push.bat
@(Echo         REM git config --replace-all --global user.password ^"^^!gitConfigPassword^^!^")>>push.bat
@(Echo     ^))>>push.bat
@(Echo ^))>>push.bat
@(Echo ^))>>push.bat
@(Echo. )>>push.bat
@(Echo :skipUserConfig)>>push.bat
@(Echo Echo.)>>push.bat
@(Echo Echo.)>>push.bat
@(Echo. )>>push.bat
@(Echo if not ^"^^!gitConfigURL^^!^"==^"^" ^()>>push.bat
@(Echo     if ^"^^!currentGitConfigURL^^!^"==^"^" ^()>>push.bat
@(Echo         echo Current local Git fetch URL is not set -^> new URL: ^"^^!gitConfigURL^^!^")>>push.bat
@(Echo         git remote add %%gitConfigRemoteName%% ^"^^!gitConfigURL^^!^")>>push.bat
@(Echo     ^) else ^()>>push.bat
@(Echo         echo Current local Git fetch URL is already set; if overwriteGitConfigData is true the current URL: ^"^^!currentGitConfigURL^^!^" will be set to ^"^^!gitConfigURL^^!^")>>push.bat
@(Echo         if ^"^^!overwriteGitConfigData^^!^"==^"true^" ^()>>push.bat
@(Echo             git remote add ^^!gitConfigRemoteName^^! ^"^^!gitConfigURL^^!^" ^& Echo Overwriting successful; URL ^"^^!currentGitConfigURL^^!^" changed to ^"^^!gitConfigURL^^!^")>>push.bat
@(Echo         ^))>>push.bat
@(Echo     ^))>>push.bat
@(Echo ^) else ^()>>push.bat
@(Echo     Echo Config.txt URL is empty)>>push.bat
@(Echo 	if ^"^^!currentGitConfigURL^^!^"==^"^" ^()>>push.bat
@(Echo 	Echo Current Git remote URL is not set aswell. No valid URL to find. Aborting ...)>>push.bat
@(Echo 	Pause)>>push.bat
@(Echo 	Exit)>>push.bat
@(Echo 	^))>>push.bat
@(Echo ^))>>push.bat
@(Echo :skipConfig)>>push.bat
@(Echo Echo.)>>push.bat
@(Echo Echo.)>>push.bat
@(Echo git status)>>push.bat
@(Echo Echo.)>>push.bat
@(Echo Echo.)>>push.bat
@(Echo git add .)>>push.bat
@(Echo Echo.)>>push.bat
@(Echo. )>>push.bat
@(Echo 		@^(echo @echo off^)^>^>temp.bat)>>push.bat
@(Echo 		REM @^(echo Echo Enter Git commit Message: ^)^>^>temp.bat)>>push.bat
@(Echo 		@^(echo set /p user_input=Enter Git commit Message: ^)^>^>temp.bat)>>push.bat
@(Echo 		@^(echo echo %%%%user_input%%%% ^^^> tmp.txt^)^>^>temp.bat)>>push.bat
@(Echo 		@^(echo exit^)^>^>temp.bat)>>push.bat
@(Echo 		start /wait cmd /c temp.bat)>>push.bat
@(Echo 		set /p input=^<tmp.txt)>>push.bat
@(Echo 		del /f /q temp.bat)>>push.bat
@(Echo 		del /f /q tmp.txt)>>push.bat
@(Echo 		Echo ^"%%input%%^")>>push.bat
@(Echo. )>>push.bat
@(Echo git commit -m ^"%%input%%^")>>push.bat
@(Echo Echo.)>>push.bat
@(Echo git status )>>push.bat
@(Echo Echo.)>>push.bat
@(Echo Echo.)>>push.bat
@(Echo git push --set-upstream %%gitConfigRemoteName%% %%gitConfigPersonalBranch%%)>>push.bat
@(Echo Echo.)>>push.bat
@(Echo. )>>push.bat
@(Echo. )>>push.bat
@(Echo if not %%errorlevel%% == 0 ^()>>push.bat
@(Echo Echo. )>>push.bat
@(Echo Echo.)>>push.bat
@(Echo Echo.)>>push.bat
@(Echo Echo Git ran into an Error when pulling.)>>push.bat
@(Echo Echo Several different issues, such as wrong credentials, a wrong Repo URL or most likely uncommited changes could have lead to this error. )>>push.bat
@(Echo Echo You can try executing the push script and then reexecuting this script, the output a few lines above should also help.)>>push.bat
@(Echo Echo.)>>push.bat
@(Echo Echo Do you want to try to resolve this by resetting your current local repository back to its latest commit?)>>push.bat
@(Echo Echo.)>>push.bat
@(Echo Echo.)>>push.bat
@(Echo set /p inputs=^"Press 'y' to continue and overwrite uncommitted changes; 'n' to abort this action: ^")>>push.bat
@(Echo set ^"choices=^^!inputs:~0,1^^!^")>>push.bat
@(Echo if /I ^"^^!choices^^!^"==^"y^" ^()>>push.bat
@(Echo     if ^"^^!inputs:~3^^!^"==^"^" ^()>>push.bat
@(Echo         Echo Continuing...)>>push.bat
@(Echo         Echo Resetting uncommited local changes ...)>>push.bat
@(Echo. )>>push.bat
@(Echo         git reset --hard )>>push.bat
@(Echo. )>>push.bat
@(Echo 		Echo Retrying now...)>>push.bat
@(Echo 		goto skipConfig)>>push.bat
@(Echo. )>>push.bat
@(Echo     ^) else ^()>>push.bat
@(Echo         goto invalidNumberLength)>>push.bat
@(Echo     ^))>>push.bat
@(Echo ^) else ^()>>push.bat
@(Echo     :invalidNumberLength)>>push.bat
@(Echo     Echo Aborting...)>>push.bat
@(Echo     Echo.)>>push.bat
@(Echo     Echo Press any key to exit.)>>push.bat
@(Echo     Pause ^> nul)>>push.bat
@(Echo     Exit)>>push.bat
@(Echo ^))>>push.bat
@(Echo ^))>>push.bat
@(Echo. )>>push.bat
@(Echo Echo.)>>push.bat
@(Echo Echo Now creating/switching to your personal branch)>>push.bat
@(Echo REM fatal: Needed a single revision?? specify remote name before switching / creating? )>>push.bat
@(Echo REM ^^!gitConfigRemoteName^^!)>>push.bat
@(Echo git rev-parse --verify ^^!gitConfigPersonalBranch^^!)>>push.bat
@(Echo if %%ERRORLEVEL%% NEQ 0 ^()>>push.bat
@(Echo     REM Branch does not exist, so create and switch to it)>>push.bat
@(Echo 	REM git branch ^^!^^!)>>push.bat
@(Echo 	REm git switch ^^!^^!)>>push.bat
@(Echo     git checkout -b ^^!gitConfigPersonalBranch^^!)>>push.bat
@(Echo ^) else ^()>>push.bat
@(Echo     git switch ^^!gitConfigPersonalBranch^^!)>>push.bat
@(Echo ^))>>push.bat
@(Echo Echo.)>>push.bat
@(Echo Echo Branch Overview:)>>push.bat
@(Echo git branch -a)>>push.bat
@(Echo. )>>push.bat
@(Echo. )>>push.bat
@(Echo endlocal)>>push.bat

@(Echo @echo off)>>updateLocalBranch.bat
@(Echo setlocal EnableDelayedExpansion)>>updateLocalBranch.bat
@(Echo. )>>updateLocalBranch.bat
@(Echo set ^"RebaseOrMerge=1^")>>updateLocalBranch.bat
@(Echo REM 0 == Rebase; ^>0==Merge //Merge is non destructive ^"safer^")>>updateLocalBranch.bat
@(Echo. )>>updateLocalBranch.bat
@(Echo set ^"overwriteGitConfigData=false^")>>updateLocalBranch.bat
@(Echo. )>>updateLocalBranch.bat
@(Echo set ^"skipConfig=1^" )>>updateLocalBranch.bat
@(Echo REM 0==dont skip; 1==skip userConfig; ^>1==skip)>>updateLocalBranch.bat
@(Echo. )>>updateLocalBranch.bat
@(Echo. )>>updateLocalBranch.bat
@(Echo where git ^>nul 2^>nul ^&^& ^()>>updateLocalBranch.bat
@(Echo     echo Git is installed.)>>updateLocalBranch.bat
@(Echo ^) ^|^| ^()>>updateLocalBranch.bat
@(Echo     start cmd.exe /k ^"color 4f ^& title Error ^& Echo. ^& Echo. ^& Echo Git is not properly installed^^! ^& Echo The installation will be canceled. If this is a mistake, remove the initial check from this batch file. ^& Echo Press any key to close this dialog ^& Pause ^> nul ^& Exit^")>>updateLocalBranch.bat
@(Echo     Echo Git environment variable wasnt found; Pulling will be canceled)>>updateLocalBranch.bat
@(Echo     Echo.)>>updateLocalBranch.bat
@(Echo     Echo Press any key to exit.)>>updateLocalBranch.bat
@(Echo     Pause ^> nul)>>updateLocalBranch.bat
@(Echo     Exit;)>>updateLocalBranch.bat
@(Echo ^))>>updateLocalBranch.bat
@(Echo Echo.)>>updateLocalBranch.bat
@(Echo Echo Overwrite existing Git Configurations: %%overwriteGitConfigData%%)>>updateLocalBranch.bat
@(Echo Echo.)>>updateLocalBranch.bat
@(Echo. )>>updateLocalBranch.bat
@(Echo if ^"%%skipConfig%%^"==^"0^" ^()>>updateLocalBranch.bat
@(Echo     echo The script will not skip any configuration.)>>updateLocalBranch.bat
@(Echo ^) else if ^"%%skipConfig%%^"==^"1^" ^()>>updateLocalBranch.bat
@(Echo     echo The script will skip the Git User Configuration.)>>updateLocalBranch.bat
@(Echo ^) else ^()>>updateLocalBranch.bat
@(Echo     echo The script will skip the User and URL Configuration.)>>updateLocalBranch.bat
@(Echo ^))>>updateLocalBranch.bat
@(Echo. )>>updateLocalBranch.bat
@(Echo for /f %%%%i in ^('git rev-parse --is-inside-work-tree 2^^^>^^^&1'^) do ^()>>updateLocalBranch.bat
@(Echo     if /I ^"%%%%i^"==^"true^" ^()>>updateLocalBranch.bat
@(Echo         goto success)>>updateLocalBranch.bat
@(Echo     ^) else ^()>>updateLocalBranch.bat
@(Echo         echo Current directory isn't a Git repository^^!)>>updateLocalBranch.bat
@(Echo         echo It cannot be rebased/updated/merged)>>updateLocalBranch.bat
@(Echo         Echo.)>>updateLocalBranch.bat
@(Echo             echo Aborting...)>>updateLocalBranch.bat
@(Echo             echo.)>>updateLocalBranch.bat
@(Echo             echo Press any key to exit.)>>updateLocalBranch.bat
@(Echo             pause ^> nul)>>updateLocalBranch.bat
@(Echo             exit)>>updateLocalBranch.bat
@(Echo         ^))>>updateLocalBranch.bat
@(Echo     ^))>>updateLocalBranch.bat
@(Echo. )>>updateLocalBranch.bat
@(Echo. )>>updateLocalBranch.bat
@(Echo :success)>>updateLocalBranch.bat
@(Echo Echo.)>>updateLocalBranch.bat
@(Echo Echo.)>>updateLocalBranch.bat
@(Echo. )>>updateLocalBranch.bat
@(Echo. )>>updateLocalBranch.bat
@(Echo set ^"branchToPull=%%~1^")>>updateLocalBranch.bat
@(Echo. )>>updateLocalBranch.bat
@(Echo if ^"%%branchToPull%%^"==^"^" ^()>>updateLocalBranch.bat
@(Echo     echo No branch name input provided. Merging/Rebasing from the ^"main^" branch.)>>updateLocalBranch.bat
@(Echo     set ^"branchToPull=main^")>>updateLocalBranch.bat
@(Echo 	Echo List of remote Branches to Merge/Rebase from:)>>updateLocalBranch.bat
@(Echo 	git branch -r)>>updateLocalBranch.bat
@(Echo ^) )>>updateLocalBranch.bat
@(Echo. )>>updateLocalBranch.bat
@(Echo. )>>updateLocalBranch.bat
@(Echo set ^"gitConfigRemoteName=%%~2^")>>updateLocalBranch.bat
@(Echo. )>>updateLocalBranch.bat
@(Echo if ^"%%gitConfigRemoteName%%^"==^"^" ^()>>updateLocalBranch.bat
@(Echo     echo No input remote repo name provided. Setting to default ^"origin^".)>>updateLocalBranch.bat
@(Echo     set ^"gitConfigRemoteName=origin^")>>updateLocalBranch.bat
@(Echo ^))>>updateLocalBranch.bat
@(Echo Echo.)>>updateLocalBranch.bat
@(Echo if not exist ^"config.txt^" ^()>>updateLocalBranch.bat
@(Echo     echo The configuration file config.txt does not exist.)>>updateLocalBranch.bat
@(Echo ^))>>updateLocalBranch.bat
@(Echo. )>>updateLocalBranch.bat
@(Echo. )>>updateLocalBranch.bat
@(Echo. )>>updateLocalBranch.bat
@(Echo set ^"gitConfigUser=^")>>updateLocalBranch.bat
@(Echo set ^"gitConfigPassword=^")>>updateLocalBranch.bat
@(Echo set ^"gitConfigURL=^")>>updateLocalBranch.bat
@(Echo set ^"gitConfigPersonalBranch=^")>>updateLocalBranch.bat
@(Echo. )>>updateLocalBranch.bat
@(Echo rem Read configurations from the config.txt file)>>updateLocalBranch.bat
@(Echo for /F ^"tokens=1,* delims== ^" %%%%G in ^(config.txt^) do ^()>>updateLocalBranch.bat
@(Echo     if ^"%%%%G^"==^"gitConfigUser^" ^()>>updateLocalBranch.bat
@(Echo         set ^"gitConfigUser=%%%%H^")>>updateLocalBranch.bat
@(Echo         if ^"^^!gitConfigUser^^!^"==^"^" set ^"gitConfigUser=^")>>updateLocalBranch.bat
@(Echo     ^))>>updateLocalBranch.bat
@(Echo     if ^"%%%%G^"==^"gitConfigPassword^" ^()>>updateLocalBranch.bat
@(Echo         set ^"gitConfigPassword=%%%%H^")>>updateLocalBranch.bat
@(Echo         if ^"^^!gitConfigPassword^^!^"==^"^" set ^"gitConfigPassword=^")>>updateLocalBranch.bat
@(Echo     ^))>>updateLocalBranch.bat
@(Echo     if ^"%%%%G^"==^"gitConfigURL^" ^()>>updateLocalBranch.bat
@(Echo         set ^"gitConfigURL=%%%%H^")>>updateLocalBranch.bat
@(Echo         if ^"^^!gitConfigURL^^!^"==^"^" set ^"gitConfigURL=^")>>updateLocalBranch.bat
@(Echo     ^))>>updateLocalBranch.bat
@(Echo 	if ^"%%%%G^"==^"gitConfigPersonalBranch^" ^()>>updateLocalBranch.bat
@(Echo         set ^"gitConfigPersonalBranch=%%%%H^")>>updateLocalBranch.bat
@(Echo         if ^"^^!gitConfigPersonalBranch^^!^"==^"^" set ^"gitConfigPersonalBranch=^")>>updateLocalBranch.bat
@(Echo     ^))>>updateLocalBranch.bat
@(Echo ^))>>updateLocalBranch.bat
@(Echo. )>>updateLocalBranch.bat
@(Echo rem Removing quotes from the config values)>>updateLocalBranch.bat
@(Echo set ^"gitConfigUser=^^!gitConfigUser:^"=^^!^")>>updateLocalBranch.bat
@(Echo set ^"gitConfigPassword=^^!gitConfigPassword:^"=^^!^")>>updateLocalBranch.bat
@(Echo set ^"gitConfigURL=^^!gitConfigURL:^"=^^!^")>>updateLocalBranch.bat
@(Echo set ^"gitConfigPersonalBranch=^^!gitConfigPersonalBranch:^"=^^!^")>>updateLocalBranch.bat
@(Echo. )>>updateLocalBranch.bat
@(Echo rem Check if the string is a space character and set it to an empty variable; space is always appended ^>:-^( though git should deal with these strings correctly nevertheless)>>updateLocalBranch.bat
@(Echo if ^"%%gitConfigUser%%^"==^" ^" set ^"gitConfigUser=^")>>updateLocalBranch.bat
@(Echo if ^"%%gitConfigPassword%%^"==^" ^" set ^"gitConfigPassword=^")>>updateLocalBranch.bat
@(Echo if ^"%%gitConfigURL%%^"==^" ^" set ^"gitConfigURL=^")>>updateLocalBranch.bat
@(Echo if ^"%%gitConfigPersonalBranch%%^"==^" ^" set ^"gitConfigPersonalBranch=^")>>updateLocalBranch.bat
@(Echo. )>>updateLocalBranch.bat
@(Echo ::echo Git Config User: %%gitConfigUser%%)>>updateLocalBranch.bat
@(Echo ::echo Git Config Password: %%gitConfigPassword%%)>>updateLocalBranch.bat
@(Echo ::echo Git Config URL: %%gitConfigURL%%)>>updateLocalBranch.bat
@(Echo. )>>updateLocalBranch.bat
@(Echo. )>>updateLocalBranch.bat
@(Echo. )>>updateLocalBranch.bat
@(Echo rem read current/already defined Git Config to see if theyre blank; not using --global flag^^!)>>updateLocalBranch.bat
@(Echo for /F ^"delims=^" %%%%i in ^('git config user.name'^) do set currentGitConfigUser=%%%%i)>>updateLocalBranch.bat
@(Echo for /F ^"delims=^" %%%%i in ^('git config user.password'^) do set currentGitConfigPassword=%%%%i)>>updateLocalBranch.bat
@(Echo for /F ^"delims=^" %%%%i in ^('git config --get remote.%%gitConfigRemoteName%%.url'^) do set currentGitConfigURL=%%%%i)>>updateLocalBranch.bat
@(Echo. )>>updateLocalBranch.bat
@(Echo if ^"^^!currentGitConfigUser^^!^"==^" ^" set ^"currentGitConfigUser=^")>>updateLocalBranch.bat
@(Echo if ^"^^!currentGitConfigPassword^^!^"==^" ^" set ^"currentGitConfigPassword=^")>>updateLocalBranch.bat
@(Echo if ^"^^!currentGitConfigURL^^!^"==^" ^" set ^"currentGitConfigURL=^")>>updateLocalBranch.bat
@(Echo. )>>updateLocalBranch.bat
@(Echo. )>>updateLocalBranch.bat
@(Echo if ^"^^!gitConfigPersonalBranch^^!^" == ^"^" ^()>>updateLocalBranch.bat
@(Echo 		Echo DerMagsNichtWennNichtsDrinnenSteht;Hurensohn ^>nul)>>updateLocalBranch.bat
@(Echo 	^) else if ^"^^!gitConfigPersonalBranch^^!^" == ^" ^" ^()>>updateLocalBranch.bat
@(Echo. )>>updateLocalBranch.bat
@(Echo 			Echo DerMagDasAuchNicht ^>nul)>>updateLocalBranch.bat
@(Echo. )>>updateLocalBranch.bat
@(Echo 	^) else ^()>>updateLocalBranch.bat
@(Echo 		goto personalBranchNotEmpty)>>updateLocalBranch.bat
@(Echo ^))>>updateLocalBranch.bat
@(Echo. )>>updateLocalBranch.bat
@(Echo Echo.)>>updateLocalBranch.bat
@(Echo Echo.)>>updateLocalBranch.bat
@(Echo Echo The Value read from the config.txt corresponding to gitConfigPersonalBranch Key is Empty^^!)>>updateLocalBranch.bat
@(Echo Echo. )>>updateLocalBranch.bat
@(Echo Echo Your Personal Branch Name must be provided.)>>updateLocalBranch.bat
@(Echo Echo.)>>updateLocalBranch.bat
@(Echo echo Press any key to exit.)>>updateLocalBranch.bat
@(Echo pause ^> nul)>>updateLocalBranch.bat
@(Echo exit)>>updateLocalBranch.bat
@(Echo. )>>updateLocalBranch.bat
@(Echo. )>>updateLocalBranch.bat
@(Echo :personalBranchNotEmpty)>>updateLocalBranch.bat
@(Echo. )>>updateLocalBranch.bat
@(Echo. )>>updateLocalBranch.bat
@(Echo REM set TAB=^"^<TAB^>^")>>updateLocalBranch.bat
@(Echo set ^"TAB=   ^")>>updateLocalBranch.bat
@(Echo. )>>updateLocalBranch.bat
@(Echo Echo Current User Name: ^"^^!currentGitConfigUser^^!^" %%TAB%% Read User Name: ^"^^!gitConfigUser^^!^")>>updateLocalBranch.bat
@(Echo Echo Current User PWD: ^"^^!currentGitConfigPassword^^!^" %%TAB%% Read User PWD: ^"^^!gitConfigPassword^^!^")>>updateLocalBranch.bat
@(Echo Echo.)>>updateLocalBranch.bat
@(Echo Echo Under Host with Name: ^"%%gitConfigRemoteName%%^")>>updateLocalBranch.bat
@(Echo Echo Current URL under this Name: ^"^^!currentGitConfigURL^^!^" %%TAB%% Read URL: ^"^^!gitConfigURL^^!^")>>updateLocalBranch.bat
@(Echo Echo From Config Read Branch: ^"^^!gitConfigPersonalBranch^^!^")>>updateLocalBranch.bat
@(Echo. )>>updateLocalBranch.bat
@(Echo. )>>updateLocalBranch.bat
@(Echo. )>>updateLocalBranch.bat
@(Echo. )>>updateLocalBranch.bat
@(Echo. )>>updateLocalBranch.bat
@(Echo. )>>updateLocalBranch.bat
@(Echo. )>>updateLocalBranch.bat
@(Echo if %%skipConfig%%==0 ^()>>updateLocalBranch.bat
@(Echo     REM do nothing)>>updateLocalBranch.bat
@(Echo     goto dontSkip)>>updateLocalBranch.bat
@(Echo ^) else if %%skipConfig%%==1 ^()>>updateLocalBranch.bat
@(Echo     goto skipUserConfig)>>updateLocalBranch.bat
@(Echo ^) else ^()>>updateLocalBranch.bat
@(Echo     goto skipConfig)>>updateLocalBranch.bat
@(Echo ^))>>updateLocalBranch.bat
@(Echo. )>>updateLocalBranch.bat
@(Echo. )>>updateLocalBranch.bat
@(Echo. )>>updateLocalBranch.bat
@(Echo. )>>updateLocalBranch.bat
@(Echo. )>>updateLocalBranch.bat
@(Echo :dontSkip)>>updateLocalBranch.bat
@(Echo. )>>updateLocalBranch.bat
@(Echo. )>>updateLocalBranch.bat
@(Echo Echo.)>>updateLocalBranch.bat
@(Echo Echo.)>>updateLocalBranch.bat
@(Echo. )>>updateLocalBranch.bat
@(Echo if not ^"^^!gitConfigUser^^!^"==^"^" ^()>>updateLocalBranch.bat
@(Echo     if ^"^^!currentGitConfigUser^^!^"==^"^" ^()>>updateLocalBranch.bat
@(Echo         echo Current local Git Username is not set -^> new Name: ^"^^!gitConfigUser^^!^")>>updateLocalBranch.bat
@(Echo         git config user.name ^"^^!gitConfigUser^^!^")>>updateLocalBranch.bat
@(Echo     ^) else ^()>>updateLocalBranch.bat
@(Echo         echo Current local Git Username is already set; if overwriteGitConfigData is true the current Username: ^"^^!currentGitConfigUser^^!^" will be set to ^"^^!gitConfigUser^^!^")>>updateLocalBranch.bat
@(Echo     if ^"^^!overwriteGitConfigData^^!^"==^"true^" ^()>>updateLocalBranch.bat
@(Echo         git config user.name ^"^^!gitConfigUser^^!^"^&Echo Overwriting successful; Username ^"^^!currentGitConfigUser^^!^" changed to ^"^^!gitConfigUser^^!^")>>updateLocalBranch.bat
@(Echo         REM git config --global --replace-all ^"^^!gitConfigUser^^!^")>>updateLocalBranch.bat
@(Echo     ^))>>updateLocalBranch.bat
@(Echo ^))>>updateLocalBranch.bat
@(Echo ^))>>updateLocalBranch.bat
@(Echo. )>>updateLocalBranch.bat
@(Echo Echo.)>>updateLocalBranch.bat
@(Echo Echo.)>>updateLocalBranch.bat
@(Echo. )>>updateLocalBranch.bat
@(Echo if not ^"^^!gitConfigPassword^^!^"==^"^" ^()>>updateLocalBranch.bat
@(Echo     if ^"^^!currentGitConfigPassword^^!^"==^"^" ^()>>updateLocalBranch.bat
@(Echo         echo Current local Git Password is not set -^> new Password: ^"^^!gitConfigPassword^^!^")>>updateLocalBranch.bat
@(Echo         git config user.password ^"^^!gitConfigPassword^^!^")>>updateLocalBranch.bat
@(Echo     ^) else ^()>>updateLocalBranch.bat
@(Echo. )>>updateLocalBranch.bat
@(Echo         echo Current local Git Password is already set; if overwriteGitConfigData is true the current Password: ^"^^!currentGitConfigPassword^^!^" will be set to ^"^^!gitConfigPassword^^!^")>>updateLocalBranch.bat
@(Echo     if ^"^^!overwriteGitConfigData^^!^"==^"true^" ^()>>updateLocalBranch.bat
@(Echo         git config user.password ^"^^!gitConfigPassword^^!^"^&Echo Overwriting successful; Password ^"^^!currentGitConfigPassword^^!^" changed to ^"^^!gitConfigPassword^^!^")>>updateLocalBranch.bat
@(Echo         REM git config --replace-all --global user.password ^"^^!gitConfigPassword^^!^")>>updateLocalBranch.bat
@(Echo     ^))>>updateLocalBranch.bat
@(Echo ^))>>updateLocalBranch.bat
@(Echo ^))>>updateLocalBranch.bat
@(Echo. )>>updateLocalBranch.bat
@(Echo :skipUserConfig)>>updateLocalBranch.bat
@(Echo Echo.)>>updateLocalBranch.bat
@(Echo Echo.)>>updateLocalBranch.bat
@(Echo. )>>updateLocalBranch.bat
@(Echo if not ^"^^!gitConfigURL^^!^"==^"^" ^()>>updateLocalBranch.bat
@(Echo     if ^"^^!currentGitConfigURL^^!^"==^"^" ^()>>updateLocalBranch.bat
@(Echo         echo Current local Git fetch URL is not set -^> new URL: ^"^^!gitConfigURL^^!^")>>updateLocalBranch.bat
@(Echo         git remote add %%gitConfigRemoteName%% ^"^^!gitConfigURL^^!^")>>updateLocalBranch.bat
@(Echo     ^) else ^()>>updateLocalBranch.bat
@(Echo         echo Current local Git fetch URL is already set; if overwriteGitConfigData is true the current URL: ^"^^!currentGitConfigURL^^!^" will be set to ^"^^!gitConfigURL^^!^")>>updateLocalBranch.bat
@(Echo         if ^"^^!overwriteGitConfigData^^!^"==^"true^" ^()>>updateLocalBranch.bat
@(Echo             git remote add ^^!gitConfigRemoteName^^! ^"^^!gitConfigURL^^!^" ^& Echo Overwriting successful; URL ^"^^!currentGitConfigURL^^!^" changed to ^"^^!gitConfigURL^^!^")>>updateLocalBranch.bat
@(Echo         ^))>>updateLocalBranch.bat
@(Echo     ^))>>updateLocalBranch.bat
@(Echo ^) else ^()>>updateLocalBranch.bat
@(Echo     Echo Config.txt URL is empty)>>updateLocalBranch.bat
@(Echo 	if ^"^^!currentGitConfigURL^^!^"==^"^" ^()>>updateLocalBranch.bat
@(Echo 	Echo Current Git remote URL is not set aswell. No valid URL to find. Aborting ...)>>updateLocalBranch.bat
@(Echo 	Pause)>>updateLocalBranch.bat
@(Echo 	Exit)>>updateLocalBranch.bat
@(Echo 	^))>>updateLocalBranch.bat
@(Echo ^))>>updateLocalBranch.bat
@(Echo :skipConfig)>>updateLocalBranch.bat
@(Echo Echo.)>>updateLocalBranch.bat
@(Echo Echo.)>>updateLocalBranch.bat
@(Echo Echo ^"%%RebaseOrMerge%%^")>>updateLocalBranch.bat
@(Echo if %%RebaseOrMerge%% == 0 ^()>>updateLocalBranch.bat
@(Echo 			Echo goto rebase)>>updateLocalBranch.bat
@(Echo 		goto rebase)>>updateLocalBranch.bat
@(Echo 	^) else ^()>>updateLocalBranch.bat
@(Echo 		goto merge)>>updateLocalBranch.bat
@(Echo 			Echo goto merge)>>updateLocalBranch.bat
@(Echo 	^))>>updateLocalBranch.bat
@(Echo. )>>updateLocalBranch.bat
@(Echo. )>>updateLocalBranch.bat
@(Echo :rebase)>>updateLocalBranch.bat
@(Echo Echo Attempting Rebase...)>>updateLocalBranch.bat
@(Echo Echo Switching to Branch to rebase)>>updateLocalBranch.bat
@(Echo Echo.)>>updateLocalBranch.bat
@(Echo git switch ^^!gitConfigPersonalBranch^^!)>>updateLocalBranch.bat
@(Echo Echo.)>>updateLocalBranch.bat
@(Echo git rebase ^^!branchToPull^^!)>>updateLocalBranch.bat
@(Echo. )>>updateLocalBranch.bat
@(Echo. )>>updateLocalBranch.bat
@(Echo if not %%errorlevel%% == 0 ^()>>updateLocalBranch.bat
@(Echo Echo. )>>updateLocalBranch.bat
@(Echo Echo.)>>updateLocalBranch.bat
@(Echo Echo.)>>updateLocalBranch.bat
@(Echo Echo Git ran into an Error when Rebasing.)>>updateLocalBranch.bat
@(Echo Echo.)>>updateLocalBranch.bat
@(Echo Echo Retry or abort this action?)>>updateLocalBranch.bat
@(Echo Echo.)>>updateLocalBranch.bat
@(Echo Echo.)>>updateLocalBranch.bat
@(Echo set /p inputs=^"Press 'y' to try again; 'n' to abort and exit: ^")>>updateLocalBranch.bat
@(Echo set ^"choices=^^!inputs:~0,1^^!^")>>updateLocalBranch.bat
@(Echo if /I ^"^^!choices^^!^"==^"y^" ^()>>updateLocalBranch.bat
@(Echo     if ^"^^!inputs:~3^^!^"==^"^" ^()>>updateLocalBranch.bat
@(Echo 		Echo.)>>updateLocalBranch.bat
@(Echo         Echo Retrying...)>>updateLocalBranch.bat
@(Echo 		Echo.)>>updateLocalBranch.bat
@(Echo. )>>updateLocalBranch.bat
@(Echo 		goto rebase)>>updateLocalBranch.bat
@(Echo. )>>updateLocalBranch.bat
@(Echo     ^) else ^()>>updateLocalBranch.bat
@(Echo         goto invalidNumberLength)>>updateLocalBranch.bat
@(Echo     ^))>>updateLocalBranch.bat
@(Echo ^) else ^()>>updateLocalBranch.bat
@(Echo     :invalidNumberLength)>>updateLocalBranch.bat
@(Echo     Echo Aborting...)>>updateLocalBranch.bat
@(Echo     Echo.)>>updateLocalBranch.bat
@(Echo     Echo Press any key to exit.)>>updateLocalBranch.bat
@(Echo     Pause ^> nul)>>updateLocalBranch.bat
@(Echo     Exit)>>updateLocalBranch.bat
@(Echo ^))>>updateLocalBranch.bat
@(Echo ^))>>updateLocalBranch.bat
@(Echo. )>>updateLocalBranch.bat
@(Echo Exit)>>updateLocalBranch.bat
@(Echo. )>>updateLocalBranch.bat
@(Echo. )>>updateLocalBranch.bat
@(Echo. )>>updateLocalBranch.bat
@(Echo. )>>updateLocalBranch.bat
@(Echo :merge)>>updateLocalBranch.bat
@(Echo. )>>updateLocalBranch.bat
@(Echo. )>>updateLocalBranch.bat
@(Echo Echo Attempting Merge...)>>updateLocalBranch.bat
@(Echo Echo Switching to Main Branch to fetch and merge)>>updateLocalBranch.bat
@(Echo REM ich glaube der switch zum main ist unnötig)>>updateLocalBranch.bat
@(Echo Echo.)>>updateLocalBranch.bat
@(Echo git switch %%branchToPull%%)>>updateLocalBranch.bat
@(Echo Echo.)>>updateLocalBranch.bat
@(Echo git pull %%gitConfigRemoteName%% %%branchToPull%%)>>updateLocalBranch.bat
@(Echo Echo.)>>updateLocalBranch.bat
@(Echo Echo Switching back to Personal Branch and merging latest Commit of Main Branch into Personal branch)>>updateLocalBranch.bat
@(Echo Echo.)>>updateLocalBranch.bat
@(Echo git switch %%gitConfigPersonalBranch%%)>>updateLocalBranch.bat
@(Echo Echo.)>>updateLocalBranch.bat
@(Echo git rebase %%branchToPull%%)>>updateLocalBranch.bat
@(Echo. )>>updateLocalBranch.bat
@(Echo. )>>updateLocalBranch.bat
@(Echo if not %%errorlevel%% == 0 ^()>>updateLocalBranch.bat
@(Echo Echo. )>>updateLocalBranch.bat
@(Echo Echo.)>>updateLocalBranch.bat
@(Echo Echo.)>>updateLocalBranch.bat
@(Echo Echo Git ran into an Error when Rebasing.)>>updateLocalBranch.bat
@(Echo Echo.)>>updateLocalBranch.bat
@(Echo Echo Retry or abort this action?)>>updateLocalBranch.bat
@(Echo Echo.)>>updateLocalBranch.bat
@(Echo Echo.)>>updateLocalBranch.bat
@(Echo set /p inputs=^"Press 'y' to try again; 'n' to abort and exit: ^")>>updateLocalBranch.bat
@(Echo set ^"choices=^^!inputs:~0,1^^!^")>>updateLocalBranch.bat
@(Echo if /I ^"^^!choices^^!^"==^"y^" ^()>>updateLocalBranch.bat
@(Echo     if ^"^^!inputs:~3^^!^"==^"^" ^()>>updateLocalBranch.bat
@(Echo 		Echo.)>>updateLocalBranch.bat
@(Echo         Echo Retrying...)>>updateLocalBranch.bat
@(Echo 		Echo.)>>updateLocalBranch.bat
@(Echo. )>>updateLocalBranch.bat
@(Echo 		goto merge)>>updateLocalBranch.bat
@(Echo. )>>updateLocalBranch.bat
@(Echo     ^) else ^()>>updateLocalBranch.bat
@(Echo         goto invalidNumberLength)>>updateLocalBranch.bat
@(Echo     ^))>>updateLocalBranch.bat
@(Echo ^) else ^()>>updateLocalBranch.bat
@(Echo     :invalidNumberLength)>>updateLocalBranch.bat
@(Echo     Echo Aborting...)>>updateLocalBranch.bat
@(Echo     Echo.)>>updateLocalBranch.bat
@(Echo     Echo Press any key to exit.)>>updateLocalBranch.bat
@(Echo     Pause ^> nul)>>updateLocalBranch.bat
@(Echo     Exit)>>updateLocalBranch.bat
@(Echo ^))>>updateLocalBranch.bat
@(Echo ^))>>updateLocalBranch.bat
@(Echo. )>>updateLocalBranch.bat
@(Echo Exit )>>updateLocalBranch.bat
@(Echo. )>>updateLocalBranch.bat
@(Echo endlocal)>>updateLocalBranch.bat

@(Echo @Echo off)>>pullPersonalBranch.bat
@(Echo setlocal EnableDelayedExpansion)>>pullPersonalBranch.bat
@(Echo set ^"gitConfigPersonalBranch=^")>>pullPersonalBranch.bat
@(Echo. )>>pullPersonalBranch.bat
@(Echo. )>>pullPersonalBranch.bat
@(Echo for /F ^"tokens=1,* delims== ^" %%%%G in ^(config.txt^) do ^()>>pullPersonalBranch.bat
@(Echo if ^"%%%%G^"==^"gitConfigPersonalBranch^" ^()>>pullPersonalBranch.bat
@(Echo         set ^"gitConfigPersonalBranch=%%%%H^")>>pullPersonalBranch.bat
@(Echo         if ^"^^!gitConfigPersonalBranch^^!^"==^"^" set ^"gitConfigPersonalBranch=^")>>pullPersonalBranch.bat
@(Echo     ^))>>pullPersonalBranch.bat
@(Echo ^))>>pullPersonalBranch.bat
@(Echo set ^"gitConfigPersonalBranch=^^!gitConfigPersonalBranch:^"=^^!^")>>pullPersonalBranch.bat
@(Echo. )>>pullPersonalBranch.bat
@(Echo pull.bat ^^!gitConfigPersonalBranch^^!)>>pullPersonalBranch.bat
@(Echo endlocal)>>pullPersonalBranch.bat

set /P "input=Press 'y' to continue and configure Git here; 'n' to abort this action: "
        
set "choice=!input:~0,1!"
        if /I "!choice!"=="y" (
            if "!input:~3!"=="" (
                git init
            ) else (
                goto skipGit
            )
        ) else (
            goto skipGit
        )

:skipGit

Echo Environment Setup completed. You can delete this setup File now
set /p inputs="Press 'y' to delete and exit; 'n' to exit: "
set "choices=!inputs:~0,1!"
if /I "!choices!"=="y" (
    if "!inputs:~3!"=="" (
	Echo selfdelete
        del "%~f0"
        
    ) else (
	exit
    )
) else (
 Exit
)
)
endlocal
