module IdentityMap
  class Map
    def initialize
      @entities = {}
    end

    def fetch(type, id) = @entities[[type, id]] ||= yield

    def delete(type, id) = @entities.delete([type, id])

    def register(type, entity) = @entities[[type, entity.id]] = entity

    def clean = @entities = {}
  end

  class RackMiddleware
    def initialize(app, *args, &block)
      @app = app
      @args = args
      @block = block
    end

    def call(env)
      identity_map.clean
      @app.(env)
    end

    def identity_map = DependenciesContainer.resolve(:identity_map)
  end
end

