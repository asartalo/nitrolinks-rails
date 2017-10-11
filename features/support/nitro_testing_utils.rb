module NitroTestingUtils
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

  def nitro_page(name)
    NitroSpecs::Pages.send("#{ name }_page")
  end

  def nitro_page_content(name)
    NitroSpecs::Pages.send("#{ name }_page_content")
  end

  def expect_nitro_page_fetched(name)
    expect_nitro_page(name, 'isPageFetched')
  end

  def expect_nitro_page_loaded(name)
    expect_nitro_page(name, 'isPageNormallyLoaded')
  end

  def expect_nitro_page_restored(name)
    expect_nitro_page(name, 'isPageCacheRestored')
  end

  def expect_page_content_to_be_loaded(name)
    expect(page).to have_text(nitro_page_content(name) || "")
  end

  def expect_no_js_errors
    expect_script("nitroTesting.hasJavascriptErrors()").to eql(false)
  end

  def expect_nitro_load_count
    expect_script("nitroTesting.loadCount", :to_i)
  end

  private

  def expect_nitro_page(name, function)
    path = nitro_page(name)
    expect_script("nitroTesting.#{function}('#{path}')")
  end
end

World(NitroTestingUtils)
