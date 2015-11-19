require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the MonthlyReportsHelper. For example:
#
# describe MonthlyReportsHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe MonthlyReportsHelper, type: :helper, monthly_reports: true do
end
