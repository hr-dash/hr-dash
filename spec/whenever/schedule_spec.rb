# frozen_string_literal: true

describe Whenever do
  include Shoulda::Whenever

  let(:whenever) do
    Whenever::JobList.new(file: Rails.root.join('config', 'schedule.rb').to_s)
  end

  describe 'Notice report registrable' do
    it { expect(whenever).to schedule_rake('notifer:report_registrable').every('0 12 24-27 * *') }
  end
end
