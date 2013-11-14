(function() {
  var Validator, accumulateErrors, exports, trim, validEmail, _,
    __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  _ = (typeof window !== "undefined" && window !== null) && (window.require == null) ? window._ : require("underscore");

  Validator = (function() {
    function Validator(evaluators) {
      var nestedPairs;
      if (evaluators == null) {
        evaluators = {};
      }
      this.validate = __bind(this.validate, this);
      nestedPairs = _.map(evaluators, function(functions, field) {
        if (functions instanceof Array) {
          return _.map(functions, function(func) {
            return [field, func];
          });
        } else {
          return [[field, functions]];
        }
      });
      this.evaluatorPairs = _.flatten(nestedPairs != null ? nestedPairs : [], true);
    }

    Validator.prototype.validate = function(subject, callback) {
      return accumulateErrors(this.evaluatorPairs, subject, {}, callback);
    };

    Validator.notBlank = function(message) {
      if (message == null) {
        message = "Required";
      }
      return function(subject, field, callback) {
        return callback(trim(subject[field]) ? [] : [message]);
      };
    };

    Validator.validEmail = function(message) {
      if (message == null) {
        message = "Invalid email address";
      }
      return function(subject, field, callback) {
        return callback(validEmail.test(trim(subject[field])) ? [] : [message]);
      };
    };

    return Validator;

  })();

  accumulateErrors = function(evaluatorPairs, subject, errors, callback) {
    var evaluator, field, remainingPairs, _ref;
    if (!evaluatorPairs.length) {
      return callback(errors, _.isEmpty(errors));
    } else {
      _ref = _.head(evaluatorPairs), field = _ref[0], evaluator = _ref[1];
      remainingPairs = _.tail(evaluatorPairs);
      return evaluator(subject, field, function(newErrors) {
        var newErrorsMap, totalErrors, _ref1;
        newErrorsMap = !newErrors.length ? errors : (totalErrors = ((_ref1 = errors[field]) != null ? _ref1 : []).concat(newErrors), _.defaults(_.object([[field, totalErrors]]), errors));
        return accumulateErrors(remainingPairs, subject, newErrorsMap, callback);
      });
    }
  };

  trim = function(str) {
    return str != null ? str.replace(/^\s+|\s+$/g) : void 0;
  };

  validEmail = /[^@]+@[^.]+\..+/;

  if (typeof module !== "undefined" && module !== null) {
    module.exports = Validator;
  } else if (typeof exports !== "undefined" && exports !== null) {
    exports = Validator;
  } else if (typeof window !== "undefined" && window !== null) {
    window.Validator = Validator;
  } else {
    return Validator;
  }

}).call(this);
