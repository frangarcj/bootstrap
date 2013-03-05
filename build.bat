@echo off
set "BOOTSTRAP=.\docs\assets\css\bootstrap.css"
set "BOOTSTRAP_LESS=.\less\bootstrap-ual.less"
set "BOOTSTRAP_RESPONSIVE=.\docs\assets\css\bootstrap-responsive.css"
set "BOOTSTRAP_RESPONSIVE_LESS=.\less\responsive.less"
set NL=^^^%NLM%%NLM%^%NLM%%NLM%

echo Building Bootstrap...
echo %NL%
call recess --compile %BOOTSTRAP_LESS% > %BOOTSTRAP%
call recess --compile %BOOTSTRAP_RESPONSIVE_LESS% > %BOOTSTRAP_RESPONSIVE%
echo "Compiling LESS with Recess...               Done"
call node docs\build
copy img\* docs\assets\img\
copy js\*.js docs\assets\js\
copy js\tests\vendor\jquery.js docs\assets\js\
echo "Compiling documentation...                  Done"
copy /B js\bootstrap-transition.js+js\bootstrap-alert.js+js\bootstrap-button.js+js\bootstrap-carousel.js+js\bootstrap-collapse.js+js\bootstrap-dropdown.js+js\bootstrap-modal.js+js\bootstrap-tooltip.js+js\bootstrap-popover.js+js\bootstrap-scrollspy.js+js\bootstrap-tab.js+js\bootstrap-typeahead.js+js\bootstrap-affix.js docs\assets\js\bootstrap.js
call uglifyjs -nc docs\assets\js\bootstrap.js > docs\assets\js\bootstrap.min.tmp.js

setlocal EnableDelayedExpansion
set "COPYRIGHT1=/**"
set "COPYRIGHT2=* Bootstrap.js by @fat & @mdo"
set "COPYRIGHT3=* Copyright 2012 Twitter, Inc."
set "COPYRIGHT4=* http://www.apache.org/licenses/LICENSE-2.0.txt"
set "COPYRIGHT5=*/"
echo !COPYRIGHT1! > docs\assets\js\copyright.js
echo.!COPYRIGHT2! >> docs\assets\js\copyright.js
echo.!COPYRIGHT3! >> docs\assets\js\copyright.js
echo.!COPYRIGHT4! >> docs\assets\js\copyright.js
echo.!COPYRIGHT5! >> docs\assets\js\copyright.js

type docs\assets\js\copyright.js docs\assets\js\bootstrap.min.tmp.js > docs\assets\js\bootstrap.min.js 2>nul
del docs\assets\js\copyright.js docs\assets\js\bootstrap.min.tmp.js

