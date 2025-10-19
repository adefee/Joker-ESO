const fs = require('fs');
const path = require('path');
const { execSync } = require('child_process');

// Get version from package.json
const packageJson = require('./package.json');
const version = packageJson.version;

// Ensure dist directory exists
const distDir = path.join('dist', version);
if (!fs.existsSync('dist')) {
  fs.mkdirSync('dist');
}
if (!fs.existsSync(distDir)) {
  fs.mkdirSync(distDir);
}

// Output file path
const outputZip = path.join(distDir, `joker-${version}.zip`);

// Files/folders to exclude
const excludePatterns = [
  'node_modules',
  'dist',
  '.git',
  'images',
  '.vscode',
  'deploy',
  '.deploy-exclude',
  'build.js',
  '.gitignore',
  '.gitattributes'
];

// Build PowerShell command to create zip
const excludeFilter = excludePatterns.map(ex => `$_.Name -ne '${ex}'`).join(' -and ');

const psCommand = `
$ProgressPreference = 'SilentlyContinue';
$source = Get-Location;
$tempDir = Join-Path $env:TEMP "Joker-build-$(Get-Random)";
$destFolder = Join-Path $tempDir "Joker";
New-Item -ItemType Directory -Path $destFolder -Force | Out-Null;
Get-ChildItem -Path $source | Where-Object { ${excludeFilter} } | Copy-Item -Destination $destFolder -Recurse -Force;
Compress-Archive -Path $destFolder -DestinationPath (Join-Path $source "${outputZip.replace(/\\/g, '\\\\')}") -Force;
Remove-Item -Path $tempDir -Recurse -Force;
`.trim();

try {
  console.log('Building archive...');
  console.log(`Output: ${outputZip}`);
  
  // Remove existing zip if it exists
  if (fs.existsSync(outputZip)) {
    fs.unlinkSync(outputZip);
  }
  
  // Write PowerShell script to temp file for easier debugging
  const tempScript = path.join(__dirname, 'build-temp.ps1');
  fs.writeFileSync(tempScript, psCommand);
  
  console.log('Running PowerShell script...');
  try {
    execSync(`powershell -ExecutionPolicy Bypass -File "${tempScript}"`, { 
      stdio: 'inherit',
      shell: 'cmd.exe'
    });
  } finally {
    // Clean up temp script
    if (fs.existsSync(tempScript)) {
      fs.unlinkSync(tempScript);
    }
  }
  
  // Verify the zip was created
  if (fs.existsSync(outputZip)) {
    const stats = fs.statSync(outputZip);
    console.log(`\n✓ Successfully created ${path.basename(outputZip)} (${(stats.size / 1024).toFixed(2)} KB)`);
  } else {
    throw new Error('Zip file was not created');
  }
} catch (error) {
  console.error('Build failed:', error.message);
  process.exit(1);
}
