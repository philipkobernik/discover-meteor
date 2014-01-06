Meteor.publish 'posts', (findOptions)->
  if _.isObject(findOptions)
    Posts.find {}, findOptions
  else
    Posts.find {_id: findOptions}, limit: 1

Meteor.publish 'comments', (postId)->
  Comments.find postId: postId

Meteor.publish 'notifications', ->
  Notifications.find userId: @userId
