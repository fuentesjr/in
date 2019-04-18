// Run this example by adding <%= javascript_pack_tag "elm_loader" %> to the
// head of your layout file, like app/views/layouts/application.html.erb.
// It will render "Hello Elm!" within the page.

import Elm from 'elm/Main'

document.addEventListener('DOMContentLoaded', () => {
  const target = document.createElement('div')
  const dataNode = document.getElementById('init-data')
  const initData = JSON.parse(dataNode.getAttribute('data'))

  document.body.appendChild(target)
  Elm.Main.embed(target, initData)
})
