# encoding: utf-8

require "allure-cucumber"
require "capybara"
require "capybara/cucumber"
require "faker"

CONFIG = YAML.load_file(File.join(Dir.pwd, "features/support/config/#{ENV["CONFIG"]}"))

case ENV["BROWSER"]
when "firefox"
  @driver = :selenium
when "chrome"
  @driver = :selenium_chrome
when "fire_headless"
  @driver = :selenium_headless
when "chrome_headless"
  # O código abaixo foi retirado do código-fonted o Capybara no Github e foi ajustado para funcionar com o "ruby web agent"
  # que vamos usar para rodar os testes no Jenkins
  Capybara.register_driver :selenium_chrome_headless do |app|
    #Capybara.register_driver :selenium_chrome_headless do |app|
    Capybara::Selenium::Driver.load_selenium
    browser_options = ::Selenium::WebDriver::Chrome::Options.new.tap do |opts|
      opts.args << "--headless"
      opts.args << "--disable-gpu"
      opts.args << "--no-sandbox" # eu incluí esta linha. É importante para rodar em headless (pincipalmente dentr de container)
      opts.args << "--desable-dev-shm-usage" # eu incluí esta linha. É fundamental para o Chrome usar os recursos
      # de cache em disco e não em memória. Memória é escassa dentro da VM quando usamos Docker Toolbox.
      #opts.args << "--disable-site-isolation-trials"
    end
    Capybara::Selenium::Driver.new(app, browser: :chrome, options: browser_options)
  end
  #   version = Capybara::Selenium::Driver.load_selenium
  #   options_key = Capybara::Selenium::Driver::CAPS_VERSION.satisfied_by?(version) ? :capabilities : :options
  #   browser_options = ::Selenium::WebDriver::Chrome::Options.new.tap do |opts|
  #     opts.add_argument("--headless")
  #     opts.add_argument("--disable-gpu")
  #     opts.add_argument("--disable-site-isolation-trials")
  #     opts.add_argument("--no-sandbox") # eu incluí esta linha. É importante para rodar em headless (pincipalmente dentr de container)
  #     opts.add_argument("--disable-dev-shm-usage") # eu incluí esta linha. É fundamental para o Chrome usar os recursos
  #                                                  # de cache em disco e não em memória. Memória é escassa dentro da VM quando usamos Docker Toolbox.
  #   end
  #   Capybara::Selenium::Driver.new(app, **{ :browser => :chrome, options_key => browser_options })
  # end

  @driver = :selenium_chrome_headless
else
  raise "Navegador incorreto,  variável @driver está vazia :("
end

Capybara.configure do |config|
  config.default_driver = @driver
  config.app_host = CONFIG["url"]
  config.default_max_wait_time = 10
end

AllureCucumber.configure do |config|
  config.results_directory = "/logs"
  config.clean_results_directory = true
end
