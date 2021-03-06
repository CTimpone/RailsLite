require 'uri'

module Phase5
  class Params

    def initialize(req, route_params = {})
      if route_params.is_a?(Hash)
        @params = route_params
      else
        @params = {}
        parse_www_encoded_form(route_params)
      end
      parse_www_encoded_form(req.query_string)
      parse_www_encoded_form(req.body)
    end

    def [](key)
      @params[key.to_s]
    end

    def to_s
      @params.to_json.to_s
    end

    class AttributeNotFoundError < ArgumentError; end;

    private
    # this should return deeply nested hash
    # argument format
    # user[address][street]=main&user[address][zip]=89436
    # should return
    # { "user" => { "address" => { "street" => "main", "zip" => "89436" } } }
    def parse_www_encoded_form(www_encoded_form)
      unless www_encoded_form.nil?
        queries = URI::decode_www_form(www_encoded_form)
      else
        queries = []
      end
      queries.each do |key, val|
        parsed = parse_key(key)
        parsed += [val]
        parsed.flatten
        h = parsed.reverse.inject {|a, n| {n => a}}
        @params = h.deep_merge(@params)
      end unless queries.empty?
    end

    # this should return an array
    # user[address][street] should return ['user', 'address', 'street']
    def parse_key(key)
      key.split(/\]\[|\[|\]/)
    end
  end
end
