## SweetValidation

A sweet library for potentially asynchronous validations.

Depends on [underscore.js](http://underscorejs.org) or [Lo-Dash](http://lodash.com/).

```javascript
  new Validator({
    email: function(obj, field, callback) {
      if isValidEmail(obj[field])
        callback([]);
      else
        callback(["Invalid email!"]);
    },

    name: [Validator.notBlank, someOtherFunction]
  }).validate(someObject, function(errors, valid) {
    console.log("Was it valid overall?", valid)
    console.log("All errors:", errors);
    console.log("Email-specific errors:", errors.email);
    console.log("Name-specific errors:",  errors.name);
  });
```

MIT Licensed.