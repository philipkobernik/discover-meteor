if Posts.find().count() is 0
  now = new Date().getTime()

  hours = 3600 * 1000

  tomId = Meteor.users.insert
    profile: { name: 'Tom Coleman' }

  tom = Meteor.users.findOne tomId

  sachaId = Meteor.users.insert
    profile: { name: 'Sacha Greif' }

  sacha = Meteor.users.findOne sachaId

  gardenerId = Posts.insert
    title: 'Avant Gardener',
    userId: sacha._id
    author: sacha.profile.name
    url: 'https://soundcloud.com/courtney-barnett-milk/courtney-barnett-avant'
    submitted: now - 7 * hours

  Comments.insert
    postId: gardenerId
    userId: tom._id
    author: tom.profile.name
    submitted: now - 5 * hours
    body: 'Interesting project Sacha, can I get involved?'

  Comments.insert
    postId: gardenerId
    userId: sacha._id
    author: sacha.profile.name
    submitted: now - 3 * hours
    body: 'You sure can Tom!'

  Posts.insert
    title: 'Strategic Game of Life',
    author: 'Thomas Hunter',
    url: 'https://thomashunter.name/games/strategic-game-of-life/'

  Posts.insert
    title: 'Travelling Under Pinnacle',
    author: 'Philip',
    url: 'http://i.imgur.com/RqyToAP.jpg'

