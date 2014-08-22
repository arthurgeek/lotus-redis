require "redis"
require "lotus/model/adapters/abstract"
require "lotus/model/adapters/implementation"
require "lotus/model/adapters/redis/query"
require "lotus/model/adapters/redis/command"
require "lotus/model/adapters/redis/collection"

module Lotus
  module Model
    module Adapters
      class RedisAdapter < Abstract
        include Implementation

        attr_accessor :client

        def initialize(mapper, url=nil)
          super(mapper)

          @client = ::Redis.new(url: url)

          @collections = {}
        end

        def create(collection, entity)
          entity.id = command(collection).create(entity)
          entity
        end

        def update(collection, entity)
          command(collection).update(entity)
        end

        def delete(collection, entity)
          command(collection).delete(entity)
        end

        def clear(collection)
          command(collection).clear
        end

        def find(collection, id)
          command(collection).get(id)
        end

        def first(collection)
          raise NotImplementedError
        end

        def last(collection)
          raise NotImplementedError
        end

        def command(collection)
          Redis::Command.new(
            _collection(collection), _mapped_collection(collection)
          )
        end

        def query(collection, context = nil, &blk)
          Redis::Query.new(
            _collection(collection), _mapped_collection(collection), &blk
          )
        end

        private

        def _collection(name)
          @collections[name] ||= Redis::Collection.new(
            @client, name, _identity(name)
          )
        end
      end
    end
  end
end
