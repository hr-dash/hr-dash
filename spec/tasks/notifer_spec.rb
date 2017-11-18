# frozen_string_literal: true

describe 'notifer' do
  describe 'report_registrable' do
    let(:task) { Rake::Task['notifer:report_registrable'] }
    let(:freeze) { ->(day) { Timecop.freeze(Time.new(year, month, day, 0, 0, 0, '+00:00')) } }
    let(:year) { 2017 }

    before do
      ActionMailer::Base.deliveries.clear
    end

    after { Timecop.return }

    shared_examples 'registrable' do |day|
      it "day #{day} is registrable day." do
        freeze.call(day)
        expect { task.invoke }.to change { ActionMailer::Base.deliveries.count }.from(0).to(1)
      end
    end

    shared_examples 'not registrable' do |day|
      it "day #{day} is not registrable day." do
        freeze.call(day)
        expect { task.invoke }.not_to change { ActionMailer::Base.deliveries.count }
      end
    end

    context 'if end of month is 31' do
      let(:month) { 1 }

      it_behaves_like 'registrable', 27
      it_behaves_like 'not registrable', 26
      it_behaves_like 'not registrable', 28
    end

    context 'if end of month is 30' do
      let(:month) { 4 }

      it_behaves_like 'registrable', 26
      it_behaves_like 'not registrable', 25
      it_behaves_like 'not registrable', 27
    end

    context 'if end of month is 29' do
      let(:year) { 2016 }
      let(:month) { 2 }

      it_behaves_like 'registrable', 25
      it_behaves_like 'not registrable', 24
      it_behaves_like 'not registrable', 26
    end

    context 'if end of month is 28' do
      let(:month) { 2 }

      it_behaves_like 'registrable', 24
      it_behaves_like 'not registrable', 23
      it_behaves_like 'not registrable', 25
    end
  end
end
