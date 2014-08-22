require "securerandom"
require "lotus/utils/hash"
require "json"

module Lotus
  module Model
    module Adapters
      module Redis
        class Collection
          def initialize(client, name, identity)
            @client, @name, @identity = client, name, identity
          end

          def create(entity)
            id = entity[@identity] = SecureRandom.uuid

            _set(id, entity)

            id
          end

          def update(entity)
            _set(entity[@identity], entity)
          end

          def delete(entity)
            @client.del(entity.id)
          end

          def clear
            @client.flushdb
          end

          def get(id)
            _deserialize_item(@client.get(id))
          end

          private

          def _set(id, entity)
            @client.set(id, entity.to_json)
          end

          def _deserialize_item(item)
            Lotus::Utils::Hash.new(JSON.parse(item)).symbolize!
          end
        end
      end
    end
  end
end
