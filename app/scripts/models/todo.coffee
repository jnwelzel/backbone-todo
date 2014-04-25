'use strict';

class BackboneTodo.Models.Todo extends Backbone.Model

  defaults:
    'completed': false
    'title': ''

  # Toggle the `completed` state of this todo item.
  toggle: ->
    @save
      completed: !@get 'completed'
  return
