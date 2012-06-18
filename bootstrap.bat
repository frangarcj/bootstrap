@echo off

set "BOOTSTRAP=.\docs\assets\css\bootstrap.css"
set "BOOTSTRAP_LESS=.\less\bootstrap.less"
set "BOOTSTRAP_RESPONSIVE=.\docs\assets\css\bootstrap-responsive.css"
set "BOOTSTRAP_RESPONSIVE_LESS=.\less\responsive.less"

mkdir bootstrap\img 2>nul
mkdir bootstrap\css 2>nul
mkdir bootstrap\js 2>nul

copy /Y img bootstrap\img > nul

call recess --compile %BOOTSTRAP_LESS% > bootstrap\css\bootstrap.css 
call recess --compress %BOOTSTRAP_LESS% > bootstrap\css\bootstrap.min.css
call recess --compile %BOOTSTRAP_RESPONSIVE_LESS% > bootstrap\css\bootstrap-responsive.css
call recess --compress %BOOTSTRAP_RESPONSIVE_LESS% > bootstrap\css\bootstrap-responsive.min.css

type js\bootstrap-transition.js js\bootstrap-alert.js js\bootstrap-button.js js\bootstrap-carousel.js js\bootstrap-collapse.js js\bootstrap-dropdown.js js\bootstrap-modal.js js\bootstrap-tooltip.js js\bootstrap-popover.js js\bootstrap-scrollspy.js js\bootstrap-tab.js js\bootstrap-typeahead.js > bootstrap\js\bootstrap.js 2> nul

call uglifyjs -nc bootstrap\js\bootstrap.js > bootstrap\js\bootstrap.min.tmp.js

setlocal EnableDelayedExpansion
set "COPYRIGHT1=/**"
set "COPYRIGHT2=* Bootstrap.js by @fat & @mdo"
set "COPYRIGHT3=* Copyright 2012 Twitter, Inc."
set "COPYRIGHT4=* http://www.apache.org/licenses/LICENSE-2.0.txt"
set "COPYRIGHT5=*/"
echo !COPYRIGHT1! > bootstrap\js\copyright.js
echo.!COPYRIGHT2! >> bootstrap\js\copyright.js
echo.!COPYRIGHT3! >> bootstrap\js\copyright.js
echo.!COPYRIGHT4! >> bootstrap\js\copyright.js
echo.!COPYRIGHT5! >> bootstrap\js\copyright.js

type bootstrap\js\copyright.js bootstrap\js\bootstrap.min.tmp.js > bootstrap\js\bootstrap.min.js 2>nul
del bootstrap\js\copyright.js bootstrap\js\bootstrap.min.tmp.js