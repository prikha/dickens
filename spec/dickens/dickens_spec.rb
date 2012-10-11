#coding:utf-8
require 'spec_helper'

describe Dickens::StarDict do
  it "should FIND the result" do
    Dickens::StarDict.find("петля").should_not be_nil
    Dickens::StarDict.find("петля").should be_a(Array)
    Dickens::StarDict.find("петля").first.should be_a(Dickens::FindItem)
  end

  if "should return NIL if nothing was found"
    Dickens::StarDict.find("wrong_string_query").should be_nil
  end


  it "should LIST the dictionaries" do
    Dickens::StarDict.list.should be_a(Array)
    Dickens::StarDict.list.count.should be Dickens::StarDict.list.compact.count
    Dickens::StarDict.list.first.should be_a(Dickens::ListItem)
  end
end

describe Dickens::FindItem do
  before do
    @item=Dickens::StarDict.find("петля").first
  end
  it { @item.should respond_to(:dictionary)}
  it { @item.should respond_to(:word)}
  it { @item.should respond_to(:article)}
  it { @item.should respond_to(:matching)}
end
