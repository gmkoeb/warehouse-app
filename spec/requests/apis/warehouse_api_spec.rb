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
    end
  end
end