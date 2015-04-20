HomepagePage = require('./pages/HomepagePageObject')

describe 'The Homepage', ->

  beforeEach ->
    @page = new HomepagePage()
    @page.get()

  it 'shows the page with the correct greeting', ->
    expect(@page.greeting.getText()).toBe('Hello world')

