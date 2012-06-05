Given /^i have a key "([^"]*)"$/ do |key|
    @key = key
end

Given /^i have a value "([^"]*)"$/ do |value|
    @value = value
end

When /^I store them in Nyx's Memory$/ do
    Nyx::Memory.store key => value
end

Then /^i should be able to retrive "([^"]*)" with the key "([^"]*)"$/ do |value, key|
    Nyx::Memory.retrieve(key).should eql(value)
end
