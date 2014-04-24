window.BackboneTodo =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}
  init: ->
    'use strict'
    console.log 'Hello from Backbone!'
    Todos = new BackboneTodo.Collections.TodoList()
$ ->
  'use strict'
  BackboneTodo.init();
