'use strict'

class BackboneTodo.Views.App extends Backbone.View

  statsTemplate: JST['app/scripts/templates/stats.ejs']

  el: $('#todoapp')

  events:
    'keypress #new-todo':  'createOnEnter'
    'click #clear-completed': 'clearCompleted'
    'click #toggle-all': 'toggleAllComplete'

  initialize: () ->
    @input = @$('#new-todo')
    @allCheckbox = @$('#toggle-all')[0]

    @listenTo(Todos, 'add', @addOne)
    @listenTo(Todos, 'reset', @addAll)
    @listenTo(Todos, 'change:completed', @filterOne)
    @listenTo(Todos, 'filter', @filterAll)
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

  # Add a single todo item to the list by creating a view for it, and
  # appending its element to the `<ul>`.
  addOne: (todo) ->
    view = new BackboneTodo.Views.Todo({ model: todo })
    $('#todo-list').append( view.render().el )
    return

  # Add all items in the **Todos** collection at once.
  addAll: ->
    @$('#todo-list').html('')
    Todos.each(@addOne, @)
    return

  filterOne: (todo) ->
    todo.trigger 'visible'
    return

  filterAll: ->
    app.Todos.each(@filterOne, @)
    return

  # Generate the attributes for a new Todo item.
  newAttributes: ->
    title: @$input.val().trim()
    order: Todos.nextOrder()
    completed: false
    return