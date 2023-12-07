# frozen_string_literal: true

# == Schema Information
#
# Table name: spectra
#
#  category           :integer
#  created_at         :datetime         not null
#  filename           :string
#  format             :integer          default("not_set"), not null
#  id                 :bigint           not null, primary key
#  is_reference       :boolean          default(FALSE), not null
#  measurement_id     :bigint           not null, indexed
#  metadata           :jsonb            not null, indexed
#  processing_message :text
#  sample_thickness   :float
#  status             :integer          default("none"), not null
#  updated_at         :datetime         not null
#  user_id            :bigint           not null, indexed
#
# Indexes
#
#  index_spectra_on_measurement_id  (measurement_id)
#  index_spectra_on_metadata        (metadata) USING gin
#  index_spectra_on_user_id         (user_id)
#
# Foreign Keys
#
#  fk_rails_7788863ffe  (measurement_id => measurements.id)
#
RSpec.describe Spectrum, type: :model do
  let(:user) { create(:user) }
  let(:measurement) { create(:measurement) }

  let(:valid_attributes) do
    { 'measurement_id' => measurement.id,
      'user_id' => user.id,
      'metadata' => '{}' }
  end

  let(:valid_spectrum) { build(:spectrum, user: user, measurement: measurement) }

  before(:each) do
    valid_spectrum.file.delete
    valid_spectrum.processed_file.delete
  end

  describe 'Field presence validations' do
    it 'is valid with valid attributes' do
      spectrum = described_class.new valid_attributes
      expect(spectrum).to be_valid
    end

    it 'has an existing associated user' do
      expect(valid_spectrum.user_id).not_to eq(nil)
    end

    it 'has a parsed metadata' do
      valid_spectrum.save!
      expect(valid_spectrum.metadata).to be_a(Hash)
    end

    it 'has no attachments by default' do
      valid_spectrum.save!
      expect(valid_spectrum.file.attached?).to eq(false)
      expect(valid_spectrum.processed_file.attached?).to eq(false)
    end
  end

  describe 'acquisition method inference' do
    let!(:ftir_dpt_spectrum) { create(:spectrum, :with_file, file: 'ftir.dpt') }
    let!(:raman_txt_spectrum) { create(:spectrum, :with_file, file: 'raman.txt') }
    let!(:thz_txt_spectrum) { create(:spectrum, :with_file, file: 'thz.txt') }

    it 'infers .dpt ftir files' do
      ftir_dpt_spectrum.reload
      expect(ftir_dpt_spectrum.category).to eq('ftir')
    end

    it 'infers .txt raman files' do
      raman_txt_spectrum.reload
      expect(raman_txt_spectrum.category).to eq('raman')
    end

    it 'infers .txt thz files' do
      thz_txt_spectrum.reload
      expect(thz_txt_spectrum.category).to eq('thz')
    end
  end

  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:measurement) }
  end
end
