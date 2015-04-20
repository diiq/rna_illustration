class DashboardPageObject
  @url = '/'

  constructor: ->
    @greeting = element(By.css('#homepage .greeting'))
    @url = @constructor.url

  get: -> browser.get(@url)

module.exports = DashboardPageObject
