module Lotus
  module Model
    module Adapters
      module Redis
        class Query
          def initialize(dataset, collection, &blk)
            @dataset    = dataset
            @collection = collection

            instance_eval(&blk) if block_given?
          end

          def all
            raise NotImplementedError
          end

          def where(condition)
            raise NotImplementedError
          end
        end
      end
    end
  end
end
