assert    = require "assert"
_         = require "underscore"
Validator = require "../src/Validator"

describe "Validator", ->
	it "validates with no criteria", (done) ->
    new Validator().validate {foo: "bar"}, (errors) ->
      assert.equal _.keys(errors).length, 0
      done()

  it "validates empty objects", (done) ->
    new Validator().validate {}, (errors) ->
      assert.equal _.keys(errors).length, 0
      done()

  it "chains successful validations", (done) ->
    obj = {email: "foo", name: "bar"}
    new Validator(
      email: Validator.notBlank(),
      name:  Validator.notBlank()
    ).validate obj, (errors) ->
      assert.equal _.keys(errors).length, 0
      done()

  it "chains failed validations", (done) ->
    obj = {name: ""}
    message = "bad news!"
    new Validator(
      email: Validator.notBlank(message),
      name:  Validator.notBlank(message)
    ).validate obj, (errors) ->
      assert.equal _.keys(errors).length, 2
      assert.equal errors.name.length,    1
      assert.equal errors.email.length,   1
      assert.equal _.head(errors.name),   message
      assert.equal _.head(errors.email),  message

      done()

  it "chains a mix of successful and failed validations", (done) ->
    obj = {name: "bar"}
    message = "this is a test"
    new Validator(
      email: Validator.notBlank(message),
      name: Validator.notBlank(message)
    ).validate obj, (errors) ->
      assert.equal _.keys(errors).length, 1
      assert.equal errors.email.length,   1
      assert.equal _.head(errors.email),  message

      done()