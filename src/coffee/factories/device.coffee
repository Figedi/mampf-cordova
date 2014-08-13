#test-wrapper for phonegap device api
dvc = ->
  wrapper = {}
  for m in ['cordova', 'model', 'name', 'platform', 'uuid', 'version']
    wrapper[m] = if device? #safely check if device is available
      device[m]
    else
      null
  wrapper

module.exports = dvc
