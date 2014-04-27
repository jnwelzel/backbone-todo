TodoList = Backbone.Collection.extend

  model: app.Todo

  localStorage: new Backbone.LocalStorage('backbone-todos')

  completed: ->
    return @filter (todo) ->
      return todo.get('completed')

  remaining: ->
    @without.apply @, @completed()

  nextOrder: ->
    if !@length
      return 1
    return @last().get('order') + 1

  # Todos are sorted by their original insertion order.
  comparator: (todo) ->
    todo.get 'order'

@app.Todos = new TodoList()