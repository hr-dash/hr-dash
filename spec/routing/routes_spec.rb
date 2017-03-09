# frozen_string_literal: true
describe 'Routing', type: :routing do
  describe '/monthly_reports/?page=:page' do
    let(:page_count_limit) { Constraints::PageCount::PAGE_COUNT_LIMIT }

    context 'page count less than or equal to PAGE_COUNT_LIMIT' do
      it { expect(get: "/monthly_reports?page=#{page_count_limit}").to be_routable }
    end

    context 'page count greater than PAGE_COUNT_LIMIT' do
      it { expect(get: "/monthly_reports?page=#{page_count_limit + 1}").not_to be_routable }
    end
  end

  describe '/monthly_reports/user/:user_id' do
    let(:user_id_limit) { 999_999 }

    context 'digits of the user_id is less than or equal 6' do
      it { expect(get: "/monthly_reports/users/#{user_id_limit}").to be_routable }
    end

    context 'digits of the user_id is greater than 6' do
      it { expect(get: "/monthly_reports/users/#{user_id_limit + 1}").not_to be_routable }
    end
  end

  describe '/monthly_reports/user/:user_id?target_year=:target_year' do
    let(:user) { create(:user) }
    let(:years_lower_limit) { Constraints::TargetYear::YEARS_LOWER_LIMIT }
    let(:years_upper_limit) { Constraints::TargetYear::YEARS_UPPER_LIMIT }

    context 'target_year between YEARS_LOWER_LIMIT and YEARS_UPPER_LIMIT' do
      it { expect(get: "/monthly_reports/users/#{user.id}?target_year=#{years_lower_limit}").to be_routable }
      it { expect(get: "/monthly_reports/users/#{user.id}?target_year=#{years_upper_limit}").to be_routable }
    end

    context 'target_year not between YEARS_LOWER_LIMIT and YEARS_UPPER_LIMIT' do
      it { expect(get: "/monthly_reports/users/#{user.id}?target_year=#{years_lower_limit - 1}").not_to be_routable }
      it { expect(get: "/monthly_reports/users/#{user.id}?target_year=#{years_upper_limit + 1}").not_to be_routable }
    end
  end
end
