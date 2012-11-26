pg13 =
  Models: {}
  Views: {}
  Collections: {}


pg13.Models.Page = Backbone.Model.extend 
  defaults:
    title: "paulgrock.com web developer"
    content: "Hi, I'm Paul Grock"
    identifier: "index"

pg13.Views.Page = Backbone.View.extend
  tagName: "section"
  template: _.template( $("#page-template").html )
  initialize: ->

  render: ->


  addOne: (model)->



pg13.Views.Pages = Backbone.View.extend
  className: 'main'
  initialize: ->

  render: ->


  addOne: (model)->

pg13.Collections.Pages = Backbone.Collection.extend
  model: pg13.Models.Page