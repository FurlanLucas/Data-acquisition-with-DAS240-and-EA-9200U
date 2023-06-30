echo OFF
rem Il va lire le fichier dedans le DAS240 et faire la convertion par txt

rem --------------------------------------------------------------------
echo Telechargement du fichier en cours
start /wait curl -o %2\%1 "http://192.168.137.191/FileSystem/FolderREC/%1"
echo Saving
rem --------------------------------------------------------------------

rem --------------------------------------------------------------------
echo Conversion du fichier en cours
FOR /F "tokens=2* delims=	 " %%A IN ('REG QUERY "HKCR\recordfiles" /v InstallPath') DO SET Rep=%%B
"%Rep%\seframviewer.exe" %2\%1 /t
rem --------------------------------------------------------------------
