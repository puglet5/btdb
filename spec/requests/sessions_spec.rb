# frozen_string_literal: true

RSpec.describe 'Sessions' do
  let(:user) { create(:user) }

  it 'signs user in and out' do
    sign_in user
    get root_path
    expect(response.status)
      .to eq(200)

    sign_out user
    get root_path
    expect(response.status)
      .to eq(302)
  end

  it 'checks the presence of current_user' do
    sign_in user
    get root_path
    expect(controller.current_user)
      .to eq(user)

    sign_out user
    get root_path
    expect { controller.current_user }
      .to raise_error(NoMethodError)
  end
end
