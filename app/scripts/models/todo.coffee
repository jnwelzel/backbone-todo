'use strict';

class BackboneTodo.Models.Todo extends Backbone.Model
  url: '',

  initialize: () ->

  defaults: {
    'completed': false,
    'title': ''
  }

  validate: (attrs, options) ->

  parse: (response, options) ->
    response
