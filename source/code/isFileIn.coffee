_ = require 'lodash'

minimatch = require 'minimatch'

# Returns true if `filename` passes through the `specs` specs Array
# 
# @param String filename name of the filename, eg 'myfile.txt' 
#
# @param Array<String|RegExp|Function> filename *specs* in minimatch or RegExp or Function (returning true for match),
#        with negative being '!' either as a 1st char of Strings or
#        as a plain '!' that negates the *spec* following (usefull to exclude matching RegExps & Functions).
#
# @todo: refactor to use a real agreement / _B.Blender
# @todo: move to glob-expand
isFileIn = module.exports = (filename, specs)-> #todo: (3 6 4) convert to proper In/in agreement
  finalAgree = false
  specs = [specs] if not _.isArray specs
  for agreement, idx in specs #go through all (no bailout when true) cause we have '!*glob*'
    agrees =
      if _.isString agreement
        if agreement[0] is '!'
          if agreement is '!'
            excludeIdx = idx + 1
          else
            excludeIdx = idx
          minimatch filename, agreement.slice(1)
        else
          minimatch filename, agreement

      else
        if _.isRegExp agreement
          !!filename.match agreement
        else
          if _.isFunction agreement
            agreement filename

    if  agrees is true
      if idx is excludeIdx
        finalAgree = false
      else
        finalAgree = true

  finalAgree

isFileIn.VERSION = if VERSION? then VERSION else '{NO_VERSION}' # 'VERSION' variable is added by grant:concat

# examples

#_.startsWith = (string, substring) -> string.lastIndexOf(substring, 0) is 0
#
#specs = [
#  '**/recources/*'
#  '!badFile.json'
#  /.*\.someExtension$/i
#  '!', /.*\.excludeExtension$/i
#  (fn)-> fn is 'includedFile.ext'
#  '!', (fn)-> _.startsWith 'bad'
#]
#
#console.log isFileIn 'someFile.someExtension', specs # true
#
#console.log isFileIn 'someFile.otherExtension', specs # false
#
#console.log isFileIn 'includedFile.ext', specs # true
#
#console.log isFileIn 'badFile.ext', specs # false