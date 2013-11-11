@ECHO OFF

SET PAGES_PATH=..\gh-pages\rollerbot

ECHO Generating images
openscad.exe -o img\part-lowerbody.png -D "part=""lowerbody""" --render RollerBot.scad

ECHO Generating STL files
openscad.exe -o stl\part-lowerbody.stl -D "part=""lowerbody""" --render RollerBot.scad

ECHO Updating Pages
COPY img\part-lowerbody.png %PAGES_PATH%\images\rollerbot.png
COPY stl\part-lowerbody.stl %PAGES_PATH%\stl\rollerbot.stl
