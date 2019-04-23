const fs = require('fs'),
      path = require('path'),
      request = require('request'),
      axios = require('axios'),
      chalk = require('chalk'),
      credentials = require('./credentials.js')

const cmd = require('minimist')(process.argv.slice(2))


const bufferFile = (relPath) => {
  return fs.readFileSync(path.join(__dirname, relPath), { encoding: 'utf8'});
}

const getAddon = (addonID) => {
  
  let url = "https://api.esoui.com/addons/list.json"
  if (addonID && addonID > 0) {
    url = 'https://api.esoui.com/addons/details/' + addonID + '.json'; 
  }

  axios.get(url, {
    headers: { 
      'x-api-token': credentials.esoui_update_token
    }
  })
  .then((res) => {
    console.log(res.data);
  })
  .catch(function (error) {
    console.log('Error connecting to esoui.com (' + error.response.status +' Status) ...')
    console.log('Attempted URL', url)
    // Error
    if (error.response) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx
      console.log(error.response.data);
      // console.log(error.response.status);
      // console.log(error.response.headers);
    } else if (error.request) {
      // The request was made but no response was received
      // `error.request` is an instance of XMLHttpRequest in the browser and an instance of
      // http.ClientRequest in node.js
      console.log(error.request);
    } else {
      // Something happened in setting up the request that triggered an Error
      console.log('Error', error.message);
    }
  })

}


/**
 * Originally from: github/michaelwestbrook/esoui-publish
 * @param {string} token ESOUI access token
 * @param {number} addonId ESOUI addon ID number
 * @param {string | number} version Version of addon being published
 * @param {string} description Text to display on the main page
 * @param {string} changelog Text to display in the changelog
 * @param {string | number} compatibility Game version supported. Use comma separated list for multiple compatibilities
 * @param {string} updatefile Optional: Location of the update file
 * 
 */
function updateEsoui(token, addonId, version, description, changelog, compatibility, updatefile) {
  const formData = {
    id: addonId,
    version: version,
    description: description,
    changelog: changelog,
    compatible: compatibility
  };

  if (updatefile) {
    console.log(`Attaching ${updatefile}`)
    formData.updatefile = fs.createReadStream(updatefile)
  } else {
    console.log('No update file provided')
  }

  return new Promise((resolve, reject) => request.post({ headers: { 'x-api-token': token }, url: 'https://api.esoui.com/addons/updatetest', formData: formData },
    (error, httpResponse, body) => {
      if (error) {
        reject(error)
      }
      
      if (httpResponse.statusCode - 200 > 100) {
        reject(httpResponse.statusMessage)
      } 

      console.log(`Successfully published to ESO.\n${body}`)
      resolve(body)
    }));
}


const token = credentials.esoui_update_token; //https://www.esoui.com/downloads/filecpl.php?action=apitokens
let version = '1.0.0', // The version of your addon
    description = 'This is the text that will show on your main page',
    changelog = 'This is the text that will show on your changelog',
    compatibility = '4.3', // The game version your addon supports.
    updateFile = './my-addon.zip' // Optional: Location of the upload package
// esouiPublish(token, addonId, version, description, changelog, compatibility, updateFile);


if (cmd['addon'] > 0) {
  if (cmd['update']) {
    if (!cmd['name'] || cmd['name'].length < 1) {
      console.log(chalk.white.bgRed.bold('Check package.json and make sure to specify a "--name" arg in the addon-update script! Name should be the filename of your manifest file (without the file extension). For example, if your manifest file is "Joker.txt", you should change the --name to "Joker".'))
      return false
    }

    console.log(chalk.white.bgMagenta.bold('Attempting to update addon with the below info:'))
    if (cmd['test']) console.log(chalk.white.bgRed('This is a test - update will hit esoui servers but will not actually go live!'))
    console.log('AddonID: ' + cmd['addon'])

    // Grab the info we need from the local manifest
    let manifest = bufferFile('../' + cmd['name'] +'.txt').toString().split("\n"),
        updateStatus = {}
    for (i in manifest) {
      // Get addon version
      if (manifest[i].match('## Version:')) {
        let addonVersion = manifest[i].split('## Version:')[1].trim()
        console.log('Version: ' + addonVersion)
      }

      // Compatibility. Assemble list of patch numbers (comma delim)
      if (manifest[i].match('## APIVersion:')) {
        let apiVersions = manifest[i].split('## APIVersion:')[1].trim().replace(" ", ",")
        console.log('APIVersion: ' + apiVersions)
      }
      
      checkToUpdate()
    }

    // Description. Not doing anything here, since it's probably better to update via site since editor provides better image management
    console.log('Description: Skipping, update via website')
    // Changelog - also not doing anything here, but could easily just prepend last git commit 
    console.log('Changelog: Skipping, update via website')

    // Attempt update
    let updateAttempt = new Promise((resolve, reject) => request.post({ headers: { 'x-api-token': token }, url: 'https://api.esoui.com/addons/update' + (cmd['test'] ? 'test' : ''), formData: { id: cmd['addon'], version: addonVersion, compatible: apiVersions} },
    (error, httpResponse, body) => {
      if (error) {
        reject(error)
      }
      
      if (httpResponse.statusCode - 200 > 100) {
        reject(httpResponse.statusMessage)
      } 

      console.log(`Successfully published to ESO.\n${body}`)
      resolve(body)
    }))

    console.log(updateAttempt)

  } else {
    console.log('Fetching addon data for addon with ID ' + cmd['addon'])
    getAddon(cmd['addon'])
  }
} else {
  console.log('Fetching list of addons accessible by you.')
  getAddon()
}

module.exports = updateEsoui;
