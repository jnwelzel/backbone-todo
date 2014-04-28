@app = {}
@app.ENTER_KEY = 13
@app.TodoFilter = ''

$ ->
  'use strict'
  console.log 'Surprise motherfucker!'
  new app.AppView()