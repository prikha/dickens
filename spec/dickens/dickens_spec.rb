#coding:utf-8
require 'spec_helper'

describe Dickens::StarDict do
  it "should get the result" do
    Dickens::StarDict.find("петля").should_not be_nil
  end

  it "should list the dictionaries" do
    Dickens::StarDict.list.should be_a(Array)
    Dickens::StarDict.list.count.should be Dickens::StarDict.list.compact.count
    Dickens::StarDict.list.first.should be_a(Dickens::ListItem)
  end
end