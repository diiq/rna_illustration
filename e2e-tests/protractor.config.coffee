exports.config = {

  baseUrl: 'http://localhost:3001'

  params:
    user:
      givenName: 'Test'
      surname: 'User'
      email: 'e2e-test@example.com'
      password: 'unsecure'

  jasmineNodeOpts:
    isVerbose: true

  onPrepare: ->
    # This allows us to find links by ui-sref
    require('protractor-linkuisref-locator')(protractor)

    # coffeelint: disable=no_backticks
    By = `by`
    # coffeelint: enable=no_backticks

    # The following is a good example of logging in before the E2E tests start

    ###
    # This doesn't use Protractor, so we have to use webdriver directly
    browser.driver.get(browser.baseUrl + '/login')

    browser.driver.findElement(By.css('#login input[type="text"]'))
      .sendKeys(browser.params.user.email)

    browser.driver.findElement(By.css('#login input[type="password"]'))
      .sendKeys(browser.params.user.password)

    browser.driver.findElement(By.css('#login button')).click()

    # Login takes some time, so wait until we've been redirected
    browser.driver.wait ->
      browser.driver.getCurrentUrl().then (url) ->
        return url == 'http://localhost:3001/'
    ###

}
