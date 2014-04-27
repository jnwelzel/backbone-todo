@app = {}
@app.ENTER_KEY = 13

$ ->
  'use strict'
  console.log 'Surprise motherfucker!'
  new app.AppView()