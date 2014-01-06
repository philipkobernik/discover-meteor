Meteor.publish 'posts', (sortOrId, limit)->
  if limit?
    Posts.find {}, sort: sortOrId, limit: limit
  else
    Posts.find {_id: sortOrId}, limit: 1


Meteor.publish 'comments', (postId)->
  Comments.find postId: postId

Meteor.publish 'notifications', ->
  Notifications.find userId: @userId
