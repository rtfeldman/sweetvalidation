_ = _ ? require "underscore"

class Validator
  constructor: (evaluators = {}) ->
    nestedPairs = _.map evaluators, (functions, field) ->
      if functions instanceof Array
        _.map functions, (func) -> [field, func]
      else
        [[field, functions]]

    # Store these as key/value pairs, to facilitate recursion when validating.
    @evaluatorPairs = _.flatten (nestedPairs ? []), true

  validate: (subject, callback) =>
    accumulateErrors @evaluatorPairs, subject, {}, callback

  @notBlank: (message = "Required") ->
    (subject, field, callback) ->
      callback if trim subject[field]
        []
      else
        [message]

accumulateErrors = (evaluatorPairs, subject, errors, callback) ->
  if !evaluatorPairs.length
    callback errors, _.isEmpty(errors)
  else
    [field, evaluator] = _.head evaluatorPairs
    remainingPairs     = _.tail evaluatorPairs

    evaluator subject, field, (newErrors) ->
      newErrorsMap = if !newErrors.length
        errors
      else
        totalErrors = (errors[field] ? []).concat newErrors

        _.defaults _.object([[field, totalErrors]]), errors

      accumulateErrors remainingPairs, subject, newErrorsMap, callback

trim = (str) -> str?.replace(/^\s+|\s+$/g)

if module?
  module.exports = Validator
else if exports?
  exports = Validator
else if window?
  window.Validator = Validator
else
  return Validator