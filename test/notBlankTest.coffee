assert    = require "assert"
_         = require "underscore"
Validator = require "../src/Validator"

describe "notBlank filter", ->
  it "passes one criterion properly", (done) ->
    new Validator(email: Validator.notBlank())
      .validate {email: "foo"}, (errors) ->
        assert.equal _.keys(errors).length, 0
        done()

  it "fails one criterion properly", (done) ->
    message = "this field is required"
    new Validator(email: Validator.notBlank(message))
      .validate {email: ""}, (errors) ->
        assert.equal _.keys(errors).length, 1
        assert.equal message, errors.email
        done()
