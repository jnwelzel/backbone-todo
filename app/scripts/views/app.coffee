'use strict'

@app.AppView = Backbone.View.extend

  statsTemplate: JST['app/scripts/templates/stats.ejs']

  el: $('#todoapp')

  events:
    'keypress #new-todo':  'createOnEnter'
    'click #clear-completed': 'clearCompleted'
    'click #toggle-all': 'toggleAllComplete'

  initialize: () ->
    @allCheckbox = @$('#toggle-all')[0]
    @$input = @$('#new-todo')
    @$footer = @$('footer')
    @$main = $('#main')

    @listenTo(app.Todos, 'add', @addOne)
    @listenTo(app.Todos, 'reset', @addAll)
    @listenTo(app.Todos, 'change:completed', @filterOne)
    @listenTo(app.Todos, 'filter', @filterAll)
    @listenTo(app.Todos, 'all', @render)


    # A TodoList object
    app.Todos.fetch()
    return

  render: () ->
    completed = app.Todos.completed().length
    remaining = app.Todos.remaining().length

    if app.Todos.length
      @$main.show()
      @$footer.show()

      @$footer.html @statsTemplate
        completed: completed
        remaining: remaining

      @$('#filters li a')
        .removeClass('selected')
        .filter('[href="#/' + ( app.TodoFilter || '' ) + '"]')
        .addClass('selected')
    else
      @$main.hide()
      @$footer.hide()

    @allCheckbox.checked = !remaining

  # Add a single todo item to the list by creating a view for it, and
  # appending its element to the `<ul>`.
  addOne: (todo) ->
    view = new app.TodoView({ model: todo })
    $('#todo-list').append( view.render().el )
    return

  # Add all items in the **app.Todos** collection at once.
  addAll: ->
    @$('#todo-list').html('')
    app.Todos.each(@addOne, @)
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
    order: app.Todos.nextOrder()
    completed: false

  # If you hit return in the main input field, create new Todo model, persisting it to localStorage.
  createOnEnter: (event) ->
    if event.which isnt app.ENTER_KEY or !@$input.val().trim()
      return

    app.Todos.create @newAttributes()
    @$input.val ''

  # Clear all completed todo items, destroying their models.
  clearCompleted: ->
    _.invoke(app.Todos.completed(), 'destroy')
    return false

  toggleAllComplete: ->
    completed = @allCheckbox.checked

    app.Todos.each (todo) ->
      todo.save 'completed': completed
      return
    return
