'use strict';

@app.Todo = Backbone.Model.extend

  defaults:
    'completed': false
    'title': ''

  # Toggle the `completed` state of this todo item.
  toggle: ->
    @save
      completed: !@get 'completed'
    return
