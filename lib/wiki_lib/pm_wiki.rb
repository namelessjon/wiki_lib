require 'mechanize'

module WikiLib
  ##
  # Class for interacting with the PMWiki
  class PMWiki
    ##
    # Initializes a new PMWiki instance
    #
    # @param [String] base_page The base page of the wiki.  Probably it's address, but could be a subset of the namespace
    #
    # @param [String] username Username used to sign off the edits
    #
    # @param [String] password Password used to make edits
    def initialize(base_page, username, password)
      @base = base_page
      @pass = password
      @user = username
      @agent = ::Mechanize.new
    end

    ##
    # returns a PMWiki page url
    #
    # @param [String] page The name of the page, relative to the base page
    #
    # @return [String] The URL
    def page_url(page)
    "#{@base}/#{page}"
    end

    ##
    # returns a PMWiki page edit url
    #
    # @param [String] page The name of the page, relative to the base page
    #
    # @return [String] The URL
    def edit_url(page)
    "#{page_url(page)}?action=edit"
    end

    ##
    # Returns the edit text of a PMWiki page
    #
    # @param [String] page The page to get the edit text for
    #
    # @return [String] The edit text
    def get_edit_text(page)
      # get the form, logging in if nessessary
      form = get_edit_form_with_login(edit_url(page))

      # return the text
      form['text']
    end

    ##
    # Returns the full page, parsed by hpricot
    #
    # @param [String] page Page to retrieve the raw text for
    #
    # @return [Hpricot::Doc] The parsed page
    def get_page(page)
      @agent.get(page_url(page))
    end

    ##
    # Uploads a page to the PM wiki, creating it if needed
    #
    # @param [String] page Page to create/update
    #
    # @param [String] text Text to place on the new page
    #
    # @param [String] summary Edit summary for the edit
    #
    # @param [TrueClass, FalseClass] minor tick the minor edit checkbox?
    def upload_page(page, text, summary, minor=false)
      # get the form, logging in if nessessary
      form = get_edit_form_with_login(edit_url(page))

      # fill out our form
      form['text']    = text
      form['csum']    = summary
      form['author']  = @user

      edit.checkboxes.first.check if minor

      # upload
      @agent.submit(form, form.buttons.first)
    end

    ##
    # Deletes a PMWiki page (sets text to delete)
    #
    # @param [String] page The page to delete
    #
    # @param [String] summary The reason for deletion
    def delete_page(page, summary)
      upload_page(page, 'delete', summary)
    end

    protected
    def get_edit_form_with_login(url)
      # fetch the page
      page = @agent.get(url)

      # if we find an authform, we are not logged in.
      if form = page.forms.find { |f| f.name == 'authform' }
        # fill in the password and submit
        form['authpw'] = @pass
        page = @agent.submit(form, form.buttons.first)

        # if we still have an auth form, we're in trouble
        raise(StandardError, "Authentication Failed") if page.forms.find { |f| f.name == 'authform' }
      end

      # by now, this should be the right page, so find the last form on it!
      page.forms.last
    end
  end
end
