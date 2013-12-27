root = exports ? this
root.Errors = new Meteor.Collection(null)

root.throwError = (message)->
  Errors.insert
    message: message
    seen: false

root.clearErrors = ->
  Errors.remove seen: true


