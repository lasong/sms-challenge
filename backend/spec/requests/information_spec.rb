require 'rails_helper'

RSpec.describe 'Information', type: :request do
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

  describe 'GET /information/:id' do
    it 'returns information for given id' do
      id = Information.first.id

      get "/information/#{id}"

      expect(response).to be_success
      expect(json_response['city']).to eq 'Buea'
      expect(json_response['start_date']).to eq '2019-03-29'
      expect(json_response['end_date']).to eq '2019-05-29'
      expect(json_response['price']).to eq 45.64
      expect(json_response['status']).to eq 'Weekly'
      expect(json_response['color']).to eq '#800080'
    end

    it 'returns 404 response status if information does not exist' do
      id = Information.first.id

      get "/information/#{id + 42}"

      expect(response).to have_http_status(:missing)
    end
  end

  describe 'POST /information' do
    it 'creates information and returns created information' do
      params = { information: attributes.merge(city: 'Tiko', price: 6.8) }
      post '/information', params: params

      expect(response).to have_http_status(:created)
      expect(json_response['id']).to_not be_nil
      expect(json_response['city']).to eq 'Tiko'
      expect(json_response['price']).to eq 6.8
    end

    context 'errors' do
      it 'does not create information if attributes are not valid' do
        params = { information: attributes.merge(status: nil) }

        expect { post '/information', params: params }.to_not change(Information, :count)
      end

      it 'returns unprocessable entity status code if attributes are not valid' do
        params = { information: attributes.merge(color: 'color') }
        post '/information', params: params

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'PUT /information/:id' do
    before { @id = Information.first.id }

    it 'updates information and returns updated information' do
      put "/information/#{@id}", params: { information: { city: 'Fontem' } }

      expect(response).to be_success
      expect(json_response['city']).to eq 'Fontem'
    end

    context 'errors' do
      it 'does not change information if attributes are not valid' do
        put "/information/#{@id}", params: { information: { city: nil } }

        expect(Information.first.city).to eq 'Buea'
      end

      it 'returns unprocessable entity status code if attributes are not valid' do
        put "/information/#{@id}", params: { information: { end_date: nil } }

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'DELETE /information/:id' do
    before { @id = Information.first.id }

    it 'deletes information for given id' do
      expect{ delete "/information/#{@id}" }.to change(Information, :count).by(-1)
    end

    it 'returns delete success message' do
      delete "/information/#{@id}"

      expect(response).to be_success
      expect(json_response['message']).to eq 'Information successfully deleted'
    end

    it 'returns 404 response status if information does not exist' do
      delete "/information/#{@id + 42}"

      expect(response).to have_http_status(:missing)
    end
  end
end
