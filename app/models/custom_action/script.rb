# == Schema Information
#
# Table name: custom_actions
#
#  id            :bigint           not null, primary key
#  title         :string
#  description   :string
#  custom_action :string
#  webhook_id    :bigint           not null
#  category      :string
#  input_dict    :jsonb
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  position      :integer
require 'capybara/rails'
class CustomAction
  class Script < ::CustomAction
    store_accessor :input_dict, :script_content, :from_variable, :target_variable

    def execute(original_params, custom_params = {})
      @original_params = original_params
      @custom_params = custom_params

      Capybara.default_driver = :selenium_chrome_headless # :selenium_chrome and :selenium_chrome_headless
      Capybara.visit('http://ohio.ce04.com') # 先跳转到某个页面
      page = Capybara.page

      # 将变量直接插入到window对象中,变成全局变量
      page.evaluate_script(<<~JS, @original_params)
        (() => { window.params = #{@original_params.to_json} })()
      JS

      answer = page.evaluate_script(<<~JS)
        (function () {
          #{original_params[:script_content] || script_content}
        })()
      JS
      answer
    rescue Selenium::WebDriver::Error::WebDriverError => e
        { jserror: e}
    rescue => e
       { error: e}
    end
  end
end
