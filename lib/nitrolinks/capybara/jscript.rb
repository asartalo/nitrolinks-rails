module Nitrolinks
  module Capybara
    module Jscript
      def jscript(code)
        page.evaluate_script(code)
      end

      def expect_script(code, filter = nil)
        result = jscript(code)
        if filter
          result = result.send(filter)
        end
        expect(result)
      end
    end
  end
end

