for /R %%f in (*.dia) do (
    dia.exe -e %%~dpnf.svg -t svg %%f
)