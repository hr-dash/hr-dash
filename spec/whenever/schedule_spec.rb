describe Whenever do
  include Shoulda::Whenever

  let(:whenever) do
    Whenever::JobList.new(file: Rails.root.join('config', 'schedule.rb').to_s)
  end

  describe 'EndOfMonthNotice' do
    it { expect(whenever).to schedule_rake('report_registrable_to:execute').every('0 12 23-26 * *') }
  end
end
