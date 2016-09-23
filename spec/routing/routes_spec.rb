describe 'Routing', type: :routing do
  describe '/monthly_reports/?page=:page' do
    let(:page_count_limit) { Constraints::PageCount::PAGE_COUNT_LIMIT }

    context 'page count less than 100_000' do
      it { expect(get: monthly_reports_path(page: page_count_limit - 1)).to be_routable }
    end

    context 'page count greater than or equal to 100_000' do
      it { expect(get: monthly_reports_path(page: page_count_limit)).not_to be_routable }
    end
  end

  describe '/monthly_reports/user/:user_id' do
    let(:user_id_limit) { 1_000_000 }

    context 'user_id less than 1_000_000' do
      it { expect(get: user_monthly_reports_path(user_id: user_id_limit - 1)).to be_routable }
    end

    context 'user_id greater than or equal 1_000_000' do
      it { expect(get: user_monthly_reports_path(user_id: user_id_limit)).not_to be_routable }
    end
  end

  describe '/monthly_reports/user/:user_id?target_year=:target_year' do
    let(:user) { create(:user) }
    let(:years_lower_limit) { Constraints::MonthlyReport::YEARS_LOWER_LIMIT }
    let(:years_upper_limit) { Constraints::MonthlyReport::YEARS_UPPER_LIMIT }

    context 'target_year between 2000 and 2099' do
      it { expect(get: user_monthly_reports_path(user, target_year: years_lower_limit)).to be_routable }
      it { expect(get: user_monthly_reports_path(user, target_year: years_upper_limit - 1)).to be_routable }
    end

    context 'target_year not between 2000 and 2099' do
      it { expect(get: user_monthly_reports_path(user, target_year: years_lower_limit - 1)).not_to be_routable }
      it { expect(get: user_monthly_reports_path(user, target_year: years_upper_limit)).not_to be_routable }
    end
  end
end
