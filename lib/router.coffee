Router.configure
  layoutTemplate: 'layout'
  loadingTemplate: 'loading'
  waitOn: -> [Meteor.subscribe('notifications')]

Router.map ->
  @route 'postPage',
    path: '/posts/:_id'
    waitOn: ->
      [
        Meteor.subscribe('comments', @params._id),
        Meteor.subscribe('posts', @params._id)
      ]
    data: -> Posts.findOne(@params._id)

  @route 'postEdit',
    path: '/posts/:_id/edit'
    data: -> Posts.findOne(@params._id)

  @route 'postSubmit',
    path: '/submit'

  @route 'postsList',
    path: '/:postsLimit?'
    waitOn: ->
      postsLimit = parseInt @params.postsLimit or 5
      Meteor.subscribe('posts', {submitted: -1}, postsLimit)
    data: ->
      postsLimit = parseInt @params.postsLimit || 5
      return {
        posts: Posts.find({}, sort: {submitted: -1}, limit: postsLimit)
      }

requireLogin = ->
  unless Meteor.user()
    if Meteor.loggingIn()
      @render @loadingTemplate
    else
      @render 'accessDenied'
    @stop()

Router.before requireLogin, only: 'postSubmit'
Router.before -> clearErrors()
