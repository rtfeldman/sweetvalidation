assert    = require "assert"
_         = require "underscore"
Validator = require "../src/Validator"

describe "notBlank filter", ->
  it "passes one criterion properly", (done) ->
    new Validator(email: Validator.validEmail())
      .validate {email: "test+foo.bar@b.co"}, (errors, valid) ->
        assert valid
        assert.equal _.keys(errors).length, 0
        done()

  it "fails one criterion properly", (done) ->
    message = "bad email!"
    new Validator(email: Validator.validEmail(message))
      .validate {email: "foo"}, (errors, valid) ->
        assert !valid
        assert.equal _.keys(errors).length, 1
        assert.equal message, errors.email
        done()
