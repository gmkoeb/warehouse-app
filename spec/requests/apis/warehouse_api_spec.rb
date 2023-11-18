require 'rails_helper'

describe 'Warehouse API' do
  context 'GET /api/v1/warehouses/1' do
    it 'sucess' do
      # Arrange
      warehouse = Warehouse.create!(name: 'Guarulhos Aeroporto', code: 'GRU', city: 'Guarulhos', 
                                  area:60_000, address: 'Rua do aeroporto, 3102', 
                                  cep: '31412', description: 'Galpão localizado no aeroporto de Guarulhos' )
      # Act
      get "/api/v1/warehouses/#{warehouse.id}"

      # Assert
      expect(response.status).to eq 200  
      expect(response.content_type).to include 'application/json' 
      json_response = JSON.parse(response.body)
      expect(json_response["name"]).to include('Guarulhos Aeroporto')       
      expect(json_response["code"]).to include('GRU')
      expect(json_response.keys).not_to include("created_at")
      expect(json_response.keys).not_to include("updated_at")                   
    end

    it 'fail if warehouse not found' do
      # Arrange

      # Act
      get "/api/v1/warehouses/1847755553"

      # Assert
      expect(response.status).to eq 404
    end
  end

  context 'GET /api/v1/warehouses' do
    it 'list all warehouses ordered by name' do
      # Arrange
      Warehouse.create(name: 'Maceio', code: 'MCZ', city: 'Maceio', 
                       area:50_000, address: 'Rua do Aeroporto, 20', 
                       cep: '73521', description: 'Galpão localizado no aeroporto de Maceio.')
      Warehouse.create!(name: 'Guarulhos Aeroporto', code: 'GRU', city: 'Guarulhos', 
                        area:60_000, address: 'Rua do aeroporto, 3102', 
                        cep: '31412', description: 'Galpão localizado no aeroporto de Guarulhos' )
      # Act
      get "/api/v1/warehouses"                 
      # Assert
      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json'
      json_response = JSON.parse(response.body)
      expect(json_response.class).to eq Array
      expect(json_response.length).to eq 2
      expect(json_response[0]["name"]).to eq 'Guarulhos Aeroporto'
      expect(json_response[1]["name"]).to eq 'Maceio'
    end

    it 'return empty if theres no warehouse' do
      # Arrange
      # Act
      get "/api/v1/warehouses"                 
      # Assert
      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json'
      json_response = JSON.parse(response.body)
      expect(json_response.class).to eq Array
      expect(json_response).to eq []
    end
  end

  context 'POST /api/v1/warehouses' do
    it 'success' do
      # Arrange
      warehouse_params = { warehouse: { name: 'Galpão Maceio Aeroporto', code: 'MCZ', city: 'Maceio', 
                                        area:50_000, address: 'Rua do Aeroporto, 20', 
                                        cep: '73521', description: 'Galpão localizado no aeroporto de Maceio.' } }
      # Act
      post '/api/v1/warehouses', params: warehouse_params
      # Assert
      expect(response).to have_http_status 201
      expect(response.content_type).to include 'application/json'
      json_response = JSON.parse(response.body)                                      
      expect(json_response["name"]).to eq ('Galpão Maceio Aeroporto')
      expect(json_response["code"]).to eq ('MCZ')
      expect(json_response["city"]).to eq ('Maceio')
      expect(json_response["area"]).to eq (50_000)
      expect(json_response["address"]).to eq ('Rua do Aeroporto, 20')
      expect(json_response["cep"]).to eq ('73521')
      expect(json_response["description"]).to eq ('Galpão localizado no aeroporto de Maceio.')
    end

    it 'fails if parameters are not complete' do
      # Arrange
      warehouse_params = { warehouse: { name: '', code: 'MCZ', city: 'Maceio', 
                                        area:50_000, address: 'Rua do Aeroporto, 20', 
                                        cep: '73521', description: 'Galpão localizado no aeroporto de Maceio.' } }
      # Act
      post '/api/v1/warehouses', params: warehouse_params
      # Assert
      expect(response).to have_http_status 412
      expect(response.content_type).to include 'application/json'
      json_response = JSON.parse(response.body)                                      
      expect(json_response["errors"]).to include ('Nome não pode ficar em branco')
    end

    it 'fails if theres an internal error' do
      # Arrange
      allow(Warehouse).to receive(:new).and_raise(ActiveRecord::ActiveRecordError)

      warehouse_params = { warehouse: { name: 'Galpão Aeroporto Macéio', code: 'MCZ', city: 'Maceio', 
                                        area:50_000, address: 'Rua do Aeroporto, 20', 
                                        cep: '73521', description: 'Galpão localizado no aeroporto de Maceio.' } }
      # Act
      post '/api/v1/warehouses', params: warehouse_params
      # Assert
      expect(response).to have_http_status 500
    end
  end
end