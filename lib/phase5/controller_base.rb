require_relative '../phase4/controller_base'
require_relative './params'

module Phase5
  class ControllerBase < Phase4::ControllerBase
    include Phase5
    attr_reader :params

    # setup the controller
    def initialize(req, res, route_params = {})
      @req = req
      @res = res
      @params = Phase5::Params.new(@req, route_params)
    end
  end
end
