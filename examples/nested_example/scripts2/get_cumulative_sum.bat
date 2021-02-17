@echo off

::This script takes three input arguments START STEP STOP and plugs them into a FOR /L loop.
::Returns the sum of all numbers iterated over under the global variable cumulative_sum

set /a cumulative_sum=0
for /l %%c in (%~1 %~2 %~3) do set /a cumulative_sum+=%%c
