do (require "source-map-support").install

# TODO: Switch to expect
{ expect }  = require "chai"
Error2      = require "../lib/Error2"

describe "Error2", ->

  describe "arguments", ->

    it "can be empty", ->
      error = new Error2

      expect error
        .to.have.all.keys
          name    : "Error"
          massage : ""

    it "can contain data only", ->
      error = new Error2 cause: "Lack of test cases"

      expect error
        .to.have.all.keys
          name    : "Error"
          massage : ""
          cause   : "Lack of test cases"

    it "can contain name and message in data hash", ->
      error = new Error2
        name      : "AllDeadError"
        message   : "Masakra piłą spalinową w kawiarni 3",
        code      : "red"
        survivors : 0

      expect error
        .to.have.all.keys
          name      : "AllDeadError"
          message   : "Masakra piłą spalinową w kawiarni 3",
          code      : "red"
          survivors : 0

    it "can contain message only", ->
      error = new Error2 "Masakra piłą spalinową w kawiarni"

      expect error
        .to.have.all.keys
          name    : "Error"
          message : "Masakra piłą spalinową w kawiarni"

    it "can contain name and message", ->
      error = new Error2 "FatalError", "Masakra piłą spalinową w kawiarni 2"

      expect error
        .to.have.all.keys
          name    : "FatalError"
          message : "Masakra piłą spalinową w kawiarni 2"

    it "can contain name and data", ->
      error = new Error2 "StrangeError",
        message : "There is something going on!"
        errno   : 12345

      expect error
        .to.have.all.keys
          name    : "StrangeError"
          message : "There is something going on!"
          errno   : 12345


    it "can contain name, message and data", ->
      error = new Error2 "Unexpected",
        "Nobody expects spanish inquisition!"
        chair   : "comfy"
        cussions: 2

      expect error
        .to.have.all.keys
          name    : "Unexpected"
          message : "Nobody expects spanish inquisition!"
          chair   : "comfy"
          cussions: 2

    it "throws Error if arguments' types are wrong", ->
      try
        new Error2 "NameIsString", {data: "wrong"}, "This is wrong"
      catch error
        expect error
          .to.be.an.instanceof  Error
          # TODO: Change that: name should be TypeError and message as name is.
          .and.to.have.property "name",  "Unsupported message type"
          # "message"

    it "can be serialized to JSON and preserve data", ->
      data =
        name    : 'SerializationError'
        message : 'This error can and will be serialized'
        format  : 'JSON'
        reasons : [
          'To be pretty printed'
          'To be passed to client in HTTP response'
          'To be sent via WebSocket'
          '...'
        ]

      error = new Error data

      expect JSON.stringify data
        .to.be.equal JSON.stringify error
