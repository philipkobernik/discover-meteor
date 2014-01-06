PostsListController = RouteController.extend
  template: 'postsList'
  increment: 5
  limit: -> parseInt(@params.postsLimit) or @increment
  findOptions: -> sort: {submitted: -1}, limit: @limit()
  waitOn: ->
    Meteor.subscribe('posts', @findOptions())
  data: ->
    return {
      posts: Posts.find {}, @findOptions()
    }

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
    controller: PostsListController

requireLogin = ->
  unless Meteor.user()
    if Meteor.loggingIn()
      @render @loadingTemplate
    else
      @render 'accessDenied'
    @stop()

Router.before requireLogin, only: 'postSubmit'
Router.before -> clearErrors()
