const fs = require('fs');
const path = require('path');
const archiver = require('archiver');

// Get version from package.json
const packageJson = require('./package.json');
const version = packageJson.version;

// Ensure dist directory exists
const distDir = path.join('dist', version);
if (!fs.existsSync('dist')) {
  fs.mkdirSync('dist');
}
if (!fs.existsSync(distDir)) {
  fs.mkdirSync(distDir, { recursive: true });
}

// Output file path
const outputZip = path.join(distDir, `joker-${version}.zip`);

// Files/folders to exclude
const excludePatterns = [
  'node_modules',
  'dist',
  '.git',
  '.github',
  'images',
  '.vscode',
  'deploy',
  '.deploy-exclude',
  'build.js',
  'prep-release.js',
  '.gitignore',
  '.gitattributes',
  'package.json',
  'package-lock.json',
  'build-temp.ps1'
];

/**
 * Check if a file/folder should be included in the build
 */
function shouldInclude(itemPath) {
  const itemName = path.basename(itemPath);
  return !excludePatterns.includes(itemName);
}

/**
 * Build the addon archive using archiver library
 * This creates a standard zip file compatible with all platforms and tools like Minion
 */
async function buildArchive() {
  console.log('Building archive...');
  console.log(`Version: ${version}`);
  console.log(`Output: ${outputZip}`);
  
  // Remove existing zip if it exists
  if (fs.existsSync(outputZip)) {
    fs.unlinkSync(outputZip);
  }
  
  return new Promise((resolve, reject) => {
    // Create a write stream for the output file
    const output = fs.createWriteStream(outputZip);
    
    // Create archiver instance with standard deflate compression
    // Using level 9 for maximum compatibility and compression
    const archive = archiver('zip', {
      zlib: { level: 9 }
    });
    
    // Handle completion
    output.on('close', () => {
      const stats = fs.statSync(outputZip);
      const sizeKB = (stats.size / 1024).toFixed(2);
      const sizeMB = (stats.size / 1024 / 1024).toFixed(2);
      console.log(`\n✓ Successfully created ${path.basename(outputZip)}`);
      console.log(`  Size: ${sizeKB} KB (${sizeMB} MB)`);
      console.log(`  Total bytes: ${archive.pointer()}`);
      resolve();
    });
    
    // Handle warnings
    archive.on('warning', (err) => {
      if (err.code === 'ENOENT') {
        console.warn('Warning:', err);
      } else {
        reject(err);
      }
    });
    
    // Handle errors
    archive.on('error', (err) => {
      reject(err);
    });
    
    // Pipe archive data to the output file
    archive.pipe(output);
    
    // Get all items in the current directory
    const items = fs.readdirSync('.');
    
    console.log('\nAdding files to archive:');
    
    // Add each item to the archive under the "Joker" directory
    for (const item of items) {
      if (shouldInclude(item)) {
        const itemPath = path.join('.', item);
        const stats = fs.statSync(itemPath);
        
        if (stats.isDirectory()) {
          console.log(`  + ${item}/ (directory)`);
          archive.directory(itemPath, path.join('Joker', item));
        } else {
          console.log(`  + ${item}`);
          archive.file(itemPath, { name: path.join('Joker', item) });
        }
      } else {
        console.log(`  - ${item} (excluded)`);
      }
    }
    
    // Finalize the archive
    console.log('\nFinalizing archive...');
    archive.finalize();
  });
}

// Main execution
(async () => {
  try {
    await buildArchive();
    console.log('\n🎉 Build completed successfully!\n');
  } catch (error) {
    console.error('\n❌ Build failed:', error.message);
    console.error(error);
    process.exit(1);
  }
})();
