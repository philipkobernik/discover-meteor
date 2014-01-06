Meteor.publish 'posts', (findOptions)->
  Posts.find {}, findOptions

Meteor.publish 'singlePost', (postId)->
  return postId and Posts.find postId

Meteor.publish 'comments', (postId)->
  Comments.find postId: postId

Meteor.publish 'notifications', ->
  Notifications.find userId: @userId
