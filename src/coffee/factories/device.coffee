#wrapper for phonegap device api
dvc = ->
  wrapper = {}
  if device?
    wrapper[m] = device[m] for m in ['cordova', 'model', 'name', 'platform', 'uuid', 'version']
  wrapper

module.exports = dvc
