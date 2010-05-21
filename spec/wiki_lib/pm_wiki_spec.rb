#!/usr/bin/ruby
# Jonathan D. Stott <jonathan.stott@gmail.com>
require 'spec_helper'
require 'wiki_lib/pm_wiki'

describe "WikiLib::PMWiki" do
  before do
    @wiki = WikiLib::PMWiki.new('http://example.com', 'user', 'password')
  end

  it "gives a correct page_url" do
    @wiki.page_url('Home').should == "http://example.com/Home"
  end

  it "gives a correct edit_url" do
    @wiki.edit_url('Home').should == "http://example.com/Home?action=edit"
  end
end

