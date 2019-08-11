#spec/integration/languages_spec.rb
require 'swagger_helper'

describe 'Reports API' do

  path '/api/authenticate' do

    post 'Authentificate' do
      tags 'Authentification'
      consumes 'application/json'
      parameter name: :credentials, in: :body, schema: {
        type: :object,
        properties: {  
          credentials: {
            type: :object,
            properties: {
              email: { type: :string },
              password: { type: :string }
            }
          }
        }
      }

      response '201', 'Authentificated' do
        run_test!
      end

      response '422', 'invalid request' do
        run_test!
      end
    end
  end

  path '/api/' do

    post 'Creates a report' do
      tags 'Reports'
      consumes 'application/json'
      security [Bearer: {}]
      parameter name: :report, in: :body, schema: {
        type: :object,
        properties: {
          hours: { type: :string },
          project_id: { type: :string }
        },
        required: [ 'hours', 'project_id', 'user_id' ]
      }

      response '201', 'report created' do
        run_test!
      end

      response '422', 'invalid request' do
        run_test!
      end
    end
  end

  path '/api/reports' do


    get 'Retrieves all reports' do
      tags 'Reports'
      security [Bearer: {}]
      produces 'application/json'

      response '200', 'reports found' do
        run_test!
      end

      response '404', 'reports not found' do
        run_test!
      end
    end
  end
end