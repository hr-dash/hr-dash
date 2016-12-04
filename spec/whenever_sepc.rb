describe Whenever do
  include Shoulda::Whenever

  let(:whenever) do
    Whenever::JobList.new(file: Rails.root.join('config', 'schedule.rb').to_s)
  end

  describe 'EndOfMonthNotice' do
    it { expect(whenever).to schedule_rake('end_of_month_notice:execute').every('0 18 25 * *') }
  end
end
