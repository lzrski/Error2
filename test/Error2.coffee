# TODO: Is source-map-support still needed?
do (require "source-map-support").install

# TODO: Switch to expect
{ should }  = require "chai"
Error2      = require "../lib/Error2"
do should

describe "Error2", ->

  describe "arguments", ->

    it "can be empty", ->
      error = new Error2

      error.should.have.property  "name"
      error.name.should.equal     "Error"

      error.should.have.property  "message"
      error.message.should.equal  ""

    it "can contain data only", ->
      error = new Error2 cause: "Lack of test cases"

      error.should.have.property  "name"
      error.name.should.equal     "Error"

      error.should.have.property  "message"
      error.message.should.equal  ""

      error.should.have.property  "cause"
      error.cause.should.equal    "Lack of test cases"

    it "can contain name and message in data hash", ->
      error = new Error2
        name      : "AllDeadError"
        message   : "Masakra piłą spalinową w kawiarni 3",
        code      : "red"
        survivors : 0

      error.should.have.property  "name"
      error.name.should.equal     "AllDeadError"

      error.should.have.property  "message"
      error.message.should.equal  "Masakra piłą spalinową w kawiarni 3"

      error.should.have.property  "code"
      error.code.should.equal     "red"

      error.should.have.property  "survivors"
      error.survivors.should.equal     0

    it "can contain message only", ->
      error = new Error2 "Masakra piłą spalinową w kawiarni"

      error.should.have.property  "name"
      error.name.should.equal     "Error"

      error.should.have.property  "message"
      error.message.should.equal  "Masakra piłą spalinową w kawiarni"

    it "can contain name and message", ->
      error = new Error2 "FatalError", "Masakra piłą spalinową w kawiarni 2"

      error.should.have.property  "name"
      error.name.should.equal     "FatalError"

      error.should.have.property  "message"
      error.message.should.equal  "Masakra piłą spalinową w kawiarni 2"


    it "can contain name and data", ->
      error = new Error2 "StrangeError",
        message : "There is something going on!"
        errno   : 12345

      error.should.have.property  "name"
      error.name.should.equal     "StrangeError"

      error.should.have.property  "message"
      error.message.should.equal  "There is something going on!"

      error.should.have.property  "errno"
      error.errno.should.equal  12345

    it "can contain name, message and data", ->
      error = new Error2 "Unexpected",
        "Nobody expects spanish inquisition!"
        chair   : "comfy"
        cussions: 2

      error.should.have.property  "name"
      error.name.should.equal     "Unexpected"

      error.should.have.property  "message"
      error.message.should.equal  "Nobody expects spanish inquisition!"

      error.should.have.property  "chair"
      error.chair.should.equal    "comfy"

      error.should.have.property  "cussions"
      error.cussions.should.equal 2

    it "throws Error if arguments' types are wrong", ->
      try
        new Error2 "NameIsString", {data: "wrong"}, "This is wrong"
      catch error
        error.should.be.an.instanceof Error
        error.should.have.property    "message"
        error.should.have.property    "name"
        error.name.should.equal       "Unsupported message type"
