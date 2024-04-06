param(
    [string]$GAMENAME,
    [switch]$OVERWRITE,
    [switch]$WINDOWS,
    [switch]$WEB,
    [switch]$LINUX
)

$basePath = 'dist'

$STARTLOG = Get-Date
Write-Host "Compile Process Started - Please Stand By..."

if ([string]::IsNullOrEmpty($GAMENAME)) {
    $GAMENAME = Read-Host "Please provide a game name"
}

if ((Test-Path -Path $basePath) -and ($OVERWRITE -eq $false)) {
    $confirm = Read-Host "This will delete the dist folder and all its contents. Are you sure you want to continue? (Y/N)"
    if ($confirm -ne 'Y') {
        Write-Host "Compile Process Aborted"
        exit
    }
}

Remove-Item -Path $basePath -Recurse -Force -ErrorAction SilentlyContinue

if ($WINDOWS) {
    $Env:GOOS = 'windows'
    $Env:GOARCH = 'amd64'
    go build -o "$basePath\win\$GAMENAME.exe" main.go
    Remove-Item Env:GOOS
    Remove-Item Env:GOARCH
}

if ($WEB) {
    $Env:GOOS = 'js'
    $Env:GOARCH = 'wasm'
    go build -o "$basePath\web\$GAMENAME.wasm" main.go
    $htmlFile = @"
    <!DOCTYPE html>
    <html>
    <head>
        <title>$GAMENAME - WebAssembly Game</title>
    </head>
    <body>
        <script src="wasm_exec.js"></script>
        <script>
        // Polyfill
        if (!WebAssembly.instantiateStreaming) {
            WebAssembly.instantiateStreaming = async (resp, importObject) => {
                const source = await (await resp).arrayBuffer();
                return await WebAssembly.instantiate(source, importObject);
            };
        }

        const go = new Go();
        WebAssembly.instantiateStreaming(fetch("$GAMENAME.wasm"), go.importObject).then(result => {
            go.run(result.instance);
        });
        </script>
    </body>
    </html>
"@
    
    $goroot = go env GOROOT
    Copy-Item $goroot\misc\wasm\wasm_exec.js "$basePath\web\wasm_exec.js"
    Set-Content -Path "$basePath\web\index.html" -Value $htmlFile
    Remove-Item Env:GOOS
    Remove-Item Env:GOARCH
}
#Uncomment and adjust if you need to build for Linux

if ($LINUX) {
    wsl bash -lic "export GOOS='linux' && export GOARCH='amd64' && go build -o '$basePath/linux/$GAMENAME' main.go"
}




$ENDLOG = Get-Date
$DURATION = $ENDLOG - $STARTLOG
Write-Host "Compile Completed for Windows: $WINDOWS, Web: $WEB, Linux: $LINUX" 
Write-Host "Total Duration: $DURATION - Start: $STARTLOG - End: $ENDLOG"
