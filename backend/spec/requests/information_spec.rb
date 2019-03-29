require 'rails_helper'

RSpec.describe 'Consultations', type: :request do
  let(:attributes) do
    {
      city: 'Buea',
      start_date: Date.new(2019, 3, 29),
      end_date: Date.new(2019, 5, 29),
      price: 45.64,
      status: 'Weekly',
      color: '#800080'
    }
  end

  before do
    Information.create!(attributes)
  end

  describe 'GET /information' do
    it 'returns all information' do
      get '/information'

      expect(response).to be_success
      expect(json_response.length).to eq 1

      result = json_response[0]
      expect(result['city']).to eq 'Buea'
      expect(result['start_date']).to eq '2019-03-29'
      expect(result['end_date']).to eq '2019-05-29'
      expect(result['price']).to eq 45.64
      expect(result['status']).to eq 'Weekly'
      expect(result['color']).to eq '#800080'
    end

    it 'returns empty array if no information available' do
      Information.destroy_all

      get '/information'

      expect(response).to be_success
      expect(json_response.length).to eq 0
    end

    context 'search by date range' do
      before { Information.create(attributes.merge(start_date: Date.new(2019, 3, 2))) }

      it 'return empty array for date range between 2019-02-26 and 2019-03-01' do
        get '/information?start_date=2019-02-26&end_date=2019-03-01'

        expect(response).to be_success
        expect(json_response.length).to eq 0
      end

      it 'return correct information for date range between 2019-03-26 and 2019-05-29' do
        get '/information?start_date=2019-03-26&end_date=2019-05-29'

        expect(response).to be_success
        expect(json_response.length).to eq 1

        result = json_response[0]
        expect(result['start_date']).to eq '2019-03-29'
        expect(result['end_date']).to eq '2019-05-29'
      end

      it 'return correct information for date range between 2019-02-26 and 2019-05-29' do
        get '/information?start_date=2019-02-26&end_date=2019-05-29'

        expect(response).to be_success
        expect(json_response.length).to eq 2
      end
    end
  end
end
