'use strict'

class BackboneTodo.Views.App extends Backbone.View

  template: JST['app/scripts/templates/app.ejs']

  el: $('#todoapp')

  events:
    'keypress #new-todo':  'createOnEnter',
    'click #clear-completed': 'clearCompleted',
    'click #toggle-all': 'toggleAllComplete'

  initialize: () ->
    @input = @$('#new-todo')
    @allCheckbox = @$('#toggle-all')[0]

    @listenTo(Todos, 'add', @addOne)
    @listenTo(Todos, 'reset', @addAll)
    @listenTo(Todos, 'all', @render)

    @footer = @$('footer')
    @main = $('#main')

    # A TodoList object
    Todos.fetch()
    return

  render: () ->
    done = Todos.done().length
    remaining = Todos.remaining().length

    if Todos.length
      @main.show()
      @footer.show()
      @footer.html(@statsTemplate({done: done, remaining: remaining}))
    else
      @main.hide()
      @footer.hide()

    @allCheckbox.checked = !remaining
