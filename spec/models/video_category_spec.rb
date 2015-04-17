require 'spec_helper'

describe VideoCategory do
  it { should belong_to(:video) }
  it { should belong_to(:category) }
end