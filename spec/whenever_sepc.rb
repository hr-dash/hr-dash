describe Whenever do
  let(:whenever) do
    Whenever::JobList.new(file: Rails.root.join('config', 'schedule.rb').to_s)
  end

  describe 'EndOfMonthNotice' do
    it { expect(whenever).to schedule_rake('end_of_month_notice:execute').every(1.month).at('18:00 pm') }
  end
end
